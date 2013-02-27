Image = require('./image')

class Residual extends Image
  constructor: (@width,@height) ->
    super(@width,@height)


  #Finds the difference between the
  #fits and model data and stores it
  build: (fitsData,modelData) ->
    data = @data
    i = @width*@height
    while i--
      data[i] = fitsData[i] - modelData[i]
    undefined

module?.exports = Residual
