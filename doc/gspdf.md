# gostscript / pdf

## reduce pdf file size

```
$ gs -dBATCH -dNOPAUSE -q \
    -sDEVICE=pdfwrite \
    -sOutputFile=output.pdf \
    input.pdf
```

```
$ ps2pdf \
    -dPDFSETTINGS=/screen \
    -dDownsampleColorImages=true \
    -dColorImageResolution=300 \
    -dColorImageDownsampleType=/Bicubic \
    input.pdf output.pdf
```
