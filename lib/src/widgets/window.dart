import 'package:flutter/material.dart';
import 'package:window_desktop_ui/src/widgets/window_area_info.dart';
import 'package:window_desktop_ui/src/widgets/window_container.dart';

class Window extends StatefulWidget {
  final bool isActive;
  final String title;
  final VoidCallback onTap;
  final Offset? defaultPosition;
  final Widget? header;
  final Widget content;

  const Window(
      {Key? key,
      required this.title,
      this.header,
      this.isActive = false,
      required this.onTap,
      required this.content,
      this.defaultPosition})
      : super(key: key);

  @override
  _WindowState createState() => _WindowState();
}

class _WindowState extends State<Window> {
  Offset currentPosition = const Offset(10, 10);
  Size currentSize = const Size(400, 300);
  bool isDragging = false;

  @override
  void initState() {
    super.initState();

    if (widget.defaultPosition != null) {
      currentPosition = widget.defaultPosition!;
    }
  }

  void onDragStarted() => setState(() {
        isDragging = true;
      });

  double limitDelta(double delta, double constraint) {
    if (delta < 0) return 0;
    if (delta > constraint) return constraint;
    return delta;
  }

  void onDragEnd(Size size, DraggableDetails details, Offset offset) =>
      setState(() {
        isDragging = false;
        currentPosition = Offset(
            limitDelta(details.offset.dx - offset.dx, size.width - 20),
            limitDelta(details.offset.dy - offset.dy, size.height - 20));
      });

  void sizeUpdate(Offset delta) => setState(() => currentSize =
      Size(currentSize.width + delta.dx, currentSize.height + delta.dy));

  void positionUpdate(Offset delta) => setState(() => currentPosition =
      Offset(currentPosition.dx + delta.dx, currentPosition.dy + delta.dy));

  Widget get window => Builder(builder: (context) {
        Widget content = widget.content;

        WindowAreaInfo areaInfo = WindowAreaInfo.of(context)!;

        Size windowAreaSize = areaInfo.areaSize;

        Offset windowAreaGlobalOffset = areaInfo.globalOffset;

        return Opacity(
            opacity: isDragging ? 0 : 1,
            child: WindowContainer(
              title: widget.title,
              isActive: widget.isActive,
              size: currentSize,
              headerContent: widget.header ?? Container(),
              child: content,
              onDragStarted: onDragStarted,
              onDragEnd: (details) =>
                  onDragEnd(windowAreaSize, details, windowAreaGlobalOffset),
              sizeUpdate: sizeUpdate,
              positionUpdate: positionUpdate,
            ));
      });

  @override
  Widget build(BuildContext context) => Positioned(
        top: currentPosition.dy,
        left: currentPosition.dx,
        child: GestureDetector(
          onPanStart: (details) => widget.onTap(),
          onTapDown: (details) => widget.onTap(),
          child: window,
        ),
      );
}
