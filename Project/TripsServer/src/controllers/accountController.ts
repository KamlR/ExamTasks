
import express, { Request, Response } from 'express';
import { Pool } from 'pg';
import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken';

const accountController = express.Router();
const secretKey = "qmpLre49#ax1"
const dbConfig = {
    user: 'karina',
    host: 'localhost',
    database: 'travelling',
    password: 'admin',
    port: 5432,
  };

const pool = new Pool(dbConfig);

accountController.post('/registration', async (req: Request, res: Response) => {
    try {
        const { firstName, lastName, age, description, password, login} = req.body; 
        // Проверка уникальности логина
        const existingUser = await pool.query('SELECT * FROM users WHERE login = $1', [login]);
        if (existingUser.rows.length > 0) {
            return res.status(400).json({ error: 'Пользователь с таким логином уже существует' });
        }
        const hashedPassword = await bcrypt.hash(password, 10);
        const result = await pool.query(
            'INSERT INTO users (firstname, lastname, age, description, login, password) VALUES ($1, $2, $3, $4, $5, $6)',
            [firstName, lastName, age, description, login, hashedPassword]
          );
          
          const accessToken = jwt.sign({login}, secretKey, { expiresIn: '1h' }); 
          const refreshToken = jwt.sign({login}, secretKey, { expiresIn: '7d' });
          const tokens = {
            accessToken: accessToken,
            refreshToken: refreshToken
          };
          res.status(200).json(tokens);
    }
    catch(error){
        console.error('Error during registration:', error);
        res.status(500).json({ error: 'Внутренняя ошибка сервера' });
    }
});

accountController.post('/authorization', async (req: Request, res: Response) => {
    try{
        const {login, password} = req.body;
        const result = await pool.query('SELECT password FROM users WHERE login = $1', [login]);
        if (result.rows.length === 0) {
            return res.status(400).json({error:"Пользователя с таким логином нет в системе"});
        }
        const passwordMatch = await bcrypt.compare(password, result.rows[0].password);
        if(passwordMatch){
            const accessToken = jwt.sign({login}, secretKey, { expiresIn: '1h' }); 
            const refreshToken = jwt.sign({login}, secretKey, { expiresIn: '7d' });
            const tokens = {
                accessToken: accessToken,
                refreshToken: refreshToken
            };
            res.status(200).json(tokens);
        }
        else{
            return res.status(401).json({error:"Вы ввели неверный пароль"});
        }
    }
    catch(error){
        console.error('Error during authorization:', error);
        res.status(500).json({ error: 'Внутренняя ошибка сервера' });
    }
});


accountController.post('/get_access_by_refresh', async (req: Request, res: Response) => {
    const refreshToken = req.body.refreshToken as string;
    try{
        const decodedRefreshToken = jwt.verify(refreshToken, secretKey) as { login: string };
        const login = decodedRefreshToken.login;
        const accessToken = jwt.sign({ login }, secretKey, { expiresIn: '1h' });
        res.status(200).json({ accessToken });
    }
    catch(error){
        console.error('Ошибка при обновлении access token:', error);
        res.status(401).json({ error: 'Неверный refreshToken' });
    }
});

export default accountController;