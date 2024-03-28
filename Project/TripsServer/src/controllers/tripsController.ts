import express, { Request, Response } from 'express';
import { Pool } from 'pg';
import { Trip } from '../models/trip';
import AuthMiddleware from '../tokens/AuthMiddleware';

const tripsController = express.Router();
const dbConfig = {
    user: 'karina',
    host: 'localhost',
    database: 'travelling',
    password: 'admin',
    port: 5432,
  };

const pool = new Pool(dbConfig);
tripsController.get('/getall', AuthMiddleware.verifyToken, async (req: Request, res: Response) => {
    try{
        const result = await pool.query('SELECT * FROM trips');
        const trips = result.rows.map((row) => new Trip(row.id, row.title, row.destination, row.number_of_days, row.number_of_people, row.image_url, row.description, row.creator));
        console.log(trips);
        res.json(trips);
    }
    catch(error){
        console.error('Ошибка при получении списка поездок из PostgreSQL:', error);
        res.status(500).json({ error: 'Ошибка сервера' });
    }
});

tripsController.get('/check_participation/:id', AuthMiddleware.verifyToken, async (req: Request, res: Response) => {
    try{
        const login = (req as any).login;
        const tripId = req.params.id; 
        const result = await pool.query('SELECT * FROM registrations WHERE login = $1 AND trip_id = $2', [login, tripId]); 
        if (result.rows.length > 0) {
            res.status(200).json({ subscribed: true });
        } else {
            res.status(200).json({ subscribed: false });
        }
    }
    catch(error){
        console.error('Ошибка при получении списка поездок из PostgreSQL:', error);
        res.status(500).json({ error: 'Ошибка сервера' });
    }
    
});
tripsController.get('/go_trips', AuthMiddleware.verifyToken, async (req: Request, res: Response) => {
    try {
        const login = (req as any).login;
        const query = `
            SELECT t.*
            FROM trips t
            JOIN registrations r ON t.id = r.trip_id
            WHERE r.login = $1
        `;
        const result = await pool.query(query, [login]);

        const trips = result.rows.map((row) => new Trip(row.id, row.title, row.destination, row.number_of_days, row.number_of_people, row.image_url, row.description, row.creator));
        res.status(200).json(trips);
    } catch(error) {
        console.error('Ошибка при получении списка поездок из PostgreSQL:', error);
        res.status(500).json({ error: 'Ошибка сервера' });
    }
    
});

tripsController.get('/created_trips', AuthMiddleware.verifyToken, async (req: Request, res: Response) => {
    try{
        const login = (req as any).login;
        console.log(login)
        const result = await pool.query('SELECT * FROM trips WHERE creator = $1', [login]); 
        const created_trips = result.rows.map((row) => new Trip(row.id, row.title, row.destination, row.number_of_days, row.number_of_people, row.image_url, row.description, row.creator));
        res.json(created_trips);
    }
    catch(error){
        console.error('Ошибка при получении списка поездок из PostgreSQL:', error);
        res.status(500).json({ error: 'Ошибка сервера' });
    }
    
});

tripsController.post('/registr_on_trip/:id', AuthMiddleware.verifyToken, async (req: Request, res: Response) => {
    try{
        const login = (req as any).login;
        const tripId = req.params.id; 

        await pool.query('INSERT INTO registrations (trip_id, login) VALUES ($1, $2)', [tripId, login]); 
        res.status(200).json({ success: true });
    } catch(error){
        console.error('Ошибка при регистрации на поездку:', error);
        res.status(500).json({ error: 'Ошибка сервера' });
    }
});

tripsController.post('/create', AuthMiddleware.verifyToken, async (req: Request, res: Response) => {
    try{
        const creator = (req as any).login;
        const { title, destination, number_of_days, number_of_people, image_url, description} = req.body; 
        console.log(number_of_days, number_of_people, image_url)

        const result = await pool.query(
            'INSERT INTO trips (title, destination, number_of_days, number_of_people, image_url, description, creator) VALUES ($1, $2, $3, $4, $5, $6, $7)',
            [title, destination, number_of_days, number_of_people, image_url, description, creator]
          );
        res.status(200).json({ success: true });
    } catch(error){
        console.error('Ошибка при создании поездки:', error);
        res.status(500).json({ error: 'Ошибка сервера' });
    }
});
tripsController.delete('/unregistr_from_trip/:id', AuthMiddleware.verifyToken, async (req: Request, res: Response) => {
    try {
        const login = (req as any).login;
        const tripId = req.params.id; 

        await pool.query('DELETE FROM registrations WHERE trip_id = $1 AND login = $2', [tripId, login]); 

        res.status(200).json({ success: true });
    } catch(error) {
        console.error('Ошибка при удалении записи о регистрации на поездку:', error);
        res.status(500).json({ error: 'Ошибка сервера' });
    }
});

export default tripsController;