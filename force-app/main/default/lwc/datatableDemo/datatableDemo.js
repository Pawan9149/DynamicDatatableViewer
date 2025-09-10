import { LightningElement, track, wire } from 'lwc';
import getContacts from '@salesforce/apex/contactDatatableDemo.getContacts';
import updateContacts from '@salesforce/apex/contactDatatableDemo.updateContacts';
import createContact from '@salesforce/apex/contactDatatableDemo.createContact';
import deleteRecords from '@salesforce/apex/contactDatatableDemo.deleteRecords';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';


const actions = [
    { label: 'Edit', name: 'edit' },
    { label: 'Delete', name: 'delete' }
];

export default class DatatableDemo extends LightningElement {

    @track columns = [
        {label : 'First Name', fieldName : 'FirstName', editable: true},
        {label : 'Last Name', fieldName : 'LastName', editable: true},
        // {label : 'Account Name', fieldName : 'AccountName', editable: true},
        {
            label: 'Account Names',
            fieldName: 'AccountName',
            type: 'Picklist',
            typeAttributes: {
                options: { fieldName: 'picklistOptions' },
                value: { fieldName: 'AccountName' },
                rowKeyValue: { fieldName: 'Id' }
            },
            editable: true
        },
        {label : 'Title', fieldName : 'Title', editable: true},
        {label : 'Phone', fieldName : 'Phone', editable: true},
        {label : 'Email', fieldName : 'Email', editable: true},
        {
        type: 'action',
        typeAttributes: { rowActions: actions },
        }
    ];
    @track data = [];
    @track paginatedData = [];
    @track draftValues = [];
    error;
    refreshContactsApex;


    openModal = false;
    updateModalData = false;
    selectedRows = [];

    @track Contact = {
        FirstName : '',
        AccountId : '',
        LastName : '',
        Title : '',
        Email : ''
    };

    currentPage = 1;
    pageSize = 10;
    totalPages = 0;

    isLoading = false;


    @wire(getContacts)
    wiredContacts(result){
        this.refreshContactsApex = result;
        if(result.data){
            this.totalPages = Math.ceil( result.data.length / this.pageSize );
            this.data = result.data.map(record=>({
                ...record,
                AccountName: record.Account ? record.Account.Name : ''
            }));
            this.updatePaginatedData();
        }
        else if(result.error){
            this.showToastMessage('Error', 'Error fetching records', 'error');
        }
    }

    updatePaginatedData(){
        const start = ( this.currentPage - 1 ) * this.pageSize;
        const end = start + this.pageSize;
        this.paginatedData = this.data.slice(start, end);
    }

    handlePrevious(){
        if(this.currentPage > 1){
            this.currentPage-- ;
            this.updatePaginatedData();
        }
    }

    handleNext(){
        if(this.currentPage < this.totalPages){
            this.currentPage++ ;
            this.updatePaginatedData();
        }
    }

    get isPreviousDisabled(){
        return this.currentPage === 1;
    }

    get isNextDisabled(){
        return this.currentPage === this.totalPages;
    }

    handleSave(event){
        this.draftValues = event.detail.draftValues;
        this.updateRecords(this.draftValues);
        
    }
    
    updateRecords(draftValues){
        this.isLoading = true;
        updateContacts({contactRecords: draftValues})
        .then( result => {
            if(result === 'Success'){
                this.showToastMessage('Success', 'Contacts Updated Successfully', 'success');
            }
            else{
                this.showToastMessage('Error', result, 'error');
            }
            if(this.updateModalData === true){
                this.handleCloseModal();
                this.updateModalData = false;
            }
            return refreshApex(this.refreshContactsApex);
        })
        .catch(error => {
            this.showToastMessage('Error updating records', error.body.message, 'error');
        })
        .finally(() => {
            this.isLoading = false;
        });
        this.draftValues = [];
    }

    handleNewContactButton(){
        this.openModal = true;
    }

    handleCloseModal(){
        this.openModal = false;
        this.resetFields();
    }

    handleFirstName(event){
        this.Contact.FirstName = event.target.value;
    }

    handleLastName(event){
        this.Contact.LastName = event.target.value;
    }

    handleTitle(event){
        this.Contact.Title = event.target.value;
    }

    handleEmail(event){
        this.Contact.Email = event.target.value;
    }

    handleAccountId(event){
        const field = event.target.dataset.Id || event.target.fieldName;
        let value = event.target.value;
        this.Contact[field] = value;
    }

    handleCreate(){
        if(this.Contact.LastName === ''){
            this.showToastMessage('Error inserting records', 'Last Name is mandatory!', 'error');
            return;
        }
        
        if(this.updateModalData === true){
            let contact = [];
            contact.push(this.Contact);
            this.updateRecords(contact);
            
        }else{
            this.createContact(this.Contact);
        }   

    }

    createContact(Contact){
        this.isLoading = true;
        createContact({contact : Contact})
        .then(() => {
            this.showToastMessage('Success', 'Contacts Inserted Successfully', 'success');
            return refreshApex(this.refreshContactsApex);
        })
        .catch(error => {
            this.showToastMessage('Error inserting records', 'Cannot Insert Record', 'error');
        })
        .finally(() => {
            this.isLoading = false;
        });
        this.openModal = false;
        this.resetFields();
    }

    handleRowSelection(event){
        this.selectedRows = event.detail.selectedRows;
    }

    handleDelete(){
        this.deleteRecords(this.selectedRows);
    }

    deleteRecords(selectedRows){
        if(selectedRows.length > 0){
            this.isLoading = true;
            deleteRecords({contactDeletedRecords : selectedRows})
            .then(result => {
                if(result === 'Success'){
                    this.showToastMessage('Success', 'Contacts Deleted Successfully', 'success');
                    
                    return refreshApex(this.refreshContactsApex);
                }else{
                    this.showToastMessage('Error deleting records', result, 'error');
                }
                this.selectedRows = [];

            })
            .catch(error => {
                this.showToastMessage('Error deleting records', 'Cannot Delete Record', 'error');
            })
            .finally(()=>{
                this.isLoading = false;
            });
        }else{
            this.showToastMessage('Delete Records', 'Select Records to Delete', 'warning');
        }

    }

    handleOnRowAction(event){
        const actionName = event.detail.action.name;
        const contact = event.detail.row;

        if(actionName === 'edit'){
            this.Contact = contact;
            this.updateModalData = true;
            this.openModal = true;
        }
        else if(actionName === 'delete'){
            let selectedSingleRow = [];
            selectedSingleRow.push(contact);
            this.deleteRecords(selectedSingleRow);
        }
    }

    resetFields(){
        this.Contact = {
            FirstName : '',
            LastName : '',
            Title : '',
            Email : '',
            AccountId : ''
        };
    }

    showToastMessage(title , message, variant){
        this.dispatchEvent(
            new ShowToastEvent({
                title : title,
                message : message,
                variant : variant
            })
        );
    }

}