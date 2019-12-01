FROM python:3.7.3-slim

WORKDIR /env

EXPOSE 8888:8888
COPY requirements.txt /env/requirements.txt

RUN pip install --upgrade pip
RUN pip3 install \
    --requirement requirements.txt

ENTRYPOINT ["/bin/bash", "-c", "jupyter notebook --ip=0.0.0.0 --allow-root --path=/env/"]
