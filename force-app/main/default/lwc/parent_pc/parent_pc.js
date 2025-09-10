import { LightningElement } from 'lwc';

export default class Parent_pc extends LightningElement {
    
    data = 'Parent Data is sent/recieved';
    childData;

    handleChildData(event){
        this.childData = event.detail;
    }

}