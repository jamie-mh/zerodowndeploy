FROM python:3.12-alpine

RUN apk --no-cache add curl

COPY ./requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /tmp/requirements.txt && rm /tmp/requirements.txt

COPY ./app /app
WORKDIR /app

CMD ["fastapi", "run", "main.py", "--proxy-headers", "--port", "8000"]
