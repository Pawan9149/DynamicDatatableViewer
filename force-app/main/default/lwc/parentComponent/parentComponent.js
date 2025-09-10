import { LightningElement } from 'lwc';

export default class ParentComponent extends LightningElement {
    parentMessage = 'Hello from Parent!';

    handleInput(event) {
        this.parentMessage = event.target.value;
    }

    handleClick() {
        // Call child method using template query selector
        const childComp = this.template.querySelector('c-child-component');
        if (childComp) {
            childComp.showAlert(); // Call the @api method
        }
    }
}