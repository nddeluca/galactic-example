colors =

  gray: {
    type: "SAO"
    red:
      level: [0,1]
      intensity: [0,1]
    green:
      level: [0,1]
      intensity: [0,1]
    blue:
      level: [0,1]
      intensity: [0,1] }

  red: {
    type: "SAO"
    red:
      level: [0,1]
      intensity: [0,1]
    green:
      level: [0,0]
      intensity: [0,0]
    blue:
      level: [0,0]
      intensity: [0,0] }

  green: {
    type: "SAO"
    red:
      level: [0,0]
      intensity: [0,0]
    green:
      level: [0,1]
      intensity: [0,1]
    blue:
      level: [0,0]
      intensity: [0,0] }

  blue: {
    type: "SAO"
    red:
      level: [0,0]
      intensity: [0,0]
    green:
      level: [0,0]
      intensity: [0,0]
    blue:
      level: [0,1]
      intensity: [0,1] }

  heat: {
    type: "SAO"
    red:
      level: [0,0.34,1]
      intensity: [0,1,1]
    green:
      level: [0,1]
      intensity: [0,1]
    blue:
      level: [0,0.65,0.98,1]
      intensity: [0,0,1,1] }

  a: {
    type: "SAO"
    red:
      level: [0,0.25,0.5,1]
      intensity: [0,0,1,1]
    green:
      level: [0,0.25,0.5,0.77,1]
      intensity: [0,1,0,0,1]
    blue:
      level: [0,0.125,0.5,0.64,0.77,1]
      intensity: [0,0,1,0.5,0,0] }

  b: {
    type: "SAO"
    red:
      level: [0,0.25,0.5,1]
      intensity: [0,0,1,1]
    green:
      level: [0,0.5,0.75,1]
      intensity: [0,0,1,1]
    blue:
      level: [0,0.25,0.5,0.75,1]
      intensity: [0,1,0,0,1] }

  bb: {
    type: "SAO"
    red:
      level: [0,0.5,1]
      intensity: [0,1,1]
    green:
      level: [0,0.25,0.75,1]
      intensity: [0,0,1,1]
    blue:
      level: [0,0.5,1]
      intensity: [0,0,1] }

  cool: {
    type: "SAO"
    red:
      level: [0,0.29,0.76,1]
      intensity: [0,0,0.1,1]
    green:
      level: [0,0.22,0.96,1]
      intensity: [0,0,1,1]
    blue:
      level: [0,0.53,1]
      intensity: [0,1,1] }

  he: {
    type: "SAO"
    red:
      level: [0,0.015,0.25,0.5,1]
      intensity: [0,0.5,0.5,0.75,1]
    green:
      level: [0,0.065,0.125,0.25,0.5,1]
      intensity: [0,0,0.5,0.75,0.810,1]
    blue:
      level: [0,0.015,0.03,0.065,0.25,1]
      intensity: [0,0.125,0.375,0.625,0.25,1] }

  rainbow: {
    type: "SAO"
    red:
      level: [0,0.2,0.6,0.8,1]
      intensity: [1,0,0,1,1]
    green:
      level: [0,0.2,0.4,0.8,1]
      intensity: [0,0,1,1,0]
    blue:
      level: [0,0.4,0.6,1]
      intensity: [1,1,0,0] }

  standard: {
    type: "SAO"
    red:
      level: [0,0.333,0.333,0.666,0.666,1]
      intensity: [0,0.3,0,0.3,0.3,1]
    green:
      level: [0,0.333,0.333,0.666,0.666,1]
      intensity: [0,0.3,0.3,1,0,0.3]
    blue:
      level: [0,0.333,0.333,0.666,0.666,1]
      intensity: [0,1,0,0.3,0,0.3] }

  alps0: {
    type: "LUT"
    red: [0.196,0.475,0,0.373,0,0,1,1,1]
    green: [0.196,0,0,0.655,0.596,0.965,1,0.694,0]
    blue: [0.196,0.608,0.785,0.925,0,0,0,0,0] }

  color: {
    type: "LUT"
    red: [0,0.18431,0.37255,0.56078,0.74902,0.93725,0,0,0,0,0,0.3098,0.49804,0.62353,0.93725,0.74902]
    green: [0,0.18431,0.37255,0.56078,0.74902,0.93725,0.18431,0.37255,0.49804,0.74902,0.93725,0.62353,0.49804,0.3098,0,0]
    blue: [0,0.18431,0.37255,0.56078,0.74902,0.93725,0.93725,0.74902,0.49804,0.3098,0,0,0,0,0,0.3098] }

  i8: {
    type: "LUT"
    red: [0,0,0,0,1,1,1,1]
    green: [0,1,0,1,0,1,0,1]
    blue: [0,0,1,1,0,0,1,1] }

 staircase: {
   type: "LUT"
   red: [0.06,0.12,0.18,0.24,0.3,0.06,0.12,0.18,0.24,0.3,0.2,0.4,0.6,0.8,1]
   green: [0.06,0.12,0.18,0.24,0.3,0.2,0.4,0.6,0.8,1,0.06,0.12,0.18,0.24,0.3]
   blue: [0.2,0.4,0.6,0.8,1,0.06,0.12,0.18,0.24,0.3,0.06,0.12,0.18,0.24,0.3] }

module?.exports = colors
