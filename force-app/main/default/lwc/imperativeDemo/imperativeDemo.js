import { LightningElement, track } from 'lwc';
import getAccounts from '@salesforce/apex/imperativeDemoClass.getAccounts';

const columns = [
    {label : 'AccountId' , fieldName : 'Id'},
    {label : 'Name' , fieldName : 'Name'}
];

export default class ImperativeDemo extends LightningElement {

    @track columns = columns;
    @track data = [];

    connectedCallback(){
        getAccounts()
        .then(result =>{
            this.data = result;
            console.log('List: ' + this.data)
        })
        .catch(error=>{
            console.log('Error: ' + error);
        })
    }

}