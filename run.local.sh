#!/usr/bin/env bash

ansible-playbook -i ./inventory.ini ./local.yml --vault-password-file ./secret.txt
