# set base image (host OS)
FROM python:3.8

# set the working directory in the container
WORKDIR /code

# copy the dependencies file to the working dir
COPY requirements.txt .

# install dependencies
RUN pip install -r ./requirements.txt

# copy the content to the working dir
COPY server.py .

# install pip and upgrade it
RUN apt-get update && apt-get install -y python3-pip
RUN pip3 install --upgrade pip

# uninstall Jinja2 library if present and install a specific version of it
RUN yes | pip3 uninstall jinja2 || echo "Jinja2 not found"
RUN pip3 install Jinja2==2.11.2

# upgrade Flask library
RUN pip3 install --upgrade Flask

# command to run on containter start
CMD [ "python", "./server.py" ]