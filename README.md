# Trivia Mobile App

Welcome to the Trivia App! This app is intended to allow users to test their knowledge across various categories.  

## Table of Contents

- [Code Structure](#code-structure)
- [Features](#features)
- [Build](#build)

## Code Structure
This repo contains 2 root project directories
- **api** intended to host the source code for the entire api 
- **frontend** intented to host the source code for the Flutter frontend

## Features

- Multiple categories of trivia questions
- Random question for each category
- Multiple choices for each question with one correct answer

## Build

First of all, clone the **trivia-app**  repo.

For local development, you also need to modify `appsettings.json` file and populate the values for the postgres user, password, db and port as the ones provided in the `.env` file.

Then run this command in your terminal:

`docker compose -f docker-compose.db.yaml up -d`

If this succeeds, you have the database running locally and you can run the API.

## Model

ER diagram: https://drive.google.com/file/d/1B3Yqjzv7_4JdtG3DI702OFx0ozhpqW3u/view?usp=sharing
