import { LightningElement, track, wire } from 'lwc';
import getObjectList from '@salesforce/apex/datatableAssignmentController.getObjectList';
import getFieldList from '@salesforce/apex/datatableAssignmentController.getFieldList';
import getRecords from '@salesforce/apex/datatableAssignmentController.getRecords';
import updateRecords from '@salesforce/apex/datatableAssignmentController.updateRecords';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class DynamicObjectListView extends LightningElement {

    @track sObjectOptions = [];
    @track selectedObject = '';
    @track columns = [];
    records = [];
    showRecords = [];
    @track draftValues = [];
    @track dualOptions = [];
    @track dualSelectedValues = [];
    @track dualSelectedOptions = [];
    openModal = false;
    fieldsString = '';
    isLoading = false;


    @wire(getObjectList)
    wiredSObjects(result){
        if(result.data){
            this.sObjectOptions = result.data;
        }
        else if(result.error){
            this.showToastMessage('Error', 'Error fetching categories: ' + error, 'error');
        }
    }

    handleFields(){
        this.isLoading = true;
        getFieldList({objectApiName : this.selectedObject})
        .then( result => {
            //console.log('Fields returned:', result);
            this.dualOptions = result;
        })
        .catch(error => {
            this.showToastMessage('Error getting fields', error.body.message, 'error');
        })
        .finally(() => {
            this.isLoading = false;;
        });
    }

    handleLoadMore() {
        console.log('handleLoadMore called');
        this.isLoading = true;
        this.showRecords = this.records.slice(0, this.showRecords.length + 20);
        this.isLoading = false;
    }

    handleObjectChange(event){
        this.selectedObject = event.detail.value;
        this.dualSelectedValues = [];
        this.records = [];
        this.handleFields();
    }

    handleDualChange(event){
        this.dualSelectedValues = event.detail.value;
        console.log('Selected Values: ' + this.dualSelectedValues);
    }

    showToastMessage(title, message, variant) {
        this.dispatchEvent(
            new ShowToastEvent({
                title : title,
                message : message,
                variant : variant
            })
        );
    }

    handleFieldButton(){
        if(this.selectedObject != ''){
            this.openModal = true;
        }
    }

    get isFieldDisabled(){
        return this.selectedObject === '';
    }

    get isChoiceDisabled(){
        return this.dualSelectedValues.length === 0;
    }

    get noRecord(){
        return this.selectedObject != '' && this.dualSelectedValues.length != 0 && this.records.length === 0;
    }

    handleCloseModal(){
        this.openModal = false;
    }

    handleFieldChoice(){
        this.fieldsString = this.dualSelectedValues.join(',');

        const selectedFieldObjects = this.dualOptions.filter(opt =>
            this.dualSelectedValues.includes(opt.value)
        );

        this.columns = selectedFieldObjects.map(field => {
            console.log('Mapping label: ' + field.label + ' value: ' + field.value + ' Updateable: ' + field.updateable);
            return {
                label: field.label,       
                fieldName: field.value,
                editable: field.updateable === 'true' ? true : false   
            };
        });

        this.getRecords();
        this.openModal = false;
    }

    getRecords(){
        console.log('In getRecords');
        this.records = [];
        this.isLoading = true;
        getRecords({objectApiName : this.selectedObject, Fields : this.fieldsString})
        .then(result => {
            console.log(result);
            this.records = result;
            this.showRecords = this.records.slice(0, 20);
            console.log(this.records);
        })
        .catch(error => {
            console.log(error);
        })
        .finally(() => {
            this.isLoading = false;
        })

    }

    handleSave(event){
        this.draftValues = event.detail.draftValues;
        this.isLoading = true;
        updateRecords({RecordList: this.draftValues})
        .then( result => {
            if(result === 'Success'){
                this.showToastMessage('Success', 'Record Updated Successfully', 'success');
                this.handleFieldChoice();
            }
            else{
                this.showToastMessage('Error', result, 'error');
            }
        })
        .catch(error => {
            this.showToastMessage('Error updating records', error.body.message, 'error');
        })
        .finally(() => {
            this.isLoading = false;
        });
        this.draftValues = [];
    }
        
}
