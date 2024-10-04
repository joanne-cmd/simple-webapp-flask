# Use the official Python image from the Docker Hub
FROM python:3.9

# Set the working directory
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . .

# Install Flask
RUN pip install Flask

# Expose port 80
EXPOSE 80

# Run the application
CMD ["python", "app.py"]  # Ensure this matches the name of your Python file

