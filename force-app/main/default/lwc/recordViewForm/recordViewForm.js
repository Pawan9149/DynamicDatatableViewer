import { LightningElement, api, track } from 'lwc';
//import nameField from '@salesforce/schema/Account.Name';
import idField from '@salesforce/schema/Account.Id';

export default class RecordViewForm extends LightningElement {

    @api recordId;
    @api objectApiName;

    nameField = 'Name';
    idField = 'Id';
}