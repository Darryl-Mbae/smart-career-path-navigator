# 1. Use a lightweight Python base image
FROM python:3.12

# 2. Set working directory
WORKDIR /app

# 3. Prevent Python from writing .pyc files
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# 4. Install system dependencies (optional but safe)
RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# 5. Copy dependency list
COPY requirements.txt .

# 6. Install Python dependencies
RUN pip install --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# 7. Copy the rest of your app
COPY . .

# 8. Expose the Jac server port
EXPOSE 8000

# 9. Run the Jac server
CMD ["jac", "serve", "app.jac", "--host", "0.0.0.0", "--port", "8000"]
