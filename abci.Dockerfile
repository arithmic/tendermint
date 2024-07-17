# Use an official Ubuntu as a parent image
FROM golang:1.18

# Set environment variables for Go
ENV TMHOME = /tendermint
ENV GOROOT /usr/local/go
ENV GOPATH /go
ENV PATH $GOPATH/bin:$GOROOT/bin:$PATH

# Install required packages
RUN apt-get update && \
    apt-get install -y wget \
    git \
    make \
    && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR $TMHOME

# Clone the repository
# RUN git clone --branch v0.34.24 https://github.com/tendermint/tendermint.git
# Create a dir for tendermint in ~/github
RUN mkdir -p /github/tendermint
COPY . /github/tendermint

# Verify the build
RUN ls -l /github/tendermint

RUN cd /github/tendermint && make install_abci

EXPOSE 26658

CMD ["abci-cli", "kvstore"]