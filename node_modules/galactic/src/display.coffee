Canvas = require('./canvas')
stretches = require('./stretches')
colors = require('./colors')
utils = require('./utils')
Image = require('./image')

class Display extends Canvas
  constructor: (container,desiredWidth,image) ->
    #Set up image data and information
    @image = new Image(image.width,image.height)
    @image.data = image.data

    @min = utils.min(image.data)
    @max = utils.max(image.data)


    #Find scaled width, scale ratio,
    #and corresponding height (keeps same aspect ratio)
    #In addition use ~~ to truncat values for integer pixels
    scaledWidth = ~~desiredWidth
    @scaleRatio = @image.width/scaledWidth
    scaledHeight = ~~(@image.height/@scaleRatio)
    
    #Build buffers for stretch and coloring
    @buildStretchBuffers()
    @buildColorBuffers()
    
    #Set default scale and color
    @stretch = stretches.linear
    @color = colors.grayscale


    #Call super to set up canvas and display buffers
    #This also sets @width and @height
    super container,scaledWidth,scaledHeight

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

  #This holds fits data with an applied scale (linear, log, etc)
  #All values should be 0 to 255 only
  buildStretchBuffers: ->
    @stretchBuffer = new ArrayBuffer(@image.width*@image.height)
    @stretchView8 = new Uint8ClampedArray(@stretchBuffer)
    undefined

  #Holds RGBA Array
  buildColorBuffers: ->
    @colorBuffer = new ArrayBuffer(@image.width*@image.height*4)
    @colorView8 = new Uint8ClampedArray(@colorBuffer)
    @colorView32 = new Uint32Array(@colorBuffer)
    undefined
  
  processImage: ->
    @stretch(@image.data,@stretchView8,@min,@max)
    @color(@stretchView8,@colorView32)

    invertCoeff = (@image.height - 1)*@image.width

    for x in [0..(@canvasWidth-1)]
      coeff = ~~(x*@scaleRatio) + invertCoeff
      for y in [0..(@canvasHeight-1)]
        @canvasView32[(@canvasWidth*y)+x] = @colorView32[coeff - (~~(y*@scaleRatio))*@image.width]
    undefined
    
module?.exports = Display
