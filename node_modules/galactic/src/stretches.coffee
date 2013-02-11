stretches =
  linear: (imageData,stretchData,min,max) ->
    range = max - min
    index = 0
    for i in [0..(stretchData.length - 1)]
      stretchData[i] = ~~(255*((imageData[i] - min)/range))
    undefined

  log: (imageData,stretchData,min,max) ->
    range = max - min
    max_log = Math.log(range)/Math.LN10

    for i in [0..(stretchData.length - 1)]
      stretchData[i] = ~~(255*((Math.log(imageData[i] - min + 1)/Math.LN10)/max_log))
    undefined

  power: (imageData,stretchData,min,max) ->
    range = max - min
    max_power = range*range

    for i in [0..(stretchData.length - 1)]
      value = imageData[i] - min
      stretchData[i] = ~~(255*((value*value)/max_power))
    undefined

  sqrt: (imageData,stretchData,min,max) ->
    range = max - min
    max_sqrt = Math.sqrt(range)

    for i in [0..(stretchData.length - 1)]
      stretchData[i] = ~~(255*((Math.sqrt(imageData[i] - min))/max_sqrt))
    undefined

  arcsinh: (imageData,stretchData,min,max) ->
    range = max - min
    max_asinh = Math.log(range + Math.sqrt(range*range + 1))

    for i in [0..(stretchData.length - 1)]
      point = imageData[i] - min
      value = Math.log(point + Math.sqrt(point*point + 1))
      stretchData[i] = ~~(255*(value/max_asinh))
    undefined

module?.exports = stretches
