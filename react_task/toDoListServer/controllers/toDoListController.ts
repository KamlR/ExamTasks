
import express, { Request, Response } from 'express';
import { Pool } from 'pg';
import Task from '../models/Task';


const toDoListController = express.Router();
const dbConfig = {
    user: 'karina',
    host: 'localhost',
    database: 'todolist',
    password: 'admin',
    port: 5432,
  };

const pool = new Pool(dbConfig);

toDoListController.get('/getall',  async (req: Request, res: Response) => {
    try{
        const result = await pool.query('SELECT * FROM tasks');
        const tasks = result.rows.map((row) => new Task(row.id, row.title, row.end_time, row.status, row.description));
        console.log(tasks);
        res.json(tasks);
    }
    catch(error){
        console.error('Ошибка при получении списка поездок из PostgreSQL:', error);
        res.status(500).json({ error: 'Ошибка сервера' });
    }
});

toDoListController.post('/create', async (req: Request, res: Response) => {
    try {
        const { title, end_time, status, description} = req.body; 
        const result = await pool.query(
            'INSERT INTO tasks (title, end_time, status, description) VALUES ($1, $2, $3, $4)',
            [title, end_time, status, description]
          );
        res.status(200).json({ success: true });
    } catch (error) {
        console.error('Ошибка при создании задачи:', error);
        // Если произошла ошибка, отправляем клиенту сообщение об ошибке
        res.status(500).json({ error: 'Ошибка при создании задачи' });
    }
});

toDoListController.delete('/delete/:id', async (req: Request, res: Response) => {
    const taskId = req.params.id;
    try{
        const result = await pool.query('DELETE FROM tasks WHERE id = $1', [taskId]);
        if (result.rows.length === 0) {
            res.status(404).json({ error: 'Задача c заданным id не найдена' });
        }
        else {
            const deletedTask = result.rows[0];
            res.json(deletedTask);
        }
    }
    catch(error){
        console.error('Ошибка при удалении задачи из PostgreSQL:', error);
        res.status(500).json({ error: 'Ошибка сервера' });
    }
});

toDoListController.put('/change/:id', async (req: Request, res: Response) => {
    const taskId = req.params.id;
    const { title, end_time, status, description} = req.body; 
    try {
      const result = await pool.query(
        'UPDATE tasks SET title = $1, end_time = $2, status = $3, description = $4, WHERE id = $5',
        [title, end_time, status, description, taskId]
      );
  
      if (result.rows.length === 0) {
        res.status(404).json({ error: 'Задача c заданным id не найдена, изменения не внесены' });
      } else {
        const updatedTask = result.rows[0];
        res.json(updatedTask);
      }
    } catch (error) {
      console.error('Ошибка при обновлении задачи в PostgreSQL:', error);
      res.status(500).json({ error: 'Ошибка сервера' });
    }
  });

export default toDoListController;