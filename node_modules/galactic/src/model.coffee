#The model class is the base class for all galaxy models.
#It provides basic functions required for use with the modeler class
#to provide an enabled attribute and state tracking.
Image = require('./image')

class Model extends Image
  #Passes the width and height to the image constructor,
  #set the model to be enabled and stale by default, and
  #initilizes the params and paramArray for use by child classes.
  constructor: (@name,@width,@height) ->
    super(@width,@height)
    @enabled = true
    @stale = true
    @params = {}
    @paramArray = []


  #Enables the model.
  enable: ->
    @enabled = true
  #Disables the model.
  disable: ->
    @enabled = false
	
  #Update the entire params object at once,
  #and marks the model as stale.
  updateParams: (params) ->
    @params = params
    @stale = true

  #Provides a super call for child classes
  #that will automatically mark the stale attribute to
  #false.
  build: ->
    @stale = false

module?.exports = Model
