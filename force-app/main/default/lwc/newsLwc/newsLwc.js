import { LightningElement, wire, track } from 'lwc';
import getNewsHeadlines from '@salesforce/apex/newApiDemo.getNewsHeadlines';

export default class NewsLwc extends LightningElement {
    @track options = [
        { label: 'Business', value: 'Business' },
        { label: 'Sports', value: 'Sports' },
        { label: 'General', value: 'General' },
        { label: 'Health', value: 'Health' },
        { label: 'Entertainment', value: 'Entertainment' },
        { label: 'Technology', value: 'Technology' },
        { label: 'Science', value: 'Science' }
    ];

    @track selectedValue;

    @track newsList = [];
    @track error;

    mapMarkers = [
        {
            location: {
                Latitude: 37.7749,
                Longitude: -122.4194,
            },
            title: 'San Francisco',
            description: 'This is San Francisco'
        },
        {
            location: {
                Latitude: 27.0454,
                Longitude: 75.7513,
            },
            title: 'SAS Jaipur',
            description: 'This is my School'
        }
    ];

    mapCenter = {
        location: {
            Latitude: 36.0,
            Longitude: -120.0
        }
    };

    handleCategoryChange(event){
        this.selectedValue = event.detail.value;
    }

    handleSearch(){
        console.log('Selected Value: ' + this.selectedValue);
        getNewsHeadlines({category: this.selectedValue})
        .then(result => {
            console.log(result);
            this.newsList = result;
            console.log('News List: ' + this.newsList);
        })
        .catch(error => {
            console.log('Error: ' + error.body.message);
            this.error = error;
        });
    }



}