DevBlog, is a standard monolithic Node.js web application designed with an Express.js framework and a MongoDB backend.

1. Application Architecture & Stack

Runtime: Node.js v19.9.0
Web Framework: Express.js.
Database: MongoDB, interfaced via the Mongoose ODM.
View Engine: EJS (Embedded JavaScript) with express-ejs-layouts for templating.
Styling: Tailwind CSS, which requires a build step for production.
Security: crypto-js for password hashing and cookie-parser for session-like authentication via cookies.


Containerization:

I started this project deployment by creating these important files since I will be dockerizing the web-app, database, and the mongo-express.
Dockerfile
docker-compose.yml
.dockerignore
start.sh
dc-helper.sh

This line was added to make cd-helper.sh bash script run. "RUN apk add --no-cache bash curl"

Start all services: Run docker-compose up -d.

Access the Blog: Open http://localhost:3001 in your browser.

Manage the Database: Open http://localhost:8081

I created /admin account by running "docker-compose exec app node create-user-cli.js"