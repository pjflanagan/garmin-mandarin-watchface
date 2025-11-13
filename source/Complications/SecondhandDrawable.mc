import Toybox.Lang;
import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Application.Properties;

module Complications {
  class SecondHandDrawable extends WatchUi.Drawable {
    private var _model as Complications.SecondHandModel;

    // _x and _y should be set to the center of the watch
    private var _x as Number;
    private var _y as Number;
    private var _radius as Number;

    // NOTE: half of this goes off screen, do double the visible width
    private const _segmentWidthSecond = 6;

    public function initialize(
      params as
        {
          :identifier as Object,
          :x as Numeric,
          :y as Numeric,
          :radius as Numeric,
        }
    ) {
      _model = new Complications.SecondHandModel();
      _y = params[:y];
      _x = params[:x];
      _radius = params[:radius];

      var options = {
        :x => params[:x],
        :y => params[:y],
        :identifier => params[:identifier],
      };

      Drawable.initialize(options);
    }

    private function getSecondOfMinuteAngle(seconds as Number) as Number {
      var degrees = (seconds * -90) / 15 + 90;
      return normalizeDegrees(degrees);
    }

    public function draw(dc as Dc) as Void {
      _model.updateModel();

      // second hand ring
      var theme = Properties.getValue("Theme");
      var color = Complications.THEME[theme][1]; // hourColor

      dc.setColor(color, Graphics.COLOR_TRANSPARENT);
      dc.setPenWidth(_segmentWidthSecond);

      var secondAngle = getSecondOfMinuteAngle(_model._secondOfMinute);
      dc.drawArc(_x, _y, _radius, Graphics.ARC_CLOCKWISE, 90, secondAngle);
    }
  }
}
