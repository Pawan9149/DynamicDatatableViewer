import { LightningElement, wire } from 'lwc';
import { subscribe, MessageContext } from 'lightning/messageService';
import COMPONENT_COMMUNICATION_CHANNEL from '@salesforce/messageChannel/ComponentCommunicationChannel__c';

export default class Component2 extends LightningElement {

    @wire(MessageContext)
    messageContext;

    subscription = null;
    recievedMessage = 'No message recieved yet!!';

    connectedCallback() {
        if(!this.subscription){
            this.subscription = subscribe(
                this.messageContext,
                COMPONENT_COMMUNICATION_CHANNEL,
                (payload) => this.handleMessage(payload)
            );
        }
    }

    handleMessage(payload){
        this.recievedMessage = payload.message;
    }

}