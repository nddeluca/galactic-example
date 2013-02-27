#Base class for storing data associated with simple grayscale images.
#Each pixel is represented as a Float32 intensity value.
class Image
  #Initializes an ArrayBuffer and Float32Array for storing image data.
  constructor: (@width,@height) ->
    @buffer = new ArrayBuffer(@width*@height*4)
    @data = new Float32Array(@buffer)

module?.exports = Image
