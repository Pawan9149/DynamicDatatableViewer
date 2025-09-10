import { LightningElement } from 'lwc';

export default class RenderingListForEach extends LightningElement {

    contacts = [
        {
            Id : 1,
            Name : 'Pawan',
            Title : 'SF Developer'
        },
        {
            Id : 2,
            Name : 'Naman',
            Title : 'Java Developer'
        },
        {
            Id : 3,
            Name : 'Sunil',
            Title : 'Python Developer'
        },
        {
            Id : 4,
            Name : 'Bhavyansh',
            Title : 'Stuntman'
        }
    ];

}