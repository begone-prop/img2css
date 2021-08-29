# img2css - A simple bash script to convert a regular image in to a webpage.

The script generates a html file and a css file.

The css file contains a class for each color used in the picture.

The html file contains the needed divs for displaying the image.
Multiple divs with the identical color that are next to each other are merged into a
single div with the appropriate width.
This can sometimes reduce the number divs that need to be drawn significantly.

## Usage
`./img2css yourImage.png`

## Dependencies

- **mediainfo**
- **imagemagick**
