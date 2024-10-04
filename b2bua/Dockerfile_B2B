FROM ubuntu

ENV DEBIAN_FRONTEND=noninteractive


RUN apt-get update && apt-get install -y \
    bash \   
    nano \
    wget \
    sngrep \
    git \
    make \
    iproute2

#Install go
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:longsleep/golang-backports -y
RUN apt install golang-go -y

#Install go-b2bua
WORKDIR /home/ubuntu
RUN git clone https://github.com/sippy/go-b2bua.git
WORKDIR /home/ubuntu/go-b2bua/sippy
RUN go mod tidy
RUN go build
WORKDIR /home/ubuntu/go-b2bua
RUN make
