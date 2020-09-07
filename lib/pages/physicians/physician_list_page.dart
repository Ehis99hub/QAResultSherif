import 'package:flutter/material.dart';
import 'package:roavapp/components/fragments/buttons/app_back_button.dart';
import 'package:roavapp/components/fragments/indicators/app_tab.dart';
import 'package:roavapp/components/fragments/spacers/app_sized_box.dart';
import 'package:roavapp/components/layouts/lists/physio_list.dart';
import 'package:roavapp/components/typography/app_text.dart';
import 'package:roavapp/styles/text_styles.dart';
import 'package:roavapp/utils/dimensions.dart';
import 'package:roavapp/values/json.dart';

class PhysicianListPage extends StatefulWidget {
  const PhysicianListPage();

  @override
  State<StatefulWidget> createState() {
    return _PhysicianListPageState();
  }
}

class _PhysicianListPageState extends State<PhysicianListPage> {
  ValueNotifier<int> _tabIndex;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _tabIndex = ValueNotifier(0);
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    final scaler = AppScaleUtil(context);
    return Scaffold(
      body: Builder(
        builder: (context) {
          return SafeArea(
            child: Container(
              constraints: BoxConstraints.tightFor(
                height: scaler.sizer.height,
                width: scaler.sizer.width,
              ),
              padding: scaler.insets.symmetric(
                horizontal: 7,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const AppSizedBox(height: 1),
                  AppBackButton.plain(),
                  const AppSizedBox(height: 2.5),
                  AppText(
                    "Choose\na doctor",
                    style: boldText.copyWith(
                      fontSize: 45,
                    ),
                  ),
                  const AppSizedBox(height: 3),
                  ValueListenableBuilder(
                    valueListenable: _tabIndex,
                    builder: (context, int index, _) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            for (final tab in tabItems)
                              AppTab(
                                isActive: tabItems.indexOf(tab) == index,
                                text: tab,
                                onTap: () {
                                  final idx = tabItems.indexOf(tab);
                                  _tabIndex.value = idx;
                                  _pageController.jumpToPage(idx);
                                },
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                  const AppSizedBox(height: 1),
                  Expanded(
                    child: PageView.builder(
                      itemBuilder: (context, idx) {
                        return PhysioList(
                          physicians: physicians.where(
                            (it) => it.qalifications.contains(
                              tabItems[idx],
                            ),
                          ).toList(),
                        );
                      },
                      controller: _pageController,
                      itemCount: tabItems.length,
                      onPageChanged: (page) {
                        _tabIndex.value = page;
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
