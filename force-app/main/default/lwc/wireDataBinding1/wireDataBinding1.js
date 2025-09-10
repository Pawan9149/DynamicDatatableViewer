import { LightningElement } from 'lwc';

export default class WireDataBinding1 extends LightningElement {

    firstname = '';
    lastname = '';

    handleChange(event){
        const field = event.target.name;
        
        if(field === 'fname'){
            this.firstname = event.target.value;
        }else if(field === 'lname'){
            this.lastname = event.target.value;
        }
    }

    //getter
    get upperCasedFullName(){
        return `${this.firstname} ${this.lastname}`.toUpperCase();
    }
}