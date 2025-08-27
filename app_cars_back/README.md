# app_cars_back

This is the backend service for the car rental application.

## Requirements

- Python 3.8 or higher
- Docker
- Docker Compose
- Docker for Windows (if using Windows)

## Run project
To run the project, use the following command:

```bash
pip install -r requirements.txt
```

Deploy the application using the following command:

```bash
docker-compose up --build
```

## Load data

Open the navigator and go to the following URL:

```
http://localhost:8000/api/docs/
```

Execute the `/seed/` endpoint to load the initial data into the database.

User of test in the application:

```
- account = supervisor
- phone = 123456789
```
