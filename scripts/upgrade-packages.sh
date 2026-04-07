#!/bin/bash

docker run --entrypoint="/bin/bash" -v ./requirements.txt:/app/requirements.txt emes/python3-django:3.12 -c "pip install pip-review && pip-review --auto && pip freeze > /app/requirements.txt"