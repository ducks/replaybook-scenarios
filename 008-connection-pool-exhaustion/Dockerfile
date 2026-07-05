FROM python:3.12-alpine
# pg8000 is pure python - no libpq or C toolchain needed on musl
RUN pip install --no-cache-dir pg8000
WORKDIR /app
COPY app.py leak.py ./
CMD ["python", "/app/app.py"]
