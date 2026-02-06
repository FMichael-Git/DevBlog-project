DevBlog, is a standard monolithic Node.js web application designed with an Express.js framework and a MongoDB backend.

![alt text](image-2.png)

1. Application Architecture & Stack

Runtime: Node.js v19.9.0
Web Framework: Express.js.
Database: MongoDB, interfaced via the Mongoose ODM.
View Engine: EJS (Embedded JavaScript) with express-ejs-layouts for templating.
Styling: Tailwind CSS, which requires a build step for production.
Security: crypto-js for password hashing and cookie-parser for session-like authentication via cookies.


Key Highlights of this projectApplication deployment:

Dockerization: A multi-stage Dockerfile to keep production images slim and secure, separating the Tailwind CSS build process from the runtime environment.

Orchestration: I used Docker Compose to manage the Node.js app, MongoDB, and Mongo-Express, ensuring seamless networking and data persistence.


Files created for this work:

Dockerfile:  Building the App image.
docker-compose.yml:   This brings up the entire stack by a "command docker compose up" Managing the App container, db (MongoDB) container, and the mongo-express admin panel.
.dockerignore	This filter the trash by keeping the image clean and small.
start.sh: Running setup tasks inside the container.Ensures that every time a container starts, it performs a "health check"
dc-helper: Providing shortcuts to make operations easy.


This project reinforced a core DevOps principle for me: Consistency. Whether this runs on my local machine or a production cloud server, the environment remains identical.


This line was added to make cd-helper.sh bash script run. "RUN apk add --no-cache bash curl"

Start all services: Run docker-compose up -d.

Access the Blog: Open http://localhost:3001 in your browser.

Manage the Database: Open http://localhost:8081

I created /admin account by running "docker-compose exec app node create-user-cli.js"

![alt text](image.png)

![alt text](image-1.png)

