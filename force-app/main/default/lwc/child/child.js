import { LightningElement, api } from 'lwc';

export default class Child extends LightningElement {

    UpperCaseName = 'default value';

    @api
    get itemName(){
        return this.UpperCaseName;
    }
    set itemName(value){
        this.UpperCaseName = value.toUpperCase();
    }

}