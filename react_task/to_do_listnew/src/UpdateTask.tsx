import { useParams } from 'react-router-dom';
import React, { useEffect, useState } from 'react';
import axios from 'axios';
import TextField from '@mui/material/TextField';
import Button from '@mui/material/Button';
import { useNavigate } from 'react-router-dom';

interface FormData {
    title: string;
    end_time: string;
    status: string;
    description: string;
  }

const UpdateTaskPage: React.FC = () => {
  const { id } = useParams();
  const [task, setTask] = useState<FormData | undefined>();

  useEffect(() => {
    const fetchTasks = async () => {
      try {
        const response = await axios.get<FormData>('http://localhost:3001/api/tasks/change' + id);
        setTask(response.data);
      } catch (error) {
        console.error('Ошибка при загрузке данных:', error);
      }
    };

    fetchTasks();
  }, [id]);

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setTask((prevData) => ({ ...prevData!, [name]: value }));
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    const token = localStorage.getItem('token');
    try {
      const response = await fetch('http://localhost:3001/api/tasks/change/' + id, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`,
        },
        body: JSON.stringify(task),
      });

      if (response.ok) {
        const updatedChair: FormData = await response.json();
        console.log('Задача успешно обновлнена:', updatedChair);
      } 
    } catch (error) {
      console.error('Ошибка при отправке запроса:', error);
    }
  };

  if (!task) {
    return null;
  }

  return (
    <div className='div_form'>
      <form onSubmit={handleSubmit}>
        <h3 style={{ color: 'black' }}>Редактирование стула</h3>
        <TextField
          label="Название"
          variant="outlined"
          fullWidth
          margin="normal"
          name="title"
          value={task.title}
          onChange={handleChange}
        />
        <TextField
          label="Материал"
          variant="outlined"
          fullWidth
          margin="normal"
          name="end_time"
          value={task.end_time}
          onChange={handleChange}
        />
        <TextField
          label="Цвет"
          variant="outlined"
          fullWidth
          margin="normal"
          name="status"
          value={task.status}
          onChange={handleChange}
        />
        <TextField
          label="Количество"
          variant="outlined"
          fullWidth
          margin="normal"
          name="description"
          value={task.description}
          onChange={handleChange}
        />
        <Button type="submit" variant="contained" color="primary">
          Сохранить изменения
        </Button>
      </form>
    </div>
  );
};

export default UpdateTaskPage;
