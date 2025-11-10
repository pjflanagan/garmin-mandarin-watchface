import Toybox.Application;
import Toybox.SensorHistory;
import Toybox.Lang;
import Toybox.Graphics;
import Toybox.System;
import Toybox.Time;
import Toybox.Complications;

module Complications {
  class HourRingModel {
    public var _hourOfDay as Number; //[0, 23]
    public var _minuteOfHour as Number; //[0, 59]
    public var _secondOfMinute as Number; //[0, 59]

    private var _sunriseComplicationId as Complications.Id;
    public var _sunriseSeconds as Number?;

    private var _sunsetComplicationId as Complications.Id;
    public var _sunsetSeconds as Number?;

    public function initialize() {
      var clockTime = System.getClockTime();
      _hourOfDay = clockTime.hour;
      _minuteOfHour = clockTime.min;
      _secondOfMinute = clockTime.sec;

      // init complications
      _sunriseComplicationId = new Complications.Id(
        Complications.COMPLICATION_TYPE_SUNRISE
      );
      _sunsetComplicationId = new Complications.Id(
        Complications.COMPLICATION_TYPE_SUNSET
      );
      Complications.registerComplicationChangeCallback(
        self.method(:onComplicationChanged)
      );
      Complications.subscribeToUpdates(_sunriseComplicationId);
      Complications.subscribeToUpdates(_sunsetComplicationId);
    }

    public function onComplicationChanged(id as Complications.Id) as Void {
      if (id.equals(_sunriseComplicationId)) {
        _sunriseSeconds = Complications.getComplication(id).value;
      } else if (id.equals(_sunsetComplicationId)) {
        _sunsetSeconds = Complications.getComplication(id).value;
      }
    }

    public function updateModel() as Void {
      var clockTime = System.getClockTime();
      _hourOfDay = clockTime.hour;
      _minuteOfHour = clockTime.min;
      _secondOfMinute = clockTime.sec;
    }
  }
}
