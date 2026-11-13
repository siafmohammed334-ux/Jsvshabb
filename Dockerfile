FROM python:3.12-slim
RUN apt-get update && apt-get install -y --no-install-recommends ffmpeg && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
ENV PORT=8000
# worker واحد + threads: علشان التحديث التلقائي يشتغل مرة واحدة بس
CMD ["sh", "-c", "gunicorn -w 1 --threads 8 -t 600 -b 0.0.0.0:${PORT} server:app"]
