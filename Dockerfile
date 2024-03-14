# Use an official Python runtime as the base image
FROM python:3.9

# Set the working directory in the container
WORKDIR /app

# Copy the Python script and requirements file into the container
COPY fetch-logs.py /app/

# Install the Python dependencies
# RUN pip install --no-cache-dir -r requirements.tx

RUN pip install kubernetes 

# Run the Python script when the container launches
CMD ["python", "fetch-logs.py"]

