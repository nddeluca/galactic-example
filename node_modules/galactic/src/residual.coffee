Image = require('./image')

class Residual extends Image
  constructor: (@width,@height) ->
    super(@width,@height)


  #Finds the difference between the
  #fits and model data and stores it
  build: (fitsData,modelData) ->
    for index in [0..(@width*@height)]
      @data[index] = fitsData[index] - modelData[index]
    undefined

module?.exports = Residual
