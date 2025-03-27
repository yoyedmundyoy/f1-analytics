# 🏎️  Formula 1 Data

This project is done for the Data Engineering Zoomcamp Final Capstone Project

# Problem Description
The goal of this project is to track historical Formula 1 data. The source I found is presented as an API (source: [F1 API](https://f1api.dev/)). The dataset includes data regarding races, drivers, teams, circuits and standings. We seek to transform these disconnected data sources into a robust dimensional model with clear fact and dimension tables, enabling analysis of driver and team performance, historical trends, and race strategies through interactive dashboards that will give deeper insights into Formula 1 racing.

# Technologies
For this project, I used the following tools:
* Google Cloud Platform (GCP) - main cloud provider
* BigQuery - cloud data warehouse
* Python - main programming language
* dlt - open source Python library for data loading
* Docker - containerization (docker-compose)
* Kestra - orchestration tool for pipeline
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
git clone https://github.com/yoyedmundyoy/f1-analytics.git
cd f1-analytics
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
Open Kestra UI on port 8080
1. Copy the code from ```/kestra_orchestrator/flows/00_init_gcp_kv.yml```
2. In kestra, click on 'Flows' and 'Create' to create a new flow
3. Paste in the code, and change the values to your credentials
4. Click 'Save' to save the flow
5. Click 'Execute'
6. Copy the code from ```/kestra_orchestrator/flows/utils_git_sync_flows.yml```
7. Create a new flow, paste the code and click 'Save'
8. Click 'Execute' to sync the flows from the git repository to your kestra flows

### Step 5: Executing dlt ingestion backfills
Add your service account credentials to the Key-Value store in Kestra:
1. Click on 'Namespaces'
2. Click on 'f1-analytics'
3. Click 'KV Store'
4. Click 'New Key-Value
5. Key: GCP_CREDS
6. Copy and paste the entire contents of the service account json key file into the value
7. Click 'Save'

Then, open and execute the ```00_trigger_backfill``` flow

This will trigger a backfill for all flows 01 - 07 and load the raw dlt load data into Google Bigquery tables.
This is a one time backfill run that is needed to backfill historical data from the API. The Kestra flows created are then scheduled to run at a set interval to load data automatically into Bigquery. 

## Step 6: Running dbt
Update ```dbt_transformer/models/staging/schema.yml``` and add your project_id
```
database: <your_gcp_project_id>
```
1. In kestra, click and open the ```08_dbt_transformer``` flow

This will run the dbt models in ```dbt_transformer/models``` and output them to Google Bigquery which can then be used for analysis and building the dashboard.
This is a one time manual run to get an immediate output, otherwise, this is scheduled to run on a daily interval.

## Step 7: Creating / viewing the dashboard 
To create your own dashboard:
* Go to [Google Data Studio](https://datastudio.google.com) 
* Click `Create` > `Data Source`
* Select `BigQuery` > Your Project ID > Dataset > Table
* Click on `Connect` on the top-right and you should be able to use the imported data to create your dashboard!

Below is a screenshot of my [dashboard](https://datastudio.google.com/](https://lookerstudio.google.com/reporting/44e67a36-8804-4652-a4dd-c70467919928)).
![image](https://github.com/user-attachments/assets/475e8931-b8c4-4d47-9fa4-e0b44416f62d)

Thank you! If you have any questions, please feel free to open a PR or send me an email.
