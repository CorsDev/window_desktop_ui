import 'package:flutter/material.dart';
import 'package:window_desktop_ui/src/widgets/resize_handle.dart';
import 'package:window_desktop_ui/src/widgets/window_handles.dart';

class WindowContainer extends StatelessWidget {
  final bool isActive;
  final String title;
  final VoidCallback onDragStarted;
  final void Function(Offset offset) sizeUpdate;
  final void Function(Offset offset) positionUpdate;
  final void Function(DraggableDetails details) onDragEnd;
  final Size size;
  final Widget headerContent;
  final Widget child;

  const WindowContainer(
      {Key? key,
        required this.title,
      required this.isActive,
      required this.child,
      required this.size,
      required this.headerContent,
      required this.onDragEnd,
      required this.onDragStarted,
      required this.sizeUpdate,
      required this.positionUpdate})
      : super(key: key);

  Widget get header => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Container(
          width: double.infinity,
          color: Colors.transparent,
          child: Row(
            children: [
              Text(title),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: headerContent,
              ),
            ],
          ),
        ),
      );

  Widget get feedback => Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.40),
                  offset: const Offset(0, 25),
                  blurRadius: 45)
            ]),
      );

  Widget get draggableHeader => Draggable(
      feedback: feedback,
      child: header,
      childWhenDragging: header,
      onDragStarted: onDragStarted,
      onDragEnd: onDragEnd);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 150, minHeight: 100),
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            if (isActive)
              BoxShadow(
                  color: Colors.black.withOpacity(0.40),
                  offset: const Offset(0, 25),
                  blurRadius: 45)
          ]),
      child: Stack(
        children: [
          WindowHandles(
              size: size,
              sizeUpdate: sizeUpdate,
              positionUpdate: positionUpdate),
          Positioned.fill(
              child: Column(
            children: [
              draggableHeader,
              const Divider(
                height: 1,
                thickness: 2,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: child,
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}
