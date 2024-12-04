FROM python:3.12-alpine

LABEL org.opencontainers.image.source=https://github.com/jamie-mh/zerodowndeploy
LABEL project=zerodowndeploy

RUN apk --no-cache add curl

RUN python -m venv /venv
COPY ./requirements.txt /venv/requirements.txt
RUN /venv/bin/pip install --no-cache-dir --upgrade -r /venv/requirements.txt

COPY ./app /app
WORKDIR /app

CMD ["/venv/bin/gunicorn", "main:app", "-w", "4", "-k", "uvicorn.workers.UvicornWorker", "--bind", "0.0.0.0:8000"]
