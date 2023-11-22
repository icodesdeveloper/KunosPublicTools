const express = require('express');
const app = express();
const port = 3000;

app.get('/user', (req, res) => {
  res.json({ user: 'Kuno Claes' });
});
app.get('/container', (req, res) => {
    res.json({ id: 'Kuno Claes' });
  });


app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});