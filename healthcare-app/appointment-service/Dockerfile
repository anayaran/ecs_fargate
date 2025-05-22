FROM node:18

WORKDIR /usr/src/app

# Copy package files and install dependencies first (for caching)
COPY package*.json ./
RUN npm install

# Copy the rest of the app code
COPY . .

EXPOSE 3001

CMD ["npm", "start"]

