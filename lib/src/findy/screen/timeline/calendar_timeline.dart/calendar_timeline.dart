import 'package:findy/constant/color.dart';
import 'package:findy/src/findy/repositories/timeline_repositories.dart';
import 'package:findy/src/findy/screen/timeline/calendar_timeline.dart/timeline_item.dart';
import 'package:findy/utils/config/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarTimeline extends StatefulWidget {
  const CalendarTimeline({super.key});

  @override
  State<CalendarTimeline> createState() => _CalendarTimelineState();
}

class _CalendarTimelineState extends State<CalendarTimeline> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final repo = context.read<TimelineRepositories>();
      await repo.getSchedule();
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Truy cập vào danh sách cuộc hẹn từ TimelineRepositories
    final repo = context.watch<TimelineRepositories>();
    final appointments = repo.appointmentData;

    return SfCalendar(
      view: CalendarView.month,
      // monthViewSettings: const MonthViewSettings(showAgenda: true),
      cellBorderColor: Colors.transparent,
      // Sử dụng dữ liệu từ TimelineRepositories cho dataSource
      dataSource: MeetingDataSource(appointments),
      onTap: (calendarTapDetails) =>
          showCustomDialog(context, appointments, calendarTapDetails),
    );
  }
}

// DataSource cho SfCalendar
class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}

String? _text = '';
void showCustomDialog(BuildContext context, List<Appointment> allAppointments,
    CalendarTapDetails details) {
  DateTime? tappedDate;
  if (details.date != null) {
    tappedDate = details.date;
  }

  if (tappedDate != null) {
    // Filter appointments for the tapped date
    final filteredAppointments = allAppointments.where((appointment) {
      return appointment.startTime.year == tappedDate!.year &&
          appointment.startTime.month == tappedDate.month &&
          appointment.startTime.day == tappedDate.day;
    }).toList();

    // Format the text based on the target element
    String text;
    if (details.targetElement == CalendarElement.header) {
      text = DateFormat('MMMM yyyy').format(tappedDate);
    } else if (details.targetElement == CalendarElement.viewHeader) {
      text = DateFormat('EEEE dd,\nMMMM yyyy').format(tappedDate);
    } else {
      text = DateFormat('EEEE dd,\nMMMM yyyy').format(tappedDate);
    }

    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.3),
      transitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
            width: MediaQuery.of(context).size.width - psWidth(100),
            height: MediaQuery.of(context).size.height - psHeight(300),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColor.greyBorder, width: 1),
              borderRadius: BorderRadius.circular(psHeight(15)),
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: psWidth(10),
                        vertical: psHeight(8),
                      ),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppColor.greyBorder,
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(text),
                          Row(
                            children: [
                              const Icon(Icons.sticky_note_2,
                                  color: Colors.grey),
                              SizedBox(width: psWidth(2)),
                              const Icon(Icons.more_time_rounded,
                                  color: Colors.grey),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: psHeight(20)),
                        child: GridView.builder(
                          itemCount: filteredAppointments.length,
                          physics: const ScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            crossAxisSpacing: psHeight(1),
                            mainAxisSpacing: psHeight(1),
                            mainAxisExtent: psHeight(80),
                          ),
                          itemBuilder: (context, index) {
                            final event = filteredAppointments[index];
                            return Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: psWidth(10)),
                              child: InkWell(
                                onTap: () {
                                  // Handle tap if needed
                                },
                                child: TimelineItem(
                                  monhoc: event.subject,
                                  starttime:
                                      "${event.startTime.hour}:${event.startTime.minute}",
                                  endtime:
                                      "${event.endTime.hour}:${event.endTime.minute}",
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: psHeight(
                      20), // Adjust the distance from the bottom as needed
                  right: psWidth(
                      20), // Adjust the distance from the right as needed
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      showAddEventDialog(context, tappedDate);
                    },
                    shape: CircleBorder(),
                    child: const Icon(Icons.add),
                    backgroundColor: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        final tween = Tween<Offset>(
          begin: anim.status == AnimationStatus.reverse
              ? const Offset(-1, 0)
              : const Offset(1, 0),
          end: Offset.zero,
        );
        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }
}

void showAddEventDialog(BuildContext context, DateTime? date) {
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return AlertDialog(
        title: const Text('Add New Event'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: subjectController,
                decoration: const InputDecoration(labelText: 'Subject'),
              ),
              TextField(
                controller: startTimeController,
                decoration: const InputDecoration(labelText: 'Start Time'),
                keyboardType: TextInputType.datetime,
              ),
              TextField(
                controller: endTimeController,
                decoration: const InputDecoration(labelText: 'End Time'),
                keyboardType: TextInputType.datetime,
              ),
              // Add more fields as needed
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Handle form submission here
              // For example, add the new event to the list and update the state
              Navigator.of(context).pop();
            },
            child: const Text('Add Event'),
          ),
        ],
      );
    },
  );
}
