# Use an official Miniconda image as a parent image
FROM continuumio/miniconda3

# Set the working directory in the container
WORKDIR /usr/src/app

# Create a Conda environment and install all packages in one go to ensure compatibility
RUN conda create --name imaging_env python=your_python_version pip ipykernel notebook -c conda-forge && \
    conda clean --all --yes

# Activate the script mods for conda in shell
RUN echo "source activate imaging_env" > ~/.bashrc
ENV PATH /opt/conda/envs/imaging_env/bin:$PATH

# Install VTK and brainspace within the Conda environment
RUN conda install -c conda-forge vtk -n imaging_env && \
    pip install brainspace

# Create a Jupyter kernel for the environment
RUN python -m ipykernel install --user --name imaging_python --display-name "imaging_python"

# Make port 8888 available to the world outside this container
EXPOSE 8888

# Using "conda run" to ensure the environment is activated correctly
CMD ["conda", "run", "-n", "imaging_env", "jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]

