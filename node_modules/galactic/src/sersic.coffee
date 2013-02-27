Model = require('./model')

class Sersic extends Model
  constructor: (@name,@width,@height) ->
    super(@name,@width,@height)
    @initDefaultParams()
    @initParamArray()

  initParamArray: ->
    @paramArray = ['centerX',
     'centerY',
     'angle',
     'axisRatio',
     'effRadius',
     'intensity',
     'n']

  initDefaultParams: ->
    @params =
      centerX: 31.5
      centerY: 42
      angle: 0
      axisRatio: 1
      effRadius: 6
      intensity: 2.3
      n: 1
    
  build: ->
    super

    data = @data
    n = @params.n
    invN = 1/n
    cx = @params.centerX
    cy = @params.centerY
    angle = @params.angle
    invAxisRatio = 1/@params.axisRatio
    invEffRadius = 1/@params.effRadius
    intensity = @params.intensity

    norm = n*Math.exp(0.6950-0.1789*invN)
    sin = Math.sin(angle)
    cos = Math.cos(angle)

    width = @width
    height = @height
    x = width
    while x--
      y = height
      while y--
        r_x = (x-cx)*cos+(y-cy)*sin
        r_y = ((y-cy)*cos-(x-cx)*sin)*invAxisRatio
        r = Math.sqrt(r_x*r_x + r_y*r_y)
        exponent = norm*Math.pow(r*invEffRadius,invN) - 1
        data[y*width+x] = intensity*Math.exp(-exponent)
    undefined

module?.exports = Sersic
