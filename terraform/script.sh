#!/bin/bash
sudo apt update
yes | sudo  DEBIAN_FRONTEND=noninteractive apt install -y docker.io awscli
sudo curl -SL https://github.com/docker/compose/releases/download/v2.20.3/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
sudo chmod 777 /usr/local/bin/docker-compose
sudo usermod -aG docker ubuntu
mkdir /home/ubuntu/interview_techverito
cd /home/ubuntu/interview_techverito
echo '
DB_HOST=postgres
DB_USER=postgres
DB_PASSWORD=xxx012812d
DB_NAME=web
DB_PORT=5432
ALLOWED_ORIGINS=*
REACT_APP_SERVER_URL=http://'`curl api.ipify.org`':8080/employees

' >> .env

echo '
version: "3.1"
services:
  backend:
    # Configuration for building the docker image for the service
    image: 427510603539.dkr.ecr.ap-south-1.amazonaws.com/backend-api:main
    ports:
      - "8080:8080" # Forward the exposed port 8080 on the container to port 8080 on the host machine
    restart: unless-stopped
    container_name: backend
    depends_on: 
      - postgres
    env_file:
      - ./.env
    environment:
      DB_HOST: ${DB_HOST}
      DB_USER: ${DB_USER}
      DB_PASSWORD: ${DB_PASSWORD}
      DB_NAME: ${DB_NAME}
      DB_PORT: ${DB_PORT}
      ALLOWED_ORIGINS: ${ALLOWED_ORIGINS}
    networks: # Networks to join (Services on the same network can communicate with each other using their name)
      - backend

  # Redis Service   
  postgres:
    image: "postgres:alpine"
    ports:
      - "5432:5432"
    restart: always
    container_name: database
    env_file:
      - ./.env
    environment:
      POSTGRES_PASSWORD: ${DB_PASSWORD}
      POSTGRES_USER: ${DB_USER}
      POSTGRES_DB: ${DB_NAME}
    networks:
      - backend
  # frontend service
  frontend:
    image: "427510603539.dkr.ecr.ap-south-1.amazonaws.com/frontend-app:main"
    ports:
      - "3000:3000"
    restart: always
    container_name: frontend
    env_file:
        - ./.env
    environment:
      REACT_APP_SERVER_URL: ${REACT_APP_SERVER_URL}
    networks:
      - backend

networks:
  backend: 

' >> docker-compose.yml

aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 427510603539.dkr.ecr.ap-south-1.amazonaws.com

docker-compose up -d
