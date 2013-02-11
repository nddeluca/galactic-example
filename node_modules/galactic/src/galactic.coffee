Galactic = {}

Galactic.VERSION = '0.0.1'


#Base classes
Galactic.Image = require('./image')
Galactic.Canvas = require('./canvas')


#display related classes
Galactic.Display = require('./display')
Galactic.StretchProcessor = require('./stretch_processor')
Galactic.ColorProcessor = require('./color_processor')

#display related functions
Galactic.stretches = require('./stretches')
Galactic.colors = require('./colors')


#model related classes
Galactic.Model = require('./model')
Galactic.Modeler = require('./modeler')

Galactic.Sersic = require('./sersic')

#Residual related classes
Galactic.Residual = require('./residual')

#dipslay related functions and utilities
Galactic.utils = require ('./utils')

#model related functions and utilites
Galactic.models = require('./models')


module?.exports = Galactic
