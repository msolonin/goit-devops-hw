FROM python:3.10-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 8000 8001
CMD ["sh", "-c", "python manage.py runserver 0.0.0.0:8000 & python manage.py run_prometheus_server 0.0.0.0:8001"]
