Galactic
==========
A library for displaying fits images of galaxies and interactivley creating models of their light profiles.

Install
---
Assuming you're the project inside a spinejs or hem application:

Add to package.json
```coffeescript
"dependencies": {
  "galactic": "git://github.com/nddeluca/galactic.git"
}
```
Add to slug.json
```coffeescript
"dependencies": [
  "galactic"
]
```
Run
```bash
npm install
```

Usage
===

Displaying a Galaxy From a FITS Image
---
To display a fits file create a new Display Object.  The Display class takes a container id, width, and an image.
The conainter id is the css id of the containing div element where the canvas will be created.
The width is the width of the canvas the fits image is displayed on (also the width of the image).
The image is any object with data, width, and height attributes.
```coffeescript
myDisplay = new Galactic.Display(container_id, width, image)
```
Once a Display is created, call processImage() to build the image and draw() to display  it on the canvas.
```coffeescript
myDisplay.processImage()
myDisplay.draw()
```
The default scaling of the image is linear, and the default colormap is grayscale.
The height is set by using the intial width to keep the same aspect ratio.  Also, the canvas 
does not have to be the same size as the fit file image.
The fits image will be scaled down or up to fit the canvas when drawn.

Example:
```coffeescript
FitsCanvas = require('fits_canvas')
FITS = require('fits')

xhr = new XMLHttpRequest()
xhr.open('GET', 'images/my_fits_file.fits')
xhr.responseType = 'arraybuffer'    
xhr.send()

xhr.onload = (e) ->
  #Use atrojs/fitsjs to get fits image from binary file
  fitsFile = new FITS.file(xhr.response)
  image = fitsFile.getDataUnit()
  image.getFrame()
  
  display = new FitsCanvas.Display('my-canvas-container',500,image)
  display.processImage()
  display.draw()
```
```html
<div id="my-canvas-container"></div>
```



To Do
---
* Write tests and benchmark
* Add processor endainness check (the grayscale algorithm currently only works on little-endian machines)

References
---
https://github.com/astrojs/fitsjs  
https://hacks.mozilla.org/2011/12/faster-canvas-pixel-manipulation-with-typed-arrays/  
http://tech-algorithm.com/articles/nearest-neighbor-image-scaling/  
http://coffeescriptcookbook.com/  


