import 'package:flutter/material.dart';

class WindowAreaInfo extends InheritedWidget {
  final Size areaSize;
  final Offset globalOffset;

  const WindowAreaInfo(
      {Key? key,
      required this.areaSize,
      required this.globalOffset,
      required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant WindowAreaInfo oldWidget) => false;

  static WindowAreaInfo? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<WindowAreaInfo>();
}
