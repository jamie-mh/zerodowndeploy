FROM python:3.12-alpine
LABEL org.opencontainers.image.source=https://github.com/jamie-mh/zerodowndeploy

RUN apk --no-cache add curl

RUN python -m venv /venv
COPY ./requirements.txt /venv/requirements.txt
RUN /venv/bin/pip install --no-cache-dir --upgrade -r /venv/requirements.txt

COPY ./app /app
WORKDIR /app

CMD ["/venv/bin/fastapi", "run", "main.py", "--proxy-headers", "--port", "8000"]
