# -------------------------------------------------------------------------------------------------
# MODIFIABLE PARAMETERS
# -------------------------------------------------------------------------------------------------
positionOptions =
  vertical: 'bottom'        # Vertical position [bottom, center, top]
  horizontal: 'left'        # Horizontal position [left, center, right]
  paddingEnabled: true      # Enable secure margin, avoiding touching edges [true or false]
  paddingPercentageX: '3%'  # Padding percentage applied to the X axis [value + '%']
  paddingPercentageY: '3%'  # Padding percentage applied to the Y axis [value + '%']

backgroundOptions =
  color: 'black'            # Background color [HEX code or css predefined color (i.e red, white, black, blue)]
  opacity: 0.5              # Background opacity [between 0 and 1]
  rounded: true             # Background rounded or squared [true or false]

textOptions =
  color: 'white'            # Text color [HEX code or css predefined color (i.e red, white, black, blue)]
  opacity: 1                # Text opacity [between 0 and 1]

borderOptions =
  enable: true            # Show/hide background border [true, false]
  color: 'white'          # Border color [HEX code or css predefined color (i.e red, white, black, blue)]
  width: 4                # Border width [number in pixels]
# -------------------------------------------------------------------------------------------------

# shell date command to get time and date
command: "date +\"%H.%M.%d.%a\""

# the refresh frequency in milliseconds
refreshFrequency: 30000

render: (output) -> """
  <div id="rounded-clock">
      <h1 id="timeleft"></h1>
      <h1 id="timeright"></h1>
      <h3 id="date"></h3>
      <h3 id="day"></h3>
      <div id="vl"></div>
  </div>
"""

update: (output) ->
  data = output.split('.')
  $(timeleft).html(data[0])
  $(timeright).html(data[1])
  $(date).html(data[2])
  $(day).html(data[3].toUpperCase())

style: (->

  borderWidth = if borderOptions.enable then borderOptions.width else 0

  borderRadius = if backgroundOptions.rounded then '50%' else '0%'

  bottom = '0%'
  top = '0%'
  if positionOptions.vertical is 'bottom'
    bottom = if positionOptions.paddingEnabled then positionOptions.paddingPercentageY else'0%'
    top = 'unset'
  else if positionOptions.vertical is 'center'
    bottom = '43.4895%'
    top = 'unset'
  else
    bottom = 'unset'
    top = if positionOptions.paddingEnabled then positionOptions.paddingPercentageY else'0%'

  left = '0%'
  right = '0%'
  if positionOptions.horizontal is 'left'
    left = if positionOptions.paddingEnabled then positionOptions.paddingPercentageX else'0%'
    right = 'unset'
  else if positionOptions.horizontal is 'center'
    left = '43.4895%'
    right = 'unset'
  else
    left = 'unset'
    right = if positionOptions.paddingEnabled then positionOptions.paddingPercentageX else'0%'

  return """
    @font-face {
      font-family: 'Anonymous Pro';
      src: url('/fonts/Anonymous_Pro.ttf');
    }
    h1,h3{
      color: rgba(#{textOptions.color},#{textOptions.opacity});
      margin: 0px; padding: 0px;
      font-family: 'Anonymous Pro', monospace;
    }
    #rounded-clock{
      position:fixed;
      bottom: #{bottom};
      top: #{top};
      left: #{left};
      right: #{right};
      background-color: rgba(#{backgroundOptions.color},#{backgroundOptions.opacity});
      height: 250px;
      width: 250px;
      border-radius: #{borderRadius};
      display: inline-block;
      border: #{borderWidth}px solid #{borderOptions.color};
    }
    #timeleft{
      left: 30px;
    }
    #timeright{
      right: 25px;
    }
    #timeright,#timeleft{
      position: absolute;
      float: left;
      top: 80px;
      font-size: 5em;
    }
    #date{
      left: 80px;
    }
    #day{
      right: 60px;
    }
    #date,#day{
      position: absolute;
      font-size: 2em;
      bottom: 55px;
      opacity: 0.5;
    }
    #vl {
      position: absolute;
      top: 96px;
      left: 124px;
      border-left: 2px solid #{textOptions.color};
      height: 95px;
      opacity: 0.5;
    }
  """
)()
