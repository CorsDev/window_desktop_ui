import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ResizeHandle extends StatelessWidget {
  final SystemMouseCursor cursor;
  final void Function(Offset offset) sizeUpdate;
  final Alignment alignment;
  final bool isHorizontal;
  final bool isVertical;
  final double width;
  final double height;

  const ResizeHandle(
      {Key? key,
      required this.cursor,
      required this.sizeUpdate,
      required this.alignment,
      this.width = 8,
      this.height = 8,
      this.isHorizontal = false,
      this.isVertical = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var onHorizontalDragUpdate =
        isHorizontal ? (details) => sizeUpdate(details.delta) : null;
    var onVerticalDragUpdate =
        isVertical ? (details) => sizeUpdate(details.delta) : null;
    var onPanUpdate = !isHorizontal && !isVertical
        ? (details) => sizeUpdate(details.delta)
        : null;

    return Align(
      alignment: alignment,
      child: MouseRegion(
        cursor: cursor,
        child: GestureDetector(
          onHorizontalDragUpdate: onHorizontalDragUpdate,
          onVerticalDragUpdate: onVerticalDragUpdate,
          onPanUpdate: onPanUpdate,
          child: Container(
            height: height,
            width: width,
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
