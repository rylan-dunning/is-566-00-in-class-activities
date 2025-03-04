# crypto_utils/crypto_tasks.py
import json
import requests
import logging
from datetime import datetime
import psycopg2
from decimal import Decimal, getcontext

# Set overall precision to 20 decimal places
getcontext().prec = 20


def pull_asset_data(asset_id):
    """
    Queries the API data for bitcoin pricing data, returning the data in json format.
    """
    url = f"https://api.coincap.io/v2/assets/{asset_id}"

    try:
        response = requests.get(url)
        response.raise_for_status()  # Raise an error if the request failed
        data = response.json()

        logging.info("Raw API Response: %s", json.dumps(data, indent=2))
        return data
    except requests.RequestException as e:
        logging.error(f"Error fetching data: {e}")
        return None

def clean_asset_data(asset_json):
    """
    Transforms the API response into a more usable format:
    - Moves all keys under 'data' to the top level.
    - Converts the timestamp to a human-readable format.
    """
    if asset_json is None or "data" not in asset_json:
        logging.error("Invalid JSON format. Skipping transformation.")
        return None

    try:
        # Convert the timestamp to a formatted datetime string
        timestamp_ms = asset_json["timestamp"]
        formatted_timestamp = datetime.fromtimestamp(timestamp_ms / 1000).strftime("%Y-%m-%d %H:%M:%S")

        # Flatten the JSON by moving "data" fields to the top level
        cleaned_data = asset_json["data"]
        cleaned_data["timestamp"] = formatted_timestamp  # Add converted timestamp

        logging.info("Transformed Data: %s", json.dumps(cleaned_data, indent=2))
        return cleaned_data

    except KeyError as e:
        logging.error(f"Key error: {e}. Check API response format.")
        return None


def print_asset_data(asset_obs):
    """
    Print the processed asset data for debugging.
    """
    if asset_obs is None:
        logging.error("Received None for asset data. Skipping load.")
        return

    print("Final Processed Data:", json.dumps(asset_obs, indent=2))

