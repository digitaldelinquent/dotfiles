#! /usr/bin/python3

import pandas as pd
import math
import json
import uuid
import os
import sys
from dotenv import load_dotenv

load_dotenv()

# Pull bacth limit from environment vars
try: 
    BATCH_LIMIT = int(os.environ["BATCH_LIMIT"])
except KeyError as e:
    sys.exit(f"Your .env file has does not have a value for {e}, please ensure all environment vars have values.")

    
# Initialize CSV and JSON files and check if they exist
try: 
    csv_file_path = os.environ["file_CSV"]
    json_file_path = os.environ["file_JSON"]
except KeyError as e:
    sys.exit(f"\n\nYour .env file has does not have a value for {e}, please ensure all environment vars have values.")

# Create a dict that will be dumped into the JSON file output
data = { "data": [] }

# Open file to get the record count
with open(csv_file_path, encoding='utf-8') as csvf:
    csv_row_count = sum(1 for row in csvf) - 1

print(f"Number of records: {csv_row_count}")

# Count how many batches there will be for a given serializer_type
batch_count = 0

# Open file for serializing csv to JSON
with pd.read_csv(csv_file_path, chunksize=BATCH_LIMIT, dtype=str) as csvf:
   
    # Use pandas to chunkify the data
    for chunk in csvf:

        # Put data in the dictionary, remove NaNs and fill them with empty
        # strings and lastly orient the dict into records. Without
        # orienting the dict the data will be broken
        data["data"] = chunk.fillna("").to_dict(orient="records")

        # Open json file
        with open(json_file_path, 'w', encoding='utf-8') as jsonf:

            # Write json to file
            jsonf.write(json.dumps(data, indent=4))

            print(f"JSON file has been created at {json_file_path}")

        batch_count += 1

        # If csv row count is higher than batch limit, it will create
        # a new json file path to use
        if csv_row_count > BATCH_LIMIT:
            json_file_path = f"{batch_count}-{os.environ['file_JSON']}"

        # If csv row count is higher than batch limit, it will print the
        # following as it will run if more than one chunk is needed.
        if csv_row_count > BATCH_LIMIT and batch_count != math.ceil(csv_row_count / BATCH_LIMIT) :
            print(f"Threshold hit generating a separate JSON file: \n")

print("All files have been generated.")
