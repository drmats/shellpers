#!/bin/python

# resore gnome keyring passwords

import base64
import json
import secretstorage
import sys


conn = secretstorage.dbus_init()
collection = secretstorage.get_default_collection(conn)

input_file = None

if (len(sys.argv) != 2):
    print("specify input file")
    exit(1)
else:
    input_file = sys.argv[1]

if input_file != None:
    with open(input_file, "r") as f:
        passes = json.loads(f.read())["passes"]
        for p in passes:
            print(p["label"])
            collection.create_item(
                p["label"],
                p["attributes"],
                base64.b64decode(p["secret"])
            )
