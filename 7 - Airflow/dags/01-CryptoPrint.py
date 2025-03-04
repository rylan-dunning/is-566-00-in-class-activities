# imports important for Airflow
import pendulum
from airflow.decorators import dag, task

# import from the crypto_tasks.py file (same as the import in test_crypto_tasks.py)
from crypto_utils.crypto_tasks import *

# [START instantiate_dag]
@dag(
    schedule_interval=None,                             # interval how often the dag will run (can be cron expression as string)
    start_date=pendulum.datetime(2021, 1, 1, tz="UTC"), # from what point on the dag will run (just needs to be in the past for us)
    catchup=False,                                      # no catchup needed
    tags=['is566'],                                     # tag the DAG so it's easy to find in AirflowUI
)
def CryptoPrint():
    """DAG using TaskFlow API with modularized functions."""
    
    @task()
    def pull_asset_task(asset_id):
        return pull_asset_data(asset_id)

    @task()
    def clean_asset_task(raw_data):
        return clean_asset_data(raw_data)

    @task()
    def print_asset_task(cleaned_data):
        print_asset_data(cleaned_data)

    # Define task dependencies
    raw_data = pull_asset_task('bitcoin')
    cleaned_data = clean_asset_task(raw_data)
    print_asset_task(cleaned_data)

cryptoprint_dag = CryptoPrint()
