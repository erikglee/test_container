# Use an official Miniconda3 image as the base image
FROM continuumio/miniconda3:latest

# Set the working directory in the container
WORKDIR /app

# Create a Conda environment with Python 3.8 and activate it
RUN conda create --name imaging_python python=3.8

# Activate the Conda environment
SHELL ["conda", "run", "-n", "imaging_python", "/bin/bash", "-c"]

# Install Jupyter notebook and set up the "imaging_python" kernel
RUN conda install -y jupyter
RUN python -m ipykernel install --user --name imaging_python --display-name "imaging_python"

# Install brainspace using pip within the Conda environment
RUN pip install brainspace

# Expose the Jupyter notebook port
EXPOSE 8888

# Set the default command to launch Jupyter notebook when the container runs
CMD ["conda", "run", "--no-capture-output", "-n", "imaging_python", "jupyter", "notebook", "--ip='0.0.0.0'", "--port=8888", "--no-browser", "--allow-root"]
