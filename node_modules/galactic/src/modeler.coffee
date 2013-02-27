Residual = require('./residual')
Model = require('./model')
Sersic = require('./sersic')
Image = require('./image')
utils = require('./utils')

class Modeler
  constructor: (@fitsImage) ->

    #Get fits data for residual calculation
    @fitsData = @fitsImage.data

    #Get fits width and height so we
    #can make a model of the same size
    @width = @fitsImage.width
    @height = @fitsImage.height

    #Image that will store the model data
    #and be passed to a display
    @image = new Image(@width,@height)

    #Used to calculate and hold residual
    @residual = new Residual(@width,@height)

    #initialize array of models that will be used
    #to create the model image
    @models = []
    @undo = []


  #Create a new model and add it to the model array.
  #The name attribute should be unique
  addModel: (name,type) ->
    switch type
      when 'sersic'
        model = new Sersic(name,@width,@height)
      else
        return false

    @models.push(model)
    #return the newly created model
    model

  #Remove a model from the array
  removeModel: (name) ->
    model = @findModel(name)
    index = @models.indexOf(model)
    @models.splice(index,1)

  #Find a model by name
  findModel: (name) ->
    for model in @models
      if model.name == name
        return model
    false

  #Pass a model name along with updated params
  updateParams: (name,params) ->
    model = @findModel(name)
    model.updateParams(params)
    undefined

  updateParam: (name,param,value) ->
    model = @findModel(name)
    model.params[param] = value
    model.stale = true

  rebuildModel: (name) ->
    model = @findModel
    model.build()
    undefined
  
  disableModel: (name) ->
    model = @findModel(name)
    model.disable()
    undefined

  enableModel: (name) ->
    model = @findModel(name)
    model.enable()
    undefined

  #Creates an array of all enabled models
  getEnabledModels: ->
    models = []
    for model in @models
      if model.enabled
        models.push(model)
    models
  
  @saveUndo: ->
    @undo.push(@models)
    if @undo.length > 10
      @undo.pop

  @reloadUndo: ->
    if @undo.length > 0
      @models = @undo[0]
      @undo.splice(0,1)
    
  build: ->
    length = @width*@height
    models = @getEnabledModels()
    imageData = @image.data

    if models.length == 0
      i = length
      while i--
        imageData[i] = 0
    else
      model = models.shift()
      model.build() if model.stale
      modelData = model.data
      i = length
      while i--
        imageData[i] = modelData[i]

      if models.length > 0
        for model in models
          model.build() if model.stale
          modelData = model.data
          i = length
          while i--
            imageData[i] += modelData[i]

    @residual.build(@fitsData,imageData)

    undefined

module?.exports = Modeler
