# SVG

## trace vectors (stroke to path)
```
inkscape \
    input.svg \
    --export-type=svg \
    --export-filename=output.svg \
    --actions="select-all;object-stroke-to-path;export-do"
```
