require('dotenv').config();

const express = require('express');

const app = express();
const port = Number(process.env.PORT || 3000);

app.get('/', (_req, res) => {
  res.status(200).send(`<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>AWS Native CI/CD Demo</title>
  <style>
    body {
      font: 16px system-ui;
      max-width: 760px;
      margin: 12vh auto;
      padding: 24px;
      color: #172033;
    }
    main {
      border: 1px solid #d7deea;
      border-radius: 16px;
      padding: 28px;
    }
    code {
      background: #eef2f8;
      padding: 3px 6px;
      border-radius: 5px;
    }
  </style>
</head>
<body>
  <main>
    <h1>Deployment succeeded!</h1>
    <p>Node.js and Express are running on EC2.</p>
    <p>Deployed with AWS CodePipeline, CodeBuild, and CodeDeploy.</p>
    <p>Health check: <a href="/health"><code>/health</code></a></p>
    <p>Environment: ${process.env.NODE_ENV || 'production'}</p>
  </main>
</body>
</html>`);
});

app.get('/health', (_req, res) => {
  res.status(200).json({
    status: 'ok',
    service: 'aws-native-cicd-demo',
    dbPasswordLoaded: Boolean(process.env.DB_PASSWORD)
  });
});

app.listen(port, '0.0.0.0', () => {
  console.log(`CI/CD demo server listening on ${port}`);
});