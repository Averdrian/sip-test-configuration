FROM vulhub/flask:1.1.1

RUN apt-get update && apt-get install -y \
    bash \
    swig


ENTRYPOINT [ "bash" ]