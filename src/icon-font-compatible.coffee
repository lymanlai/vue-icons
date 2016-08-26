# out: ../icon-font-compatible.js
i = require "./icon"
ifc =
  template: i.template
  mixins: i.mixins
  compiled: i.compiled
  data: ->
    elstyle: null
  ready: ->
    @elstyle = window.getComputedStyle(@$el)
    @onWindowResize =>
      @elstyle = window.getComputedStyle(@$el)
  props: {}
  computed:
    outerWidth: i.computed.innerWidth
    innerHeight: ->
      if @elstyle
        return parseFloat @elstyle.getPropertyValue("font-size").replace("px","")
      return null
    outerHeight: ->
      if @elstyle
        lh = @elstyle.getPropertyValue("line-height")
        if lh != "normal"
          return parseFloat lh.replace("px","")
        else
          return @innerHeight
      return null
    widthRatio: -> 1

for prop in ["name","offsetX","offsetY","flipH","flipV","label","style"]
  ifc.props[prop] = i.props[prop]
for c in ["processedName","icon","box","aspect","flipped","mergeStyle","heightRatio"]
  ifc.computed[c] = i.computed[c]

module.exports = ifc
