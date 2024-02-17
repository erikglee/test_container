# Use an official Miniconda image as a parent image
FROM continuumio/miniconda3

# Set the working directory in the container
WORKDIR /usr/src/app

# Create a Conda environment
# Replace "your_python_version" with the desired version of Python, e.g., "3.8"
RUN conda create --name imaging_env python=your_python_version

# Activate the environment
SHELL ["conda", "run", "-n", "imaging_env", "/bin/bash", "-c"]

# Install Jupyter
RUN conda install -c conda-forge notebook ipykernel

# Install VTK and brainspace within the Conda environment
RUN conda install -c conda-forge vtk
RUN pip install brainspace

# Create a Jupyter kernel for the environment
RUN python -m ipykernel install --user --name imaging_python --display-name "imaging_python"

# Make port 8888 available to the world outside this container
EXPOSE 8888

# Run Jupyter Notebook when the container launches
CMD ["jupyter", "notebook", "--ip='*'", "--port=8888", "--no-browser", "--allow-root"]
