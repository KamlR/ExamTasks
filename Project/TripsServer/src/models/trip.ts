export class Trip {
    id: number;
    title: string;
    destination: string;
    numberOfDays: number;
    numberOfPeople: number;
    imageUrl: string;
    description: string;
    creator: string;

    constructor(
        id: number, title: string, destination: string, numberOfDays: number,
        numberOfPeople: number, imageUrl: string, description: string, creator:string
    ) {
        this.id = id;
        this.title = title;
        this.destination = destination;
        this.numberOfDays = numberOfDays;
        this.numberOfPeople = numberOfPeople;
        this.imageUrl = imageUrl;
        this.description = description;
        this.creator = creator;
    }
}
