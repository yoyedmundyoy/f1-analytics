FROM kestra/kestra:latest

USER root
RUN apt-get update -y && apt-get install pip -y

RUN pip install --no-cache-dir kestra dlt[bigquery] requests google-cloud-bigquery google-cloud-bigquery-storage