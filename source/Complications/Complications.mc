import Toybox.Lang;
import Toybox.Graphics;
import Toybox.Time;

module Complications {
  
  // [timeOfDayColor, hourColor, minuteColor, shadowColor]
  var THEME as Array<Array<Number>> = [
      [0x55aaff, 0x00ffaa, 0xffffff, 0x000000], // 0 waves
      [0x55aaff, 0xffff55, 0xffffff, 0x000000], // 1 sky
      [0xff55aa, 0xff00aa, 0xffffff, 0x000000], // 2 night
      [0x55aaff, 0x0055ff, 0x000000, 0xffffff], // 3 snow
      [0xffffaa, 0xff55aa, 0xffffff, 0x000000], // 4 lotus
      [0xffff55, 0xffff00, 0xffffff, 0x000000], // 5 chinese new year
      [0xaaffaa, 0xffaa00, 0xffffff, 0x000000], // 6 green tea
      [0xffffaa, 0xffffff, 0xffffff, 0x000000], // 7 boba
  ];

  function normalizeDegrees(degrees as Number) as Number {
    if (degrees < 0) {
      return degrees + 360;
    } else if (degrees >= 360) {
      return degrees - 360;
    }
    return degrees;
  }
}
