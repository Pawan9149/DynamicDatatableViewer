import { LightningElement, wire } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import COMPONENT_COMMUNICATION_CHANNEL from '@salesforce/messageChannel/ComponentCommunicationChannel__c';

export default class Component1 extends LightningElement {

    @wire(MessageContext)
    messageContext;

    handleButtonClick(){
        const msgInp = this.template.querySelector('lightning-input').value;
        const payload = { message : msgInp};
        publish(this.messageContext, COMPONENT_COMMUNICATION_CHANNEL, payload);
    }

}