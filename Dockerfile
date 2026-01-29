# Stage 1: Build tailwind assets
FROM node:19-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
# Generate the production CSS file
RUN npx tailwindcss -i ./public/stylesheets/input.css -o ./public/stylesheets/style.css

# Stage 2: Final Production Image
FROM node:19-alpine
WORKDIR /app
ENV NODE_ENV=production

# Install only production dependencies
COPY package*.json ./
RUN npm install --only=production

# Copy built assets and source code from build stage
COPY --from=build /app/public/stylesheets/style.css ./public/stylesheets/style.css
COPY . .

EXPOSE 3000

# Start the application using the script defined in package.json
CMD ["npm", "start"]