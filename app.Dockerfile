FROM python:3.12-alpine
LABEL org.opencontainers.image.source=https://github.com/jamie-mh/zerodowndeploy

RUN apk --no-cache add curl

COPY ./requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /tmp/requirements.txt && rm /tmp/requirements.txt

COPY ./app /app
WORKDIR /app

CMD ["fastapi", "run", "main.py", "--proxy-headers", "--port", "8000"]
