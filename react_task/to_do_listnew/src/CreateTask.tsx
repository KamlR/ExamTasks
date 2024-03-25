import React, { useState } from 'react';
import TextField from '@mui/material/TextField';
import Button from '@mui/material/Button';
import { useNavigate } from 'react-router-dom';

interface FormData {
    title: string;
    end_time: string;
    status: string;
    description: string;
  }

const CreateTaskPage: React.FC = () => {
   const navigate = useNavigate();
    const [formData, setFormData] = useState<FormData>({
        title: '',
        end_time: '',
        status: '',
        description: '',
      });

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setFormData((prevData) => ({ ...prevData, [name]: value }));
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    try {
        const response = await fetch('http://localhost:3001/api/tasks/create', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify(formData),
        });
  
        if (response.ok) {
          const createdTask: FormData = await response.json();
          console.log('Задача успешно создана:', createdTask);
          //navigate('/admin/chairs')
        } 
      } catch (error) {
        console.error('Ошибка при отправке запроса:', error);
      }
  };

  return (
    <div className='div_form'>
      <form onSubmit={handleSubmit}>
      <h3 style={{color:'black'}}>Создание новой задачи</h3>
        <TextField
          label="Название"
          variant="outlined"
          fullWidth
          margin="normal"
          name="title"
          value={formData.title}
          onChange={handleChange}
        />
        <TextField
          label="Дедлайн"
          variant="outlined"
          fullWidth
          margin="normal"
          name="end_time"
          value={formData.end_time}
          onChange={handleChange}
        />
        <TextField
          label="Статус"
          variant="outlined"
          fullWidth
          margin="normal"
          name="status"
          value={formData.status}
          onChange={handleChange}
        />
        <TextField
          label="Описание"
          variant="outlined"
          fullWidth
          margin="normal"
          name="description"
          value={formData.description}
          onChange={handleChange}
        />
        <Button type="submit" variant="contained" color="primary">
          Добавить задачу
        </Button>
      </form>
    </div>
  );
};

export default CreateTaskPage;
