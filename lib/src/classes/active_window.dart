import 'package:flutter/cupertino.dart';
import 'package:window_desktop_ui/src/helpers/get_random_string.dart';

class ActiveWindow {
  final String id;
  final String title;
  final Widget? header;
  final Widget content;

  ActiveWindow({required this.title, this.header, required this.content})
      : id = getRandomString(35);
}
