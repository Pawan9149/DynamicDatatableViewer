import { LightningElement, api } from 'lwc';

export default class Child_pc extends LightningElement {

    @api parentData;

    sendDataBack(){
        this.dispatchEvent(
            new CustomEvent("sendbackthedata", {
                detail: "Child Data Recieved"
            })
        );
    }

}