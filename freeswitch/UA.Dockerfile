FROM ubuntu

ARG PORT
ARG USER

ENV PORT=$PORT
ENV CLIENT=$USER
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /home/ubuntu

COPY tcp_template.conf /home/ubuntu/tcp_template.conf
COPY udp_template.conf /home/ubuntu/udp_template.conf

RUN apt-get update && apt-get install -y \
    bash \   
    nano


RUN apt install wget -y \
    gcc \
    g++ \
    make

RUN wget https://github.com/pjsip/pjproject/archive/refs/tags/2.14.1.tar.gz -O /home/ubuntu/pjsua.tar.gz
RUN tar -xzf /home/ubuntu/pjsua.tar.gz
RUN rm pjsua.tar.gz
RUN mv ./pj* ./pjsua
WORKDIR /home/ubuntu/pjsua
RUN ./configure && make dep && make

RUN apt install wget -y
RUN apt install gcc -y
RUN apt install g++ -y
RUN apt install make -y

RUN apt install gettext-base -y
RUN export CFLAGS="$CFLAGS -fPIC"
RUN cp ./pjsip-apps/bin/pjsua* /usr/local/bin/pjsua



COPY pjsua.sh /usr/local/bin
RUN chmod +x /usr/local/bin/pjsua.sh

WORKDIR /home/ubuntu

RUN apt install iproute2 -y


ENTRYPOINT [ "pjsua.sh" ]