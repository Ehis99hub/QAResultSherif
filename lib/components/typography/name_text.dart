import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:roavapp/components/typography/app_text.dart';
import 'package:roavapp/styles/text_styles.dart';

class NameText extends StatelessWidget {
  final _db = Hive.box("user_data");

  NameText();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _db.listenable(keys: ["currentUser"]),
      builder: (context, Box db, _) {
        final user = db.get("currentUser", defaultValue: {"name": "User"});
        final name = user["name"] ?? "User";
        return AppText(
          "Welcome, ${name.split(" ")[0]}",
          style: boldText.copyWith(
            fontSize: 50,
          ),
        );
      },
    );
  }
}
