class Canvas
  constructor: (@container,@canvasWidth,@canvasHeight) ->
    @canvasContainer = document.getElementById(@container)
    @canvas = document.createElement('canvas')
    @canvas.width = @canvasWidth
    @canvas.height = @canvasHeight
    @canvasContainer.appendChild(@canvas)
    @context = @canvas.getContext('2d')
    @buildImageBuffers()
    
  buildImageBuffers: ->
    @canvasData = @context.createImageData(@canvasWidth,@canvasHeight)
    @canvasBuffer = new ArrayBuffer(@canvasData.data.length)
    @canvasView8 = new Uint8ClampedArray(@canvasBuffer)
    @canvasView32 = new Uint32Array(@canvasBuffer)
    undefined

  draw: ->
    @canvasData.data.set(@canvasView8)
    @context.putImageData(@canvasData,0,0)
    undefined

module?.exports = Canvas
