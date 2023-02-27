#!/bin/python

# dump gnome keyring passwords

import base64
import json
import re
import secretstorage
import sys


conn = secretstorage.dbus_init()
collection = secretstorage.get_default_collection(conn)

passes = []
pattern = ".*"
output = None

if (len(sys.argv) >= 2):
    pattern = sys.argv[1]

if (len(sys.argv) >= 3):
    output = sys.argv[2]

for item in collection.get_all_items():
    label = item.get_label()
    if re.search(pattern, label):
        attr = item.get_attributes()
        secret = item.get_secret()
        passes.append({
            "label": label,
            "attributes": attr,
            "secret": base64.b64encode(secret).decode("utf8"),
        })
        print(label)

if (output == None and len(passes) > 0): print("---")

if (output != None and len(passes) > 0):
    with open(output, "w+") as f:
        f.write(json.dumps({ "passes": passes }, separators=(",", ":")))
else:
    print(json.dumps(passes, indent=4))
