# Use an official Miniconda runtime as a parent image
FROM continuumio/miniconda3:latest

# Set the working directory in the container
WORKDIR /app

# Create a conda environment with a specific Python version
RUN conda create --name imaging_python_env python=3.8

# Activate the conda environment
SHELL ["conda", "run", "-n", "imaging_python_env", "/bin/bash", "-c"]

# Install Jupyter and create a kernel named "imaging_python"
RUN conda install -y jupyter
RUN python -m ipykernel install --user --name=imaging_python

# Install brainspace and its dependencies
RUN conda install -y -c conda-forge brainspace vtk

# Expose the Jupyter notebook port
EXPOSE 8888

# Set the default command to launch Jupyter notebook
CMD ["conda", "run", "-n", "imaging_python_env", "jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
