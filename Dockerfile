FROM python:slim

# Set environment variables without spaces
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Install OS dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgomp1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy project files
COPY . .

# Install Python dependencies
RUN pip install --no-cache-dir -e .

# Optional: Run training pipeline here (consider moving this to runtime instead)
RUN python pipeline/training_pipeline.py

# Expose port
EXPOSE 5000

# Start application
CMD ["python", "application.py"]
