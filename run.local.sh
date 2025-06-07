#!/usr/bin/env bash

ansible-playbook ./local.yml --vault-password-file ./secret.txt
