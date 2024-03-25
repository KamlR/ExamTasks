import express from 'express';
import { logger } from './logger';
import toDoListController from './controllers/toDoListController';



const cors = require('cors');
const app = express();
// Middleware для обработки JSON-данных
app.use(express.json());
app.use(cors());
app.use((req, res, next) => {
    logger(req, res, next);
  });

const port = 3001;

app.use('/api/tasks', toDoListController);
app.listen(port, () => {
  console.log(`Сервер запущен на порту ${port}`);
});
