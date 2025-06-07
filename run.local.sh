#!/usr/bin/env bash

ansible-playbook ./local.yml --ask-become-pass --vault-password-file ./secret.txt
