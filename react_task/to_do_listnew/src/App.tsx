import React from 'react';
import ToDoListPage from './ToDoList';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import CreateTaskPage from './CreateTask';
import UpdateTaskPage from './UpdateTask';
const App: React.FC = () => {
    return (
        <Router>
          <Routes>
            <Route path='/' element={<ToDoListPage/>}/>
            <Route path='/create_task' element={<CreateTaskPage/>}/>
            <Route path='/update_task' element={<UpdateTaskPage/>}/>
          </Routes>
        </Router>
      );
}
export default App;
