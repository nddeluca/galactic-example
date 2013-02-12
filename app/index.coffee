require('lib/setup')
Galactic = require('galactic')
Spine = require('spine')
$ = jQuery

class App extends Spine.Controller
  
  events:
    "change #stretch": "stretch"
    "slide #range-slider": "range"
    "click .model-controls button": "control"
    "slide .model-controls .slider": "control"
  
  
  constructor: ->
    super
    xhr = new XMLHttpRequest()
    xhr.open('GET', 'images/cutout.fits')
    xhr.responseType = 'arraybuffer'
    xhr.send()
    @render()
    
    $(window).resize(@resize)

    xhr.onload = (e) =>
      #Set up fits file
      fitsFile = new FITS.File(xhr.response)
      image = fitsFile.getDataUnit()
      image.getFrame()

      #Find min and max for stretches
      min = Galactic.utils.min(image.data)
      max = Galactic.utils.max(image.data)

      #Set up main display for fits file
      @fitsDisplay = new Galactic.Display('fits-container',300,image)
      @fitsDisplay.min = min
      @fitsDisplay.max = max

      #Set up the range slider for adjusting stretch
      $("#range-slider").slider(
        range: true
        values: [min, max]
        min: min
        max: max
        step: (max - min)/100)

      #Show first tab
      $("#model-tabs a:first").tab('show')
      

      @modeler = new Galactic.Modeler(image)

      @modeler.addModel("sersic1","sersic")
      @modeler.addModel("sersic2","sersic")

      @modeler.enableModel("sersic1")
      @modeler.disableModel("sersic2")

      @modeler.build()

      @modelDisplay = new Galactic.Display('model-container',300,@modeler.image)
      @resDisplay = new Galactic.Display('residual-container',300,@modeler.residual)

      @initSliders()
      
      @modelDisplay.processImage()
      @modelDisplay.draw()
      @fitsDisplay.processImage()
      @fitsDisplay.draw()
      @resDisplay.processImage()
      @resDisplay.draw()

  render: =>
    @html require('views/index')


  stretch: (event) =>
    stretch = $(event.target).val()
    @fitsDisplay.setStretch(stretch)
    @modelDisplay.setStretch(stretch)
    @updateDisplays()

  range: (event, ui) =>
    min = ui.values[0]
    max = ui.values[1]
    @fitsDisplay.min = min
    @fitsDisplay.max = max
    @modelDisplay.min = min
    @modelDisplay.max = max
    @updateDisplays()

  updateDisplays: ->
    @fitsDisplay.processImage()
    @fitsDisplay.draw()
    @modelDisplay.processImage()
    @modelDisplay.draw()


  control: (event) =>
    control = $(event.target)
    type = control.data('control')
    model = control.data('model')
    
    console.log model
    console.log type
 
    if type == "enable"
      @modeler.enableModel(model)
    if type == "disable"
      @modeler.disableModel(model)

    if type == "param"
      param = control.data('param')
      value = control.slider('value')
      console.log value
      @modeler.updateParam(model,param,value)

    @modeler.build()
    @modelDisplay.processImage()
    @modelDisplay.draw()
    @resDisplay.min = Galactic.utils.min(@modeler.residual.data)
    @resDisplay.max = Galactic.utils.max(@modeler.residual.data)
    @resDisplay.processImage()
    @resDisplay.draw()

  initSliders: ->
    $('.slider').each (i,obj) =>
      model = @modeler.findModel($(obj).data('model'))
      param = $(obj).data('param')
      switch param
        when "intensity"
          $(obj).slider(
            min: 0
            max: 10
            step: 0.01
            value: model.params.intensity)
        when "centerX"
          $(obj).slider(
            min: 0
            max: model.width
            step: 0.5
            value: model.params.centerX)
        when "centerY"
          $(obj).slider(
            min: 0
            max: model.width
            step: 0.5
            value: model.params.centerY)
        when "n"
          $(obj).slider(
            min: 0
            max: 10
            step: .01
            value: model.params.n)
        when "angle"
          $(obj).slider(
            min: 0
            max: 2*Math.PI
            step: 0.1
            value: model.params.angle)
        when "axisRatio"
          $(obj).slider(
            min: 1
            max: 3
            step: 0.01
            value: model.params.axisRatio)
        when "effRadius"
          $(obj).slider(
            min: 0
            max: 15
            step: 0.01
            value: model.params.axisRatio)
        else
          $(obj).slider()



module.exports = App
    
