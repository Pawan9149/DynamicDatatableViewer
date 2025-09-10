import { LightningElement } from 'lwc';

export default class WireDataBinding extends LightningElement {

    greeting = 'Naman';

    handleChange(event){
        this.greeting = event.target.value;
    }

}