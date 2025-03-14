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
- Github Access Token
- Docker
- Docker Compose

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

### Step 3: Run Kestra using Docker
Ensure you have Docker and Docker Compose installed on your machine. Then, build and run the Docker containers:
```
cd kestra_orchestrator
```
Then, add your github access token to the docker-compose.yml file (see [here](https://youtu.be/OPlNKQZFeho?t=82) on how to get your github access token):
```
environment:
      SECRET_GITHUB_ACCESS_TOKEN: <your_github_token>
```

```
docker-compose up -d
```

### Step 4: Set up Kestra flows
1. Copy the code from ```/kestra_orchestrator/flows/00_init_gcp_kv.yml```
2. In kestra, click on 'Flows' and 'Create' to create a new flow
3. Paste in the code, and change the values to your credentials
4. Click 'Save' to save the flow
5. Click 'Execute'
6. Copy the code from ```/kestra_orchestrator/flows/utils_git_sync_flows.yml```
7. Create a new flow, paste the code and click 'Save'
8. Click 'Execute' to sync the flows from the git repository to your kestra flows

### Step 5: Executing dlt ingestion backfills
1. In kestra, click and open the ```00_trigger_backfill``` flow

This will trigger a backfill for all flows 01 - 07 and load the raw dlt load data into Google Bigquery tables.
This is a one time backfill run that is needed to backfill historical data from the API. The Kestra flows created are then scheduled to run at a set interval to load data automatically into Bigquery. 

## Step 6: Running dbt 
1. In kestra, click and open the ```08_dbt_transformer``` flow

This will run the dbt models in ```dbt_transformer/models``` and output them to Google Bigquery which can then be used for analysis and building the dashboard.
This is a one time manual run to get an immediate output, otherwise, this is scheduled to run on a daily interval.

## Step 7: Creating / viewing the dashboard 
To create your own dashboard:
* Go to [Google Data Studio](https://datastudio.google.com) 
* Click `Create` > `Data Source`
* Select `BigQuery` > Your Project ID > Dataset > Table
* Click on `Connect` on the top-right and you should be able to use the imported data to create your dashboard!

Below is a screenshot of my [dashboard](https://datastudio.google.com/).

Thank you! If you have any questions, please feel free to open a PR or send me an email.