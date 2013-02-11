Image = require('./image')



class Model extends Image
  constructor: (@name,@width,@height) ->
    super(@width,@height)

    #Set the model active and stale by default
    @enabled = true
    @stale = true
    @params = {}
    @paramArray = []


#Methods for controlling state
  enable: ->
    @enabled = true
  disable: ->
    @enabled = false
	
#Methods for updating model
  updateParams: (params) ->
    @params = params
    @stale = true

  build: ->
    @stale = false

#Methods for building inputs
  buildInputHtml: (param) ->
    '<input data-param="#{param}"></input>'

  buildControlHtml: (name) ->
    begin_div = '<div data-name="#{name}">'
    end_div = '</div>'

    inputs = ""
    for param in @paramArray
      inputs += @buildInputHtml(param)

    begin_div + inputs + end_div


module?.exports = Model
