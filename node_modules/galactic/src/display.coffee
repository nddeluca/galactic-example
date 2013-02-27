#The Display class handles the displaying of grayscale image data, where each
#pixel of the original image is stored as Float32 intensity value.
#Using a chosen stretch (linear by default), the maps the original 
#Float32 intensity values onto a 0-255 integer instensity space.
#Then a with a chosen colormap (grayscale by default), the 0-255
#integer intensity values are mapped into RBGA pixel values for display
#on an HTML5 canvas.

Canvas = require('./canvas')
stretches = require('./stretches')
colors = require('./colors')
utils = require('./utils')
Image = require('./image')
Colormap = require('./colormap')

class Display extends Canvas
  #Initializes all the required information
  #and sets the width and height of the display.
  #
  #The container is the div element the display will be
  #appended to.  The desiredWidth is the with of this display,
  #and the height will automatically be set to preserve the aspect ratio.
  #The image object must have width, height, and a data attribute.
  #See image.coffee for an example of an image class.
  constructor: (container,desiredWidth,image) ->
    @image = new Image(image.width,image.height)
    @image.data = image.data
    @min = utils.min(image.data)
    @max = utils.max(image.data)

    scaledWidth = ~~desiredWidth
    @scaleRatio = @image.width/scaledWidth
    scaledHeight = ~~(@image.height/@scaleRatio)
    
    @buildColorBuffers()
    
    @stretch = stretches.linear
    @colormap = new Colormap(colors.gray)

    super container,scaledWidth,scaledHeight

  #Sets the stretch used to display the image.
  #The actually stretch functions are stored
  #in stretches.coffee.  It will return true
  #if the stretch is availiable or false if
  #no stretch fucntion is found.
  setStretch: (stretch) ->
    switch stretch
      when "linear"
        @stretch = stretches.linear
        true
      when "log"
        @stretch = stretches.log
        true
      when "power"
        @stretch = stretches.power
        true
      when "sqrt"
        @stretch = stretches.sqrt
        true
      when "arcsinh"
        @stretch = stretches.arcsinh
        true
      else false


  setColormap: (map) ->
    switch map
      when "gray"
        @colormap.setMap(colors.gray)
        true
      when "red"
        @colormap.setMap(colors.red)
        true
      when "green"
        @colormap.setMap(colors.green)
        true
      when "blue"
        @colormap.setMap(colors.blue)
        true
      when "heat"
        @colormap.setMap(colors.heat)
        true
      when "a"
        @colormap.setMap(colors.a)
        true
      when "b"
        @colormap.setMap(colors.b)
        true
      when "bb"
        @colormap.setMap(colors.bb)
        true
      when "cool"
        @colormap.setMap(colors.cool)
        true
      when "he"
        @colormap.setMap(colors.he)
        true
      when "rainbow"
        @colormap.setMap(colors.rainbow)
      when "standard"
        @colormap.setMap(colors.standard)
        true
      else false



  #Initilizes the ArrayBuffer for storing RBGA pixel data.
  #An 8-bit and 32-bit UintArray's are provided for the buffer.
  #The Uint8ClampedArray is provided for simpler usage; however,
  #the Uint32Array provides better performance.
  buildColorBuffers: ->
    @colorBuffer = new ArrayBuffer(@image.width*@image.height*4)
    @colorView8 = new Uint8ClampedArray(@colorBuffer)
    @colorView32 = new Uint32Array(@colorBuffer)
    undefined
  
  #Handles the processing of the image data into the required
  #form for display on a canvas.  It calls the stretch function,
  #colormap function, and scales the data using a nearest-neighbor
  #algorithm to fit the size of the canvas.  Also, the y-axis is flipped
  #to accomadate the origin location on the HTML5 canvas.
  processImage: ->
    colorView = @colorView32
    canvasView = @canvasView32
    height = @image.height
    width = @image.width

    @stretch(@image.data,colorView,@colormap.pixelMap,@min,@max)
    
    invertCoeff = (height - 1)*width
    scaleRatio = @scaleRatio
    canvasWidth = @canvasWidth
    canvasHeight = @canvasHeight

    x = canvasWidth
    while x--
      coeff = ~~(x*scaleRatio) + invertCoeff
      y = canvasHeight
      while y--
        canvasView[(canvasWidth*y)+x] = colorView[coeff - (~~(y*scaleRatio))*width]
    undefined
    
module?.exports = Display
