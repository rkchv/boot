#!/usr/bin/env bash

ansible-playbook -i ./inventory.ini --ask-become-pass ./darwin.yml
