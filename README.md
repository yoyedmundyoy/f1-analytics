# 🏎️  Formula 1 Data

This project is done for the Data Engineering Zoomcamp Final Capstone Project

# Problem Description
The goal of this project is to track historical Formula 1 data. The source I found is presented as an API (source: [F1 API](https://f1api.dev/)). The dataset includes data regarding races, drivers, teams, circuits and standings.

# Technologies
For this project, I used the following tools:
* Google Cloud Platform (GCP) - main cloud provider
* BigQuery - cloud data warehouse
* Python - main programming language
* Docker - containerization (docker-compose)
* Kestra - orchestration tool for pipeline
* Terraform - Infrastructure-as-Code (IaC) tool
* Google Data Studio - data visualizations

## Project Structure

## Reproducing from scratch

### Prerequisites:
- [GCP account](https://cloud.google.com/) with credits

### Step 1: Clone the Repository
```
git clone https://github.com/yoyedmundyoy/zoomcamp-project.git
cd zoomcamp-project
```

### Step 2: Set Up Google Cloud
1. Create a new project in GCP.
2. Enable the BigQuery API.
3. Create a service account with BigQuery Admin permissions.
4. Download and save the service account key file

### Step 3: Configure Docker
Ensure you have Docker and Docker Compose installed on your machine. Then, build and run the Docker containers:
```
docker-compose up --build
```

Thank you again to everyone for their dedication and support! If you have any questions, please feel free to open a PR or send me an email. Bless!