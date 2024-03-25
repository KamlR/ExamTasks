export default class Task{
    id: number;
    title: string;
    end_time: string;
    status: string;
    description: string;

    constructor(id: number, title: string, end_time: string, status: string, description: string) {
        this.id = id;
        this.title = title;
        this.end_time = end_time;
        this.status = status;
        this.description = description;
    }
}
