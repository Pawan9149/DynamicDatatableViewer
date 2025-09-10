import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';

//import NAME_FIELD from '@salesforce/schema/Account.Name';
//import PHONE_FIELD from '@salesforce/schema/Account.Phone';

// const FIELDS = [
//     'Account.Name', 
//     'Account.Phone'
// ]

export default class WireLWC extends LightningElement {

    @api recordId;

    @wire(getRecord, {recordId: '$recordId', fields: ['Account.Name', 'Account.Phone']})
    record;
   // @wire(getRecord, {recordId: '$recordId', fields: FIELDS})

    get name(){
        //return this.record.data ? getFieldValue(this.record.data, NAME_FIELD ) : '';
        //return this.record.data ? getFieldValue(this.record.data, 'Account.Name' ) : '';

        return this.record.data.fields.Name.value; // simplified version but not checking the null values
    }

    get phone(){
        //return this.record.data ? getFieldValue(this.record.data, PHONE_FIELD ) : '';
        //return this.record.data ? getFieldValue(this.record.data, 'Account.Phone' ) : '';

        return this.record.data.fields.Phone.value;
    }

}