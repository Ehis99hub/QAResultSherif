import 'package:flutter/material.dart' show BuildContext, Widget;

typedef OnPressed = void Function();
typedef OnChanged<T> = void Function(T value);
typedef OnValidate<T> = String Function(T value);
typedef ItemBuilder = Widget Function(BuildContext context, int index);