# img2css - A simple bash script to convert a regular image in to a webpage.

## Overview

The `img2css.sh` script reads and processes an image you give it and produces a
html and css file.

For each pixel in the image a `<div>` is created in the resulting html file.
To minimize the total `<div>` count a simple version of [run-length
encoding](https://en.wikipedia.org/wiki/Run-length_encoding) is
employed whereby neighbouring `<div>`'s with the same color are merged into one
with the appropriate width. In certain images this method can reduce the number
of `<div>`'s significantly.

The css file contains the color palette of the image, it has a class for every
color of the input image represented in hex.
These color classes are used to color the appropriate `<divs>`'s.

## Demo
![Example](./media/demo.gif)

## Usage
```
git clone https://github.com/begone-prop/img2css.git
cd imag2css
./img2css yourImage.png
```

## Dependencies

- **imagemagick**
