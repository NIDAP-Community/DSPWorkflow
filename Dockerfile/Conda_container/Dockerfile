# Modified from Dockerhub R-base official images
# https://hub.docker.com/layers/library/r-base/4.1.3/images/sha256-567cb8968827c97e1fb788e23e9a3acf8a5d95c6dbeeb88a48ae438e05fe2da0?context=explore

# Container image that runs the code
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update  && \
    apt-get install -y --no-install-recommends \
      ed \
      less \
      locales \
      vim-tiny \
      wget \
      ca-certificates \
      fonts-texgyre libx11-dev && \
      rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      software-properties-common \
      dirmngr \
      curl \
      libcurl4-openssl-dev && \
    add-apt-repository --enable-source --yes "ppa:marutter/rrutter4.0" && \
    add-apt-repository --enable-source --yes "ppa:c2d4u.team/c2d4u4.0+"

# ## Configure default locale, see https://github.com/rocker-org/rocker/issues/19
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
  locale-gen en_US.utf8 && \
	/usr/sbin/update-locale LANG=en_US.UTF-8

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

# ## Use Debian unstable via pinning -- new style via APT::Default-Release
# #RUN echo "deb http://http.debian.net/debian sid main" > /etc/apt/sources.list.d/debian-unstable.list \
# #        && echo 'APT::Default-Release "testing";' > /etc/apt/apt.conf.d/default
# #

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      libx11-6 \
      libxss1 \
      libxt6 \
      libxext6 \
      libsm6 \
      libice6 \
      xdg-utils \
      libxt-dev \
      xorg-dev \
      libcairo2 \
      libcairo2-dev \
      libpango1.0-dev && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && \ 
    apt install -y --no-install-recommends \
      zlib1g-dev \
      libcurl4-openssl-dev \
      libxml2-dev \
      libssl-dev \
      libpng-dev \
      libhdf5-dev \
	    libquadmath0 \
	    libtiff5-dev \
	    libjpeg-dev \
	    libfreetype6-dev \
	    libgfortran5 \
	    libgmp-dev \
	    libmpc-dev \
	    libopenblas0-pthread \
	    libgeos-dev \
      cmake \
      libfftw3-dev

RUN apt-get -y update && apt-get -y install git

# # add the signing key (by Michael Rutter) for these repos
# # To verify key, run gpg --show-keys /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc 
# # Fingerprint: E298A3A825C0D65DFD57CBB651716619E084DAB9

# # add the R 4.0 repo from CRAN -- adjust 'focal' to 'groovy' or 'bionic' as needed

# ENV R_BASE_VERSION=4.1.3

# RUN wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc && \
#    add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/" && \
#    add-apt-repository ppa:c2d4u.team/c2d4u4.0+ && \
#    apt update && \
#    apt-get install -y --no-install-recommends \
#     r-cran-rjava \
#     r-base-core=${R_BASE_VERSION}-* \
# 	  r-base-dev=${R_BASE_VERSION}-*

# RUN R -e 'install.packages("devtools")'
# RUN R -e 'install.packages("renv")'
# RUN R -e 'install.packages("lintr")'

# RUN mkdir /renv_cache
# ENV RENV_PATHS_CACHE="/renv_cache"

# COPY Building_R_environment/* .

# RUN R -e 'initiate=TRUE; source("Initiate_Renv.R"); source("Generate_Renv.R")'

RUN pwd
ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"

RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-py38_22.11.1-1-Linux-x86_64.sh \
#    && mkdir /root/.conda \
    && bash Miniconda3-py38_22.11.1-1-Linux-x86_64.sh  -b \
    && rm -f Miniconda3-py38_22.11.1-1-Linux-x86_64.sh

RUN conda --version
RUN conda install -n base conda-libmamba-solver \
    && conda config --set solver libmamba

RUN conda config --append channels defaults
RUN conda config --append channels anaconda
RUN conda config --append channels bioconda
RUN conda config --append channels conda-forge
RUN conda config --append channels bu_cnio
RUN conda config --append channels esgf

RUN conda install -c conda-forge mamba

RUN conda init bash

ENV PATH /opt/conda/envs/env/bin:$PATH

#SHELL ["/bin/bash", "-c"]

RUN chmod -R ugo+rwx /opt
RUN chmod -R ugo+rwx /tmp
RUN echo "TMPDIR=/tmp" > /root/.Renviron

RUN mkdir /local_channel
RUN mkdir /local_channel/linux-64
RUN conda install conda-build

COPY bioconductor-nanostringnctools-1.4.0-r41hdfd78af_0.tar.bz2 /local_channel/linux-64
COPY bioconductor-spatialdecon-1.4.3-r41hdfd78af_0.tar.bz2 /local_channel/linux-64
COPY bioconductor-geomxtools-3.1.1-r41hdfd78af_0.tar.bz2 /local_channel/linux-64
COPY bioconductor-nanostringnctools-1.2.0-r41hdfd78af_0.tar.bz2 /local_channel/linux-64

RUN conda index /local_channel/

RUN conda config --add channels file:///local_channel/

### For .yml method
COPY environment.yml .
RUN mamba env update -f environment.yml

RUN echo "source activate DSPWorkflow_NIDAP" >> ~/.bashrc

ENV PATH="/root/miniconda3/envs/DSPWorkflow_NIDAP/bin:$PATH"

# Create target directory
RUN mkdir -p /renv/library/R-4.1/x86_64-pc-linux-gnu

# Create symbolic links
RUN for d in /root/miniconda3/envs/DSPWorkflow_NIDAP/lib/R/library/*; do \
   if [ -d "$d" ]; then \
       ln -s "$d" "/renv/library/R-4.1/x86_64-pc-linux-gnu/$(basename $d)"; \
   fi \
done

CMD ["bash"]

