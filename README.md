# Laravel PHP Scheduler

[![Build Status](https://jenkins.epicfail.dev/buildStatus/icon?job=Docker+-+Laravel+PHP+Scheduler)](https://jenkins.epicfail.dev/job/Docker%20-%20Laravel%20PHP%20Scheduler/)

This is a docker PHP package used for the production environments with artisan scheduler. Package is repeatedly running `php artisan schedule:run`. 
Image has preinstalled python3 and packages for working with files in background such as `tesseract-ocr`, `zbar` or `ffmpeg`

## Core image
Based on `epicfailstudio/laravel-php-backend:7.4php` docker image

### python requirements:
```ini
PyPDF2
EbookLib==0.16
pocketsphinx==0.1.15
textract
pypng
zbar-py
pillow
qrtools
pdf2image
opencv-python
opencv-contrib-python
```
