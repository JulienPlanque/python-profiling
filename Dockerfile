# Utilise une image de base Python officielle
FROM python:3.9-slim

WORKDIR /app
RUN pip3 install psutil
COPY . .

ENTRYPOINT ["python"]
