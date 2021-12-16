import 'package:flutter/material.dart';

import 'resize_handle.dart';

class WindowHandles extends StatelessWidget {
  final Size size;
  final void Function(Offset offset) sizeUpdate;
  final void Function(Offset offset) positionUpdate;

  const WindowHandles(
      {Key? key,
      required this.size,
      required this.sizeUpdate,
      required this.positionUpdate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
        child: Stack(
      children: [
        ResizeHandle(
          alignment: Alignment.bottomRight,
          sizeUpdate: sizeUpdate,
          cursor: SystemMouseCursors.resizeUpLeftDownRight,
        ),
        ResizeHandle(
          alignment: Alignment.centerRight,
          isHorizontal: true,
          sizeUpdate: sizeUpdate,
          height: (size.height - 30).clamp(70, 3000),
          cursor: SystemMouseCursors.resizeLeftRight,
        ),
        ResizeHandle(
          alignment: Alignment.bottomCenter,
          isVertical: true,
          sizeUpdate: sizeUpdate,
          width: (size.width - 30).clamp(70, 3000),
          cursor: SystemMouseCursors.resizeUpDown,
        ),
        ResizeHandle(
          alignment: Alignment.topRight,
          sizeUpdate: (delta) {
            sizeUpdate(Offset(delta.dx, -delta.dy));
            if (size.height > 100) positionUpdate(Offset(0, delta.dy));
          },
          cursor: SystemMouseCursors.resizeUpRightDownLeft,
        ),
        ResizeHandle(
          alignment: Alignment.topLeft,
          sizeUpdate: (delta) {
            sizeUpdate(Offset(-delta.dx, -delta.dy));
            if (size.height > 100 && size.width > 150) {
              positionUpdate(Offset(delta.dx, delta.dy));
            }
            if (size.height > 100 && size.width <= 150) {
              positionUpdate(Offset(0, delta.dy));
            }
            if (size.height <= 100 && size.width > 150) {
              positionUpdate(Offset(delta.dx, 0));
            }
          },
          cursor: SystemMouseCursors.resizeUpLeftDownRight,
        ),
        ResizeHandle(
          alignment: Alignment.bottomLeft,
          sizeUpdate: (delta) {
            sizeUpdate(Offset(-delta.dx, delta.dy));
            if (size.width > 150) positionUpdate(Offset(delta.dx, 0));
          },
          cursor: SystemMouseCursors.resizeUpRightDownLeft,
        ),
        ResizeHandle(
          alignment: Alignment.centerLeft,
          height: (size.height - 30).clamp(70, 3000),
          isHorizontal: true,
          sizeUpdate: (delta) {
            sizeUpdate(Offset(-delta.dx, -delta.dy));
            if (size.width > 150) positionUpdate(delta);
          },
          cursor: SystemMouseCursors.resizeLeftRight,
        ),
        ResizeHandle(
          alignment: Alignment.topCenter,
          height: (size.height - 30).clamp(70, 3000),
          isVertical: true,
          sizeUpdate: (delta) {
            sizeUpdate(Offset(0, -delta.dy));
            if (size.height > 100) positionUpdate(Offset(0, delta.dy));
          },
          cursor: SystemMouseCursors.resizeUpDown,
        ),
      ],
    ));
  }
}
