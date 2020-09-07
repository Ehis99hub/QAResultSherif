import 'package:flutter/material.dart';
import 'package:roavapp/components/fragments/list_items/physio_list_item.dart';
import 'package:roavapp/components/typography/app_text.dart';
import 'package:roavapp/models/podos/physician.dart';

class PhysioList extends StatelessWidget {
  final List<Physician> physicians;

  PhysioList({
    @required this.physicians,
  });

  @override
  Widget build(BuildContext context) {
    if (physicians.isEmpty) {
      return Center(
        child: AppText(
          "Oops, no physicians here...",
          textAlign: TextAlign.center,
        ),
      );
    }
    return ListView.builder(
      itemBuilder: (context, idx) {
        return PhysioListItem(
          physician: physicians[idx],
          onTap: () {
            Navigator.of(context).pushNamed(
              "/doctors/detail",
              arguments: physicians[idx],
            );
          },
        );
      },
      itemCount: physicians.length,
    );
  }
}
