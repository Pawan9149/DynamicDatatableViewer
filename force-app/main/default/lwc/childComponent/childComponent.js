import { LightningElement, api } from 'lwc';

export default class ChildComponent extends LightningElement {
    @api childMessage; // Exposed to parent

    @api
    showAlert() {
        alert('This alert was triggered from the parent component!');
    }
}