
class Gradient
  
  constructor: ->
    @buffer = new ArrayBuffer(256)
    @gradient = new Uint8ClampedArray(@buffer)
    @entries = []

  add: (level,intensity) ->
    entry = {
      level: ~~(255*level)
      intensity: ~~(255*intensity) }
    @entries.push(entry)

  build: ->
    gradient = @gradient
    entries = @entries

    i = entries.length-1
    while i--
      entry1 = entries[i]
      entry2 = entries[i+1]

      level1 = entry1.level
      level2 = entry2.level
      intensity1 = entry1.intensity
      intensity2 = entry2.intensity

      range = level2 - level1
      invRange = 1/range
      
      j = range + 1
      while j--
        value = (intensity2-intensity1)*j*invRange + intensity1
        gradient[level1 + j] = ~~value
        

module?.exports = Gradient
