import React, { useEffect, useState } from 'react';
import TaskItem from './TaskItem';
import ReactDOM from 'react-dom';
import {useNavigate } from 'react-router-dom';

import axios from 'axios';
import { Task } from './models/task';

const ToDoListPage: React.FC = () => {
    const [tasks, setTasks] = useState<Task[]>([]);
    const navigate = useNavigate();
    useEffect(() => {
      const fetchTasks = async () => {
        try {
          const response = await axios.get<Task[]>('http://localhost:3001/api/tasks/getall');
          setTasks(response.data);
        } catch (error) {
          console.error('Ошибка при загрузке данных:', error);
        }
      };
  
      fetchTasks();
    }, []); 
    const handleAddNewTask = () => {
        navigate(`/create_task`);
      };
      const handleDeleteTask = async (id: number) => {
        try {
            await axios.delete(`http://localhost:3001/api/tasks/delete/${id}`);
        } catch (error) {
            console.error('Ошибка при удалении задачи:', error);
        }
    };
    return (
        <div>
            <h2>To Do List</h2>
            {tasks.map(task => (
               <TaskItem task={task} onDelete={handleDeleteTask} />
            ))}
            <div>
                <button className="add-button" onClick={handleAddNewTask}>Добавить задачу</button>
            </div>
        </div>
    );
};

  
    
    
  
export default ToDoListPage;
