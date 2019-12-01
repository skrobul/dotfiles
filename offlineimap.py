#!/usr/bin/env python2
# don't forget to
#     sudo dnf install python2-dbus offlineimap
#     pip2 install keyring secretstorage
# offlineimap does not use python3 yet 
import keyring
import secretstorage

def get_password(host, username):
  backend = keyring.get_keyring()
  collection = backend.get_preferred_collection()
  for item in collection.search_items({"service": "smtp", "host": host, "user": username}):
    return item.get_secret()# .decode('utf-8')
