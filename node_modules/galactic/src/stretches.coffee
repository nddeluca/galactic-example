#Contains the different functions used to stretch the image on the display.
stretches =
  linear: (imageData,colorData,pixelMap,min,max) ->
    invRange = 1/(max-min)
    i = imageData.length
    while i--
      value = ~~(255*((imageData[i] - min)*invRange))
      level = Math.max(0,Math.min(value,255))
      colorData[i] = pixelMap[level]
    undefined

  log: (imageData,colorData,pixelMap,min,max) ->
    range = max - min
    invLN10 = 1/Math.LN10
    invMaxLog = 1/(Math.log(range)*invLN10)
    
    i = imageData.length
    while i--
      value = ~~(255*((Math.log(imageData[i] - min + 1)*invLN10)*invMaxLog))
      level = Math.max(0,Math.min(value,255))
      colorData[i] = pixelMap[level]
    undefined

  power: (imageData,colorData,pixelMap,min,max) ->
    range = max - min
    invMaxPow = 1/(range*range)
    i = imageData.length
    while i--
      tmp = imageData[i] - min
      value = ~~(255*((tmp*tmp)*invMaxPow))
      level = Math.max(0,Math.min(value,255))
      colorData[i] = pixelMap[level]
    undefined

  sqrt: (imageData,colorData,pixelMap,min,max) ->
    range = max - min
    invMaxSqrt = 1/Math.sqrt(range)

    i = imageData.length
    while i--
      value = ~~(255*((Math.sqrt(imageData[i] - min))*invMaxSqrt))
      level = Math.max(0,Math.min(value,255))
      colorData[i] = pixelMap[level]
    undefined

  arcsinh: (imageData,colorData,pixelMap,min,max) ->
    range = max - min
    max_asinh = Math.log(range + Math.sqrt(range*range + 1))
    invMaxAsinh = 1/max_asinh
    i = imageData.length
    while i--
      tmp = imageData[i] - min
      value = ~~(255*(Math.log(tmp + Math.sqrt(tmp*tmp + 1)))*invMaxAsinh)
      level = Math.max(0,Math.min(value,255))
      colorData[i] = pixelMap[level]
    undefined

module?.exports = stretches
