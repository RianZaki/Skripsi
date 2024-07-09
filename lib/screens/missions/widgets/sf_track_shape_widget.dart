import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SfTrackShapeWidget extends SfTrackShape {
  @override
  Rect getPreferredRect(
      RenderBox parentBox, SfSliderThemeData themeData, Offset offset,
      {bool? isActive}) {
    final trackHeight = themeData.activeTrackHeight;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
