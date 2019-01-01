FROM lambci/lambda:build-python3.6

MAINTAINER "Luis Valenzuela" <luis@suscribe.la>

COPY yum.conf /etc/yum.conf

RUN yum clean all && \
    yum -y install python36-devel python36-virtualenv vim postgresql postgresql-devel gcc lapack-devel blas-devel libyaml-devel && \
    yum --enablerepo=epel -y install hdf5-devel && \
    pip install -U pip && \
    pip install -U zappa && \
    pip install pipenv 

WORKDIR /var/task

RUN virtualenv /var/venv && \
    source /var/venv/bin/activate && \
    pip install -U pip && \
    deactivate

COPY bashrc /root/.bashrc

CMD ["zappa"]
