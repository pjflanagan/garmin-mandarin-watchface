import Toybox.Lang;
import Toybox.Graphics;
import Toybox.Time;

module Complications {

  function min(a as Number, b as Number) as Number {
    if (a < b) {
      return a;
    } else {
      return b;
    }
  }

  function abs(a as Number or Float) as Number or Float {
    if (a < 0) {
      return -a;
    } else {
      return a;
    }
  }

  function convertSecondsToTimeString(seconds as Number) as String {
    var hours = seconds / 3600;
    var minutes = (seconds % 3600) / 60;
    var secs = seconds % 60;

    var time = minutes.format("00") + ":" + secs.format("00");
    if (hours > 0) {
      time = hours + ":" + time;
    }
    return time;
  }

  function normalizeDegrees(degrees as Number) as Number {
    if (degrees < 0) {
      return degrees + 360;
    } else if (degrees >= 360) {
      return degrees - 360;
    }
    return degrees;
  }

  function convertMetersPerSecondToMilesPerHour(
    metersPerSecond as Float
  ) as Float {
    return metersPerSecond * 2.23694; // 1 m/s = 2.23694 mph
  }
}
