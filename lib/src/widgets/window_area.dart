import 'package:flutter/material.dart';
import 'package:window_desktop_ui/src/classes/active_window.dart';
import 'package:window_desktop_ui/src/widgets/window.dart';
import 'package:window_desktop_ui/src/widgets/window_area_info.dart';

class WindowArea extends StatefulWidget {
  final List<ActiveWindow> windows;

  const WindowArea({Key? key, required this.windows}) : super(key: key);

  @override
  State<WindowArea> createState() => _WindowAreaState();
}

class _WindowAreaState extends State<WindowArea> {
  final GlobalKey stackKey = GlobalKey();
  late List<String> windowStack;
  Offset globalOffset = Offset.zero;

  @override
  void initState() {
    super.initState();

    windowStack = widget.windows.map((e) => e.id).toList();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getWindowAreaGlobalPosition();
    });
  }

  void onWindowTap(int stackIndex) {
    if (stackIndex == windowStack.length - 1) return;
    setState(() {
      String currentWindow = windowStack.removeAt(stackIndex);
      windowStack.add(currentWindow);
    });
  }

  void getWindowAreaGlobalPosition() {
    RenderBox renderBox =
        stackKey.currentContext!.findRenderObject()! as RenderBox;
    setState(() => globalOffset = renderBox.localToGlobal(Offset.zero));
  }

  Window mapIdToWindow(int stackIndex) {
    String id = windowStack[stackIndex];
    int windowIndex = widget.windows.indexWhere((element) => id == element.id);

    ActiveWindow window = widget.windows[windowIndex];

    return Window(
        key: ValueKey(window.id),
        title: window.title,
        isActive: stackIndex == windowStack.length - 1,
        onTap: () => onWindowTap(stackIndex),
        header: window.header,
        content: window.content);
  }

  void updateWindowStackDuringBuild() {
    List<String> widgetWindowStack = widget.windows.map((e) => e.id).toList();
    List<String> cleanedWindowStack = windowStack
        .where((element) => widgetWindowStack.contains(element))
        .toList();

    List<String> windowsToAdd = widgetWindowStack
        .where((element) => !cleanedWindowStack.contains(element))
        .toList();
    cleanedWindowStack.insertAll(0, windowsToAdd);

    windowStack = cleanedWindowStack;
  }

  @override
  Widget build(BuildContext context) {
    updateWindowStackDuringBuild();

    return LayoutBuilder(
        builder: (context, constraints) => WindowAreaInfo(
            globalOffset: globalOffset,
            areaSize: Size(constraints.maxWidth, constraints.maxHeight),
            child: Stack(
              key: stackKey,
              alignment: Alignment.topLeft,
              fit: StackFit.expand,
              children: windowStack.asMap().keys.map(mapIdToWindow).toList(),
            )));
  }
}
