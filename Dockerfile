FROM python:3.11-slim

# Install system deps (optional but good for pandas/xlsxwriter)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install Python deps
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app code
COPY . .

# Expose a default port (platform will usually override with PORT env)
EXPOSE 7860

# Start Streamlit, binding to the platform port if provided
CMD ["sh", "-c", "streamlit run app.py --server.port=${PORT:-7860} --server.address=0.0.0.0"]
