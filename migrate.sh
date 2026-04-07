#!/bin/bash

echo "Apply migrations for: $1"
python3 manage.py migrate $1
