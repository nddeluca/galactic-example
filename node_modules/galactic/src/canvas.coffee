#The Canvas class is used to handle the creation and drawing
#of a canvas.
class Canvas
  #Create a new canvas element and appends it to
  #the provided container.
  constructor: (@container,@canvasWidth,@canvasHeight) ->
    @canvasContainer = document.getElementById(@container)
    @canvas = document.createElement('canvas')
    @canvas.width = @canvasWidth
    @canvas.height = @canvasHeight
    @canvasContainer.appendChild(@canvas)
    @context = @canvas.getContext('2d')
    @buildImageBuffers()

  #Initializes the ArrayBuffer and DataViews for storing the
  #image that will be displayed on the canvas.  Two views are
  #provided: A Uint8ClampledArray for easier use and forced
  #0 to 255 range. A Uint32Array is provided for faster performance
  #and access to the ArrayBuffer.
  buildImageBuffers: ->
    @canvasData = @context.createImageData(@canvasWidth,@canvasHeight)
    @canvasBuffer = new ArrayBuffer(@canvasData.data.length)
    @canvasView8 = new Uint8ClampedArray(@canvasBuffer)
    @canvasView32 = new Uint32Array(@canvasBuffer)
    undefined

  #Puts the image data on the canvas for display.
  draw: ->
    cData = @canvasData
    cData.data.set(@canvasView8)
    @context.putImageData(cData,0,0)
    undefined

module?.exports = Canvas
