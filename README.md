## docker-python3-django6-uwsgi-mssql

#### Python3 environment ready for deploy django applications with uwsgi and Microsoft SQL Server client

This is Docker image I use for deploy python django applications that use Microsoft SQL Server as database.
It uses pyodbc and SQLAlchemy for database related stuff.

Based on Debian 13.

Python has already installed following packages and its dependancies:

```
asgiref==3.11.1
astroid==4.0.4
certifi==2026.2.25
cffi==2.0.0
chardet==7.4.1
charset-normalizer==3.4.7
colorama==0.4.6
cryptography==46.0.6
dill==0.4.1
Django==6.0.4
django-jinja2==0.1
djangorestframework==3.17.1
dnspython==2.8.0
idna==3.11
isort==8.0.1
Jinja2==3.1.6
lxml==6.0.2
MarkupSafe==3.0.3
mccabe==0.7.0
packaging==26.0
pillow==12.2.0
pip-review==1.3.0
platformdirs==4.9.4
pycparser==3.0
pylint==4.0.5
pylint-django==2.7.0
pylint-plugin-utils==0.9.0
pymongo==4.16.0
pymssql==2.3.13
pyodbc==5.3.0
pytz==2026.1.post1
reportlab==4.4.10
requests==2.33.1
setuptools==82.0.1
sqlparse==0.5.5
tomlkit==0.14.0
tzdata==2026.1
urllib3==2.6.3
uWSGI==2.0.31
Werkzeug==3.1.8
xmltodict==1.0.4
```

All you need to add is your application files, and simple script for start.

Image starts uwsgi server, it can be configured via environment variables.
You can use it with nginx or standalone.

Following setup

```
APP_MODULE=myapp
APP_IP=0.0.0.0
APP_PORT=8000
APP_PROTOCOL=uwsgi
PROCESSES=1
THREADS=1
```

produces this command to start uwsgi server.

`uwsgi --socket "0.0.0.0:8000" --protocol uwsgi --module myapp.wsgi --master --processes 1 --threads 1`

Here is Dockerfile example, it cannot be simplier:

```
FROM emes30/django6

WORKDIR /app

COPY . .
```

and this is command for building your container:

`docker run -e APP_MODULE=my_module emes/my-module`

nginx configuration:

```
location /yourapp
{
  uwsgi_pass your_app_ip:8000;
  include uwsgi_params;
}
```
