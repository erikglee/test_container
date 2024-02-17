# Use a minimal base image
FROM ubuntu:24.04

# Install miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh && \
    bash miniconda.sh -b -p /opt/miniconda && \
    rm miniconda.sh

# Set environment variables
ENV PATH="/opt/miniconda/bin:$PATH"
ENV PYTHONPATH="/opt/miniconda/envs/imaging_python/lib/python3.9/site-packages"

# Create a conda environment with Python 3.9 and Jupyter
RUN conda create -n imaging_python python=3.9 jupyter notebook

# Activate the environment
RUN conda activate imaging_python

# Install imaging libraries and dependencies
RUN conda install -c conda-forge vtk -y
RUN conda install -c anaconda brainspace -y

# Install jupyter notebook kernel for "imaging_python" environment
RUN jupyter kernelspec install --display-name "imaging_python" --python /opt/miniconda/envs/imaging_python/bin/python

# Clean up
RUN conda clean --all

# Expose jupyter notebook port
EXPOSE 8888

# Set a working directory and start the jupyter notebook server
WORKDIR /notebooks
CMD ["jupyter", "notebook", "--allow-root"]
