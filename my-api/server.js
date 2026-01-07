const express = require('express');
const { v4: uuidv4 } = require('uuid');
const app = express();
app.use(express.json());

// In-memory data store
let projects = {};

// CREATE
app.post('/projects', (req, res) => {
    const id = uuidv4();
    const project = {
        id,
        name: req.body.name,
        description: req.body.description || "",
        status: "active"
    };
    projects[id] = project;
    console.log(`Created: ${id}`);
    res.status(201).json(project);
});

// READ
app.get('/projects/:id', (req, res) => {
    const project = projects[req.params.id];
    if (!project) return res.status(404).send('Not found');
    res.json(project);
});

// UPDATE
app.put('/projects/:id', (req, res) => {
    if (!projects[req.params.id]) return res.status(404).send('Not found');
    projects[req.params.id] = { ...projects[req.params.id], ...req.body };
    res.json(projects[req.params.id]);
});

// DELETE
app.delete('/projects/:id', (req, res) => {
    delete projects[req.params.id];
    res.status(204).send();
});

app.listen(3000, () => console.log('API running on http://localhost:3000'));