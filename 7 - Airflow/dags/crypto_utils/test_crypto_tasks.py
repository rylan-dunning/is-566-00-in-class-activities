# import sys
# import os
# import json

from crypto_tasks import *

if __name__ == "__main__":

    # 01-CryptoPrint tests:
    #   pull_asset_data
    #   clean_asset_data
    #   print_asset_data
    raw_data = pull_asset_data('bitcoin')
    cleaned_data = clean_asset_data(raw_data)
    if cleaned_data:
        print_asset_data(cleaned_data)
    
    # Test load_asset_data (uncomment the next line)
    # load_asset_data(cleaned_data, host = 'localhost')