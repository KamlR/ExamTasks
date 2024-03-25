import React, { useState } from 'react';
import {useNavigate } from 'react-router-dom';

interface Task {
    id: number;
    title: string;
    end_time: string;
    status: string;
    description: string;
}
  
interface TaskItemProps {
    task: Task;
    onDelete: (id: number) => void; 
}
  
const TaskItem: React.FC<TaskItemProps> = ({ task, onDelete }) => {
    const [isVisible, setIsVisible] = useState(true); 
    const navigate = useNavigate();

    const handleDeleteClick = () => {
        onDelete(task.id);
        setIsVisible(false);
    };
    const handleUpdateClick = () => {
      navigate(`/update_task/${task.id}`);
  };

    return isVisible ? (
        <div className="task-item">
            <h3 className="task-title">{task.title}</h3>
            <p className="task-description">{task.description}</p>
            <p className="task-end-time">End Time: {task.end_time}</p>
            <p className="task-status">Status: {task.status}</p>
            <div>
                <button onClick={handleDeleteClick}>Удалить</button>
                <button onClick={handleUpdateClick}>Изменить</button>
            </div>
        </div>
    ) : null;
};

export default TaskItem;
