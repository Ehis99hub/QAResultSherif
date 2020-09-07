import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:roavapp/components/fragments/buttons/app_back_button.dart';
import 'package:roavapp/components/fragments/buttons/app_button.dart';
import 'package:roavapp/components/fragments/spacers/app_sized_box.dart';
import 'package:roavapp/components/typography/app_text.dart';
import 'package:roavapp/models/podos/appointment.dart';
import 'package:roavapp/models/podos/physician.dart';
import 'package:roavapp/services/appointment_service.dart';
import 'package:roavapp/styles/colors.dart';
import 'package:roavapp/styles/text_styles.dart';
import 'package:roavapp/utils/dimensions.dart';
import 'package:roavapp/utils/helpers.dart';
import 'package:roavapp/utils/snacks.dart';
import 'package:table_calendar/table_calendar.dart';

class PhysioSchedulePage extends StatefulWidget {
  final Physician physio;

  const PhysioSchedulePage({
    this.physio,
  });

  @override
  State<StatefulWidget> createState() {
    return _PhysioSchedulePageState();
  }
}

class _PhysioSchedulePageState extends State<PhysioSchedulePage> {
  CalendarController _ctrl;
  ValueNotifier<DateTime> _selectedDay;
  ValueNotifier<num> _selectedHour;
  final DateTime today = DateTime.now();
  final AppointmentService service = AppointmentService();

  @override
  void initState() {
    super.initState();
    _ctrl = CalendarController();
    _selectedDay = ValueNotifier(DateTime.now());
    _selectedHour = ValueNotifier(null);
  }

  @override
  Widget build(BuildContext context) {
    final scaler = AppScaleUtil(context);
    return Scaffold(
      body: Builder(
        builder: (context) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverPadding(
                padding: scaler.insets.only(
                  top: 3,
                  left: 5,
                  right: 5,
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      SafeArea(
                        child: AppBackButton.plain(
                          bgColor: appTransparent,
                        ),
                      ),
                      const AppSizedBox(height: 5),
                      AppText(
                        "Choose a date\n& time period",
                        style: boldText.copyWith(fontSize: 50),
                      )
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: scaler.insets.symmetric(
                  vertical: 2,
                  horizontal: 5,
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      TableCalendar(
                        availableCalendarFormats: const {
                          CalendarFormat.month: "Month"
                        },
                        startDay: today,
                        calendarController: _ctrl,
                        daysOfWeekStyle: DaysOfWeekStyle(
                          dowTextBuilder: (date, _) {
                            return DateFormat("E").format(date)[0];
                          },
                          weekdayStyle: normalText.copyWith(
                              color: appBlack.withOpacity(.5),
                              fontSize: scaler.fontSizer.sp(32)),
                          weekendStyle: normalText.copyWith(
                              color: appBlack.withOpacity(.5),
                              fontSize: scaler.fontSizer.sp(32)),
                        ),
                        calendarStyle: CalendarStyle(
                          highlightToday: false,
                          weekdayStyle: boldText.copyWith(
                            fontSize: scaler.fontSizer.sp(35),
                          ),
                          weekendStyle: boldText.copyWith(
                              fontSize: scaler.fontSizer.sp(35),
                              color: appBlack.withOpacity(.4)),
                          outsideStyle: boldText.copyWith(
                              fontSize: scaler.fontSizer.sp(35),
                              color: appBlack.withOpacity(.1)),
                          outsideWeekendStyle: boldText.copyWith(
                              fontSize: scaler.fontSizer.sp(35),
                              color: appBlack.withOpacity(.1)),
                          todayColor: appOrange,
                          selectedColor: appTeal,
                        ),
                        onDaySelected: (day, _) {
                          if (day.weekday >= widget.physio.schedule.weekStart &&
                              day.weekday <= widget.physio.schedule.weekEnd) {
                            _selectedDay.value = day;
                            _selectedHour.value = null;
                          } else {
                            final weekDay = dayFromNum(day.weekday, true);
                            _selectedDay.value = null;
                            _selectedHour.value = null;
                            showSnack(
                              context: context,
                              message:
                                  "😔 Sorry I am not available on $weekDay",
                            );
                          }
                        },
                        headerStyle: HeaderStyle(
                          centerHeaderTitle: true,
                          titleTextStyle: boldText.copyWith(
                            fontSize: scaler.fontSizer.sp(35),
                          ),
                          leftChevronIcon: Icon(
                            Icons.arrow_back,
                            size: scaler.fontSizer.sp(50),
                          ),
                          rightChevronIcon: Icon(
                            Icons.arrow_forward,
                            size: scaler.fontSizer.sp(50),
                          ),
                          leftChevronPadding:
                              scaler.insets.symmetric(vertical: 1),
                          rightChevronPadding:
                              scaler.insets.symmetric(vertical: 1),
                        ),
                      ),
                      const AppSizedBox(height: 2),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: scaler.insets.symmetric(
                  vertical: 2,
                  horizontal: 5,
                ),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, idx) {
                      final hour = widget.physio.schedule.dayStart + idx;
                      return ValueListenableBuilder(
                        valueListenable: _selectedHour,
                        builder: (context, num val, _) {
                          return InkWell(
                            child: AnimatedContainer(
                              padding: scaler.insets.symmetric(
                                vertical: 1,
                                horizontal: 2,
                              ),
                              duration: Duration(milliseconds: 500),
                              decoration: BoxDecoration(
                                color: val == hour ? appTeal : appGrey,
                                borderRadius: BorderRadius.circular(
                                  scaler.fontSizer.sp(15),
                                ),
                              ),
                              child: Center(
                                child: AppText(
                                  "$hour - ${hour + 1}",
                                  style: mediumText.copyWith(
                                    color: val == hour ? appWhite : appBlack,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            onTap: () {
                              _selectedHour.value = hour;
                            },
                          );
                        },
                      );
                    },
                    childCount: (widget.physio.schedule.dayEnd -
                        widget.physio.schedule.dayStart),
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: scaler.sizer.setWidth(2),
                    mainAxisSpacing: scaler.sizer.setWidth(3),
                    crossAxisCount: 4,
                    childAspectRatio: 10 / 5,
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Builder(
        builder: (context) {
          return Container(
            constraints: BoxConstraints.tightFor(
              width: scaler.sizer.width,
              height: scaler.sizer.setHeight(11.8),
            ),
            padding: scaler.insets.fromLTRB(5, 1.5, 5, 4),
            child: AppButton(
              text: "Book",
              onPressed: () {
                if (_selectedDay.value != null && _selectedHour.value != null) {
                  final response = service.createAppointment(
                    Appointment(
                      id: "${widget.physio.picture}<>${_selectedHour.value}<>${_selectedDay.value.day}<>${_selectedDay.value.month}<>${_selectedDay.value.year}",
                      date: _selectedDay.value.toIso8601String(),
                      from: _selectedHour.value,
                      to: _selectedHour.value + 1,
                      physician: widget.physio.picture,
                    ),
                  );
                  if (!response.isSuccessful) {
                    return showSnack(
                        context: context, message: response.message);
                  }
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    "/success",
                    (route) => false,
                  );
                } else {
                  showSnack(
                    context: context,
                    message: "Please choose a date and time",
                  );
                }
              },
              isBold: true,
            ),
            decoration: BoxDecoration(
              color: appWhite,
            ),
          );
        },
      ),
    );
  }
}
