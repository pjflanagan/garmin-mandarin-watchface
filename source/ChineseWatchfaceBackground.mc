using Toybox.WatchUi;
using Toybox.Application;
using Toybox.Graphics;

class Background extends WatchUi.Drawable {
  private var _yGap = 8;
  private var _yHalfGap = _yGap / 2;
  private var _xGap = 104;

  private var _nightTheme = [0x000000, 0x000055];
  private var _timeTheme = [
    _nightTheme, // night
    [0x000055, 0x550055], // sunrise
    [0x000055, 0x0000aa], // morning
    [0x000055, 0x0000aa], // daytime
    [0x000055, 0x5500aa], // sunset
    [0x000055, 0x000000], // evening
    _nightTheme, // night
  ];

  private var _timeThemeBreakpoints = [
    6 * 60 + 30, // sunrise
    8 * 60 + 30, // morning
    10 * 60 + 30, // daytime
    18 * 60 + 30, // sunset
    20 * 60 + 30, // evening
    22 * 60 + 30, // night
  ];

  function initialize() {
    var dictionary = {
      :identifier => "Background",
    };

    Drawable.initialize(dictionary);
  }

  function draw(dc) {
    var clockTime = System.getClockTime();
    var hour = clockTime.hour;
    var minutes = clockTime.min;
    var minuteOfDay = hour * 60 + minutes + 1;

    var backgroundColor = _nightTheme[0];
    var designColor = _nightTheme[1];
    for (var i = 0; i < _timeThemeBreakpoints.size(); i++) {
      if (minuteOfDay < _timeThemeBreakpoints[i]) {
        backgroundColor = _timeTheme[i][0];
        designColor = _timeTheme[i][1];
        break;
      }
    }

    dc.setColor(Graphics.COLOR_TRANSPARENT, backgroundColor);
    dc.clear();

    // draw all the lines across
    dc.setColor(designColor, Graphics.COLOR_TRANSPARENT);
    dc.setPenWidth(1);
    for (var lineY = 0; lineY < dc.getHeight(); lineY += _yGap) {
      dc.drawLine(0, lineY, dc.getWidth(), lineY);
    }

    // draw blockers over segments of the lines and draw circles on those blockers
    var patternOffset = 4; // starting at 4, 0 is too symmetrical
    for (var y = 0; y < dc.getHeight(); y += _yGap) {
      patternOffset++;
      var drawType = patternOffset % 8;
      var xStart = 0;
      if (drawType == 1) {
        xStart = (3 * _xGap) / 5;
      } else if (drawType == 2) {
        continue;
      } else if (drawType == 3) {
        xStart = _xGap / 5;
      } else if (drawType == 4) {
        xStart = (4 * _xGap) / 5;
      } else if (drawType == 5) {
        continue;
      } else if (drawType == 6) {
        xStart = (3 * _xGap) / 5;
      } else if (drawType == 7) {
        xStart = (2 * _xGap) / 5;
      }
      for (var x = xStart; x < dc.getWidth(); x += _xGap) {
        // draw the background blocker first
        dc.setColor(backgroundColor, Graphics.COLOR_TRANSPARENT);
        // dc.setColor(0xff0000, Graphics.COLOR_TRANSPARENT);
        dc.fillRectangle(x - _yGap, y, 2 * _yGap, _yGap + 1);

        // then draw two half circles
        dc.setColor(designColor, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(1);
        dc.drawArc(
          x - _yGap,
          y + _yHalfGap,
          _yHalfGap,
          Graphics.ARC_CLOCKWISE,
          90,
          270
        );
        dc.drawArc(
          x + _yGap,
          y + _yHalfGap,
          _yHalfGap,
          Graphics.ARC_COUNTER_CLOCKWISE,
          90,
          270
        );
      }
    }
  }
}
