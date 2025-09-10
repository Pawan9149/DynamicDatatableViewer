import { LightningElement, track } from 'lwc';
import getAccounts from '@salesforce/apex/imperativeDemoClass.getAccounts';

export default class ComboBoxDemo extends LightningElement {

    @track value = '';
    @track accOptions = [];

    get options(){
        return this.accOptions;
    } 

    connectedCallback(){
        getAccounts()
        .then(result=>{
            let arr = [];
            for(var i=0; i<result.length; i++){
                arr.push({label : result[i].Name, value : result[i].Id});
            }
            this.accOptions = arr;
        })
    }

    handleChange(event){
        this.value = event.detail.value;
    }
    

}