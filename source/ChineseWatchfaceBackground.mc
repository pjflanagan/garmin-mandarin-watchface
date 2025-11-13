using Toybox.WatchUi;
using Toybox.Application;
using Toybox.Graphics;
using Toybox.Application.Properties;

class ChineseWatchFaceBackground extends WatchUi.Drawable {
  private var _yGap = 8;
  private var _yHalfGap = _yGap / 2;
  private var _xGap = 104;

  // [backgroundColor, waveColor]
  private const _themes = [
    [0x000055, 0x0000aa], // 0 waves
    [0x0000aa, 0x0055aa], // 1 sky
    [0x000000, 0x550055], // 2 night
    [0xffffff, 0xaaffff], // 3 snow
    [0x005500, 0x00aa55], // 4 lotus
    [0x550000, 0xaa0000], // 5 chinese new year
    [0x005500, 0x55aa55], // 6 green tea
    [0x555500, 0x000000], // 7 boba
  ];

  function initialize() {
    var dictionary = {
      :identifier => "ChineseWatchFaceBackground",
    };

    Drawable.initialize(dictionary);
  }

  function draw(dc) {
    var theme = Properties.getValue("Theme");
    var backgroundColor = _themes[theme][0];
    var waveColor = _themes[theme][1];

    dc.setColor(Graphics.COLOR_TRANSPARENT, backgroundColor);
    dc.clear();

    // draw all the lines across
    dc.setColor(waveColor, Graphics.COLOR_TRANSPARENT);
    dc.setPenWidth(1);
    for (var lineY = 0; lineY < dc.getHeight(); lineY += _yGap) {
      dc.drawLine(0, lineY, dc.getWidth(), lineY);
    }

    // draw blockers over segments of the lines and draw circles on those blockers
    var patternOffset = 4; // starting at 4, 0 is too symmetrical
    for (var y = 0; y < dc.getHeight(); y += _yGap) {
      patternOffset++;
      var drawType = patternOffset % 8;

      // set where the circles will be drawn
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
        dc.fillRectangle(x - _yGap, y, 2 * _yGap, _yGap + 1);

        // then draw two half circles
        dc.setColor(waveColor, Graphics.COLOR_TRANSPARENT);
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
