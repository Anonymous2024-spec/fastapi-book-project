# Use official Python image from Docker Hub
FROM python:3.9

# Install Nginx
RUN apt-get update && apt-get install -y nginx

# Set the working directory inside the container
WORKDIR /app

# Copy all project files into the container
COPY . /app

# Install Python dependencies
RUN pip install --no-cache-dir --upgrade pip && pip install -r requirements.txt

# Copy the Nginx configuration file into the container
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80 for Nginx and port 8000 for FastAPI
EXPOSE 80
EXPOSE 8000

# Start Nginx and FastAPI app with Uvicorn
CMD service nginx start && uvicorn main:app --host 0.0.0.0 --port 8000
