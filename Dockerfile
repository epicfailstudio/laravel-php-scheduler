FROM epicfailstudio/laravel-php-backend:8.3php

USER root
RUN apt-get update

COPY ./assets/start.sh /usr/local/bin/start

RUN chmod a+x /usr/local/bin/start

RUN apt-get update
RUN apt-get install -y cron wget dnsutils net-tools libc-bin locales gnupg

# Install python3 and dependencies needed for OCR and document processing
RUN apt-get install -y python-dev-is-python3 libxml2-dev libxslt1-dev antiword poppler-utils zlib1g-dev build-essential libssl-dev libffi-dev libblas-dev libatlas-base-dev
RUN apt-get install -y unrtf
RUN apt-get install -y tesseract-ocr
RUN apt-get install -y flac
RUN apt-get install -y ffmpeg
RUN apt-get install -y lame
RUN apt-get install -y libmad0
RUN apt-get install -y libsox-fmt-mp3
RUN apt-get install -y sox
RUN apt-get install -y libjpeg-dev
RUN apt-get install -y swig
RUN apt-get install -y libpulse-dev
RUN apt-get install -y libasound2-dev

RUN apt-get install -y libwebp-dev libpng-dev libtiff5-dev libopenexr-dev libgdal-dev
RUN apt-get install -y python3-tk python3-numpy

# Install ZBar
RUN apt-get install -y zbar-tools libzbar-dev

# because F*CK security!
RUN rm /usr/lib/python3.11/EXTERNALLY-MANAGED

# Copy and Install python PIP packages
COPY ./assets/requirements.txt /root/requirements.txt
RUN pip3 install -r /root/requirements.txt

RUN apt install -y ocrmypdf
RUN apt install -y tesseract-ocr-slk

RUN echo 'post_max_size = 512M' >> $PHP_INI_DIR/php.ini

RUN apt-get install -y zip

# set user as www-data because default user sometimes mess with privileges when multiple machines access to the same resource
USER www-data

CMD ["/usr/local/bin/start"]