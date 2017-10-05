FROM python:2.7
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq -y update && apt-get -qq -y dist-upgrade
RUN apt-get -qq -y install python-pip build-essential python-dev \
        libxml2-dev libxslt1-dev libpq-dev apt-utils ca-certificates \
        postgresql-client-9.4 libopenjpeg5 libtiff5-dev libjpeg-dev zlib1g-dev \
        libtesseract-dev libicu-dev tesseract-ocr-eng

RUN apt-get -qq -y autoremove && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV TESSDATA_PREFIX /usr/share/tesseract-ocr

RUN pip install -q --upgrade pip && pip install -q --upgrade setuptools
RUN pip install -q --upgrade psycopg2 pyicu lxml

COPY setup.py /memorious/
COPY memorious /memorious/memorious
WORKDIR /memorious
RUN pip install -q -e .

ENV MEMORIOUS_BASE_PATH /data