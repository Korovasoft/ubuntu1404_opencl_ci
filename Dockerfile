FROM ubuntu:14.04

# Ubuntu Installs:
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common && \
	add-apt-repository -y ppa:george-edison55/cmake-3.x && apt-get update && apt-get install -y --no-install-recommends \
	python3 \
	python3-pip \
	llvm \
	clang-3.5 \
	doxygen \
	cmake \
	lsb-core \
	wget \
	&& rm -rf /var/lib/apt/lists/*

# OpenCL:
ENV INTEL_OPENCL_TARBALL http://registrationcenter.intel.com/irc_nas/5193/intel_code_builder_for_opencl_2015_ubuntu_5.0.0.43_x64.tgz
ENV INTEL_OPENCL_DIR intel_opencl
RUN mkdir -p $INTEL_OPENCL_DIR && \
    cd $INTEL_OPENCL_DIR && \
    wget -o tarball.tgz $INTEL_OPENCL_TARBALL && \
    tar xzf tarball.tgz -C . --strip-components=1 && \
    wget https://raw.githubusercontent.com/Korovasoft/ubuntu1404_scientific_publishing/master/intel_opencl_icd_install.conf && \
    ./install.sh --silent intel_opencl_icd_install.conf && \
    cd .. && \
    rm -rf $INTEL_OPENCL_DIR
