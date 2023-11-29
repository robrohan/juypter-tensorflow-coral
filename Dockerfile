# FROM jupyter/base-notebook:python-3.8.6
FROM jupyter/tensorflow-notebook:python-3.8.13
# FROM quay.io/jupyter/tensorflow-notebook:python-3.8.13

USER root
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        curl apt-utils apt-transport-https gnupg2 \
    && rm -rf /var/lib/apt/lists/*

# for apt to get the coral libraries
RUN echo "deb https://packages.cloud.google.com/apt coral-edgetpu-stable main" | tee /etc/apt/sources.list.d/coral-edgetpu.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

# actually fetch the c libs
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        libedgetpu1-std \
    && rm -rf /var/lib/apt/lists/*

USER jovyan
RUN python --version
# grab the pycoral python libraires
RUN python -m pip install \
    --extra-index-url https://google-coral.github.io/py-repo/ pycoral~=2.0
# and upgrade tensorflow
RUN python -m pip install \
    tensorflow==2.10.0 h5py Pillow tqdm ftfy regex \
    tensorflow-addons tensorflow_datasets
RUN python -m pip cache purge

# running example:
# docker run -v $(pwd):/home/jovyan/work -p 8888:8888 jupyter/scipy-notebook
