models =
  sersic: (params,data,width,height) ->
    norm = params.n*Math.exp(0.6950-0.1789/params.n)
    sin = Math.sin(params.angle)
    cos = Math.cos(params.angle)
    for x in [0..(width-1)]
      for y in [(height-1)..0]
        r_x = (x-params.center.x)*cos+(y-params.center.y)*sin
        r_y = ((y-params.center.y)*cos-(x-params.center.x)*sin)/params.axisRatio
        r = Math.sqrt(r_x*r_x + r_y*r_y)
        exponent = norm*Math.pow(r/params.effRadius,1/params.n) - 1
        data[y*width+x] = params.intensity*Math.exp(-exponent)
    undefined

  basicSersic: (params,data,width,height) ->
    norm = params.n*Math.exp(0.6950-0.1789/params.n)
    for x in [0..(width-1)]
      x_cent = x - params.center.x
      x_sqr = x_cent*x_cent
      for y in [(height-1)..0]
        y_cent = y - params.center.y
        r = Math.sqrt(x_sqr + y_cent*y_cent)
        exponent = params.coeff*Math.pow(r/params.effRadius,1/params.n) - 1
        data[y*width+x] = params.intensity*Math.exp(-exponent)
    undefined

module?.exports = models
