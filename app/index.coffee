require('lib/setup')
Galactic = require('galactic')
Spine = require('spine')
$ = jQuery

class App extends Spine.Controller

  events:
    "change #stretch": "stretch"
    "slide #range-slider": "range"
    "click .model-controls button": "buttonControl"
    "slide .model-controls .slider": "control"
    "change #colormap": "colormap"
    "keyup #colormap": "colormap"
    "keyup #stretch": "stretch"

  constructor: ->
    super

    @fits_loaded = false
    @psf_loaded = false

    fits_xhr = new XMLHttpRequest()
    fits_xhr.open('GET', 'images/test_cutout.fits')
    fits_xhr.responseType = 'arraybuffer'

    psf_xhr = new XMLHttpRequest()
    psf_xhr.open('GET', 'images/test_psf.fits')
    psf_xhr.responseType = 'arraybuffer'


    fits_xhr.onload = $.proxy(@set_up_fits, this, fits_xhr)
    fits_xhr.send()

    psf_xhr.onload = $.proxy(@set_up_psf, this, psf_xhr)
    psf_xhr.send()

    @render()

  set_up_fits: (fits_xhr) ->
    fitsFile = new FITS.File(fits_xhr.response)
    image = fitsFile.getDataUnit()
    data = image.getFrame()

    @fits_image = new Galactic.Image(width: image.width, height: image.height)

    l = image.width*image.height
    while l--
      @fits_image.data[l] = data[l]

    Galactic.utils.arrayutils.shift_to_zero(@fits_image.data)

    @fits_loaded = true

    if @psf_loaded
      @set_up_app()

  set_up_psf: (psf_xhr) ->
    psfFile = new FITS.File(psf_xhr.response)
    image = psfFile.getDataUnit()
    data = image.getFrame()

    @psf_image = new Galactic.Image(width: image.width, height: image.height)

    l = image.width*image.height
    while l--
      @psf_image.data[l] = data[l]

    Galactic.utils.arrayutils.normalize_to_one(@psf_image.data)

    if @fits_loaded
      @set_up_app()

  set_up_app: ->

    width = 300
    height = Math.round((@fits_image.height/@fits_image.width)*width)

    @fits_display = new Galactic.Display(container: 'fits-container', width: width, height: height)
    @model_display = new Galactic.Display(container: 'model-container', width: width, height: height)
    @residual_display = new Galactic.Display(container: 'residual-container', width: width, height: height)


    @modeler = new Galactic.Modeler(@fits_image)
    @residual = new Galactic.Residual(fitsData: @fits_image.data, modelData: @modeler.image.data, width: @fits_image.width, height: @fits_image.height)
    modeler = @modeler

    modeler.add("sersic1","sersic")
    modeler.add("sersic2","sersic")
    modeler.enable("sersic1")
    modeler.disable("sersic2")

    @convolutor = new Galactic.PSFConvolutor(model: modeler.image, psf: @psf_image)

    modeler.build()
    @convolutor.convolute()
    @residual.build()


    @fits_formatter = new Galactic.ImageFormatter(input: @fits_image)
    @model_formatter = new Galactic.ImageFormatter(input: @modeler.image)
    @residual_formatter = new Galactic.ImageFormatter(input: @residual)

    min = @fits_formatter.min
    max = @fits_formatter.max

    @model_formatter.min = min
    @model_formatter.max = max
    @residual_formatter.min = min
    @residual_formatter.max = max

    #Set up the range slider for adjusting stretch
    $("#range-slider").slider(
      range: true
      values: [min, max]
      min: min
      max: max
      step: (max - min)/100)

    #Show first tab
    $("#model-tabs a:first").tab('show')

    @initSliders()

    fits_image = @fits_formatter.convert()
    model_image = @model_formatter.convert()
    residual_image = @residual_formatter.convert()

    @fits_display.draw(fits_image)
    @model_display.draw(model_image)
    @residual_display.draw(residual_image)


  update_modeling: ->
    @model_display.draw(@model_formatter.convert())
    @residual_display.draw(@residual_formatter.convert())

  update_all: ->
    @fits_display.draw(@fits_formatter.convert())
    @update_modeling()

  render: =>
    @html require('views/index')

  stretch: (event) =>
    stretch = $(event.target).val()

    @fits_formatter.setStretch(stretch)
    @model_formatter.setStretch(stretch)
    @residual_formatter.setStretch(stretch)

    @update_all()


  colormap: (event) =>
    map = $(event.target).val()

    @fits_formatter.setColormap(map)
    @model_formatter.setColormap(map)
    @residual_formatter.setColormap(map)

    @update_all()


  range: (event, ui) =>
    min = ui.values[0]
    max = ui.values[1]

    @fits_formatter.min = min
    @fits_formatter.max = max

    @model_formatter.min = min
    @model_formatter.max = max

    @residual_formatter.min = min
    @residual_formatter.max = max

    @update_all()

  control: (event) =>
    control = $(event.target)
    model = control.data('model')

    modeler = @modeler

    param = control.data('param')
    value = control.slider('value')
    modeler.updateParam(model,param,value)

    modeler.build()
    @convolutor.convolute()
    @residual.build()
    @update_modeling()

  buttonControl: (event) =>
    control = $(event.target)
    type = control.data('control')
    model = control.data('model')
    modeler = @modeler

    if type == "enable"
      modeler.enable(model)
    if type == "disable"
      modeler.disable(model)

    modeler.build()
    @convolutor.convolute()
    @residual.build()
    @update_modeling()

  initSliders: ->
    $('.slider').each (i,obj) =>
      model = @modeler.find($(obj).data('model'))
      param = $(obj).data('param')
      switch param
        when "intensity"
          $(obj).slider(
            min: 0
            max: 10000000
            step: 100
            value: model.intensity)
        when "centerX"
          $(obj).slider(
            min: 0
            max: model.width
            step: 0.5
            value: model.centerX)
        when "centerY"
          $(obj).slider(
            min: 0
            max: model.width
            step: 0.5
            value: model.centerY)
        when "n"
          $(obj).slider(
            min: 0
            max: 10
            step: .01
            value: model.n)
        when "angle"
          $(obj).slider(
            min: 0
            max: 2*Math.PI
            step: 0.1
            value: model.angle)
        when "axisRatio"
          $(obj).slider(
            min: 1
            max: 3
            step: 0.01
            value: model.axisRatio)
        when "effRadius"
          $(obj).slider(
            min: 0
            max: 100
            step: 0.01
            value: model.effRadius)
        else
          $(obj).slider()

module.exports = App
