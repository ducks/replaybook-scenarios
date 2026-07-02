FROM python:3.12-alpine
WORKDIR /app
COPY app.py run.sh ./
COPY app.env /app/.env
CMD ["sh", "/app/run.sh"]
