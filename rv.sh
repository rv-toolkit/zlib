#!/bin/sh
env CC=kcc LD=kcc CFLAGS="-fissue-report=./zlib_errors.json -std=gnu11" ./configure --static

# Delete errors from running configure
rm ./zlib_errors.json

make -j20
timeout 10m make check
touch ./zlib_errors.json

report_path="$PWD/report"
rv-html-report ./zlib_errors.json -o $report_path

rv-upload-report $report_path
