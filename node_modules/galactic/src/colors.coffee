colors =
  grayscale: (stretchData,colorData) ->
    for i in [0..(stretchData.length-1)]
      value = stretchData[i]
      colorData[i] = (255 << 24) | (value << 16) | (value << 8) | value
    undefined

module?.exports = colors
