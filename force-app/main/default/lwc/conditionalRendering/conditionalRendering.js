import { LightningElement } from 'lwc';

export default class ConditionalRendering extends LightningElement {

    isDetailsVisible = false;

    handleChange(event){
        this.isDetailsVisible = event.target.checked;
    }

}