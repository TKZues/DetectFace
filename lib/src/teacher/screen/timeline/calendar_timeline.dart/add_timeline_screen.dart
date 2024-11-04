import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:findy/src/teacher/repositories/timeline_repositories.dart';
import 'package:findy/utils/provider/index.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:getwidget/getwidget.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import '../../../../../constant/color.dart';
import '../../../../../utils/config/size_config.dart';
import '../../../../../widget/text/textcustom.dart';

class ScheduleForm extends StatefulWidget {
  const ScheduleForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ScheduleFormState createState() => _ScheduleFormState();
}

class _ScheduleFormState extends State<ScheduleForm> {
  final TextEditingController _curriculumController = TextEditingController();
  final TextEditingController _beginTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final TextEditingController _locationController =
      TextEditingController(); // Controller for location input
  bool timestart = false;
  TextEditingController datestartcontroller = TextEditingController();
  TextEditingController datefinishcontroller = TextEditingController();
  TextEditingController ngay = TextEditingController();

  Future<void> _selectTime(
      BuildContext context, TextEditingController controller) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        controller.text = pickedTime.format(context); // Format as hh:mm AM/PM
      });
    }
  }

  @override
  void dispose() {
    _curriculumController.dispose();
    _beginTimeController.dispose();
    _endTimeController.dispose();
    _locationController.dispose(); // Dispose location controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String convertToIso8601( TextEditingController controller) {
      // Parse the date string to DateTime from the controller (in dd/MM/yyyy format)
      DateTime selectedDateTime =
          DateFormat('dd/MM/yyyy').parse(controller.text);

      // Get the current time (hours, minutes, seconds) to include in the ISO format
      DateTime fullDateTime = DateTime(
        selectedDateTime.year,
        selectedDateTime.month,
        selectedDateTime.day,
        DateTime.now().hour,
        DateTime.now().minute,
        DateTime.now().second,
      );

      String iso8601String = fullDateTime.toIso8601String();

      return iso8601String;
    }

    return ChangeNotifierProvider.value(
      value: context.read<TimelineRepositories1>(),
      child: Scaffold(
        appBar: GFAppBar(
          backgroundColor: AppColor.appbarColor,
          centerTitle: true,
          title: TextCustom(
            text: "Thêm sự kiện",
            color: AppColor.textDefault,
            fontSize: psHeight(16),
          ),
          actions: <Widget>[
            GFIconButton(
              icon: Icon(
                Icons.favorite,
                color: AppColor.textDefault,
                size: psHeight(16),
              ),
              onPressed: () {},
              type: GFButtonType.transparent,
            ),
          ],
        ),
        body: ProgressHUD(
          child: ConsumerBase<TimelineRepositories1>(
            onRepository: (repository) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: KeyboardDismisser(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _curriculumController,
                          decoration: InputDecoration(
                              labelText: 'Tựa đề',
                              border: InputBorder.none,
                              labelStyle: TextStyle(
                                  fontSize: psHeight(20),
                                  color:
                                      AppColor.textDefault.withOpacity(0.6))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập tên chương trình';
                            }
                            return null;
                          },
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Thời gian",
                              style: TextStyle(
                                  fontSize: psHeight(14),
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.topTitle),
                            ),
                            SizedBox(
                              height: psHeight(6),
                            ),
                            datetimePicker1(ngay, context),
                          ],
                        ),

                        // Begin Time
                        TextFormField(
                          controller: _beginTimeController,
                          decoration: InputDecoration(
                              labelText: 'Giờ bắt đầu',
                              border: InputBorder.none,
                              labelStyle: TextStyle(
                                  fontSize: psHeight(14),
                                  color: AppColor.textDefault.withOpacity(0.6)),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.access_time),
                                onPressed: () => _selectTime(
                                  context,
                                  _beginTimeController,
                                ),
                              )),
                          readOnly: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng chọn giờ bắt đầu';
                            }
                            return null;
                          },
                        ),
                        // End Time
                        TextFormField(
                          controller: _endTimeController,
                          decoration: InputDecoration(
                              labelText: 'Giờ kết thúc',
                              border: InputBorder.none,
                              labelStyle: TextStyle(
                                  fontSize: psHeight(14),
                                  color: AppColor.textDefault.withOpacity(0.6)),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.access_time),
                                onPressed: () => _selectTime(
                                  context,
                                  _endTimeController,
                                ),
                              )),
                          readOnly: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng chọn giờ kết thúc';
                            }
                            return null;
                          },
                        ),

                        // Location Input
                        TextFormField(
                          controller: _locationController,
                          decoration: InputDecoration(
                              labelText: 'Vị trí',
                              hintText: 'Nhập địa chỉ hoặc chọn từ bản đồ',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(psHeight(10)),
                                  borderSide: const BorderSide(
                                      color: AppColor.aicamLoginTitle,
                                      width: 1,
                                      strokeAlign: 2)),
                              hintStyle: TextStyle(
                                  fontSize: psHeight(14),
                                  color: AppColor.textDefault.withOpacity(0.6)),
                              prefixIcon: const Icon(Icons.location_on)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập vị trí';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Thời gian bắt đầu",
                              style: TextStyle(
                                  fontSize: psHeight(14),
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.topTitle),
                            ),
                            SizedBox(
                              height: psHeight(6),
                            ),
                            datetimePicker(datestartcontroller, context),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Thời gian kết thúc",
                              style: TextStyle(
                                  fontSize: psHeight(14),
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.topTitle),
                            ),
                            SizedBox(
                              height: psHeight(6),
                            ),
                            datetimePicker(datefinishcontroller, context),
                          ],
                        ),
                        // Submit button
                        ElevatedButton(
                          onPressed: () {
                            repository.createSchedule(
                              _curriculumController.text,
                              convertToIso8601(ngay),
                              _beginTimeController.text,
                              _endTimeController.text,
                              datestartcontroller.text,
                              datefinishcontroller.text,
                              _locationController.text,
                            );
                          },
                          child: const Text('Tạo Lịch'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget datetimePicker(
      TextEditingController dateController, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 2.2,
          child: GestureDetector(
            onTap: () {
              _showDateTimePicker(dateController);
            },
            child: AbsorbPointer(
              child: TextField(
                readOnly: true,
                controller: dateController,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  suffixIcon: Icon(
                    Icons.calendar_today_outlined,
                    size: 20,
                    color: Colors.grey.shade600,
                  ),
                  hintText: "Chọn ngày và giờ",
                  hintStyle: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showDateTimePicker(TextEditingController dateController) async {
    DateTime selectedDateTime = DateTime.now();
    if (dateController.text.isNotEmpty) {
      selectedDateTime =
          DateFormat('dd/MM/yyyy').parse('${dateController.text}');
    }

    await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builderContext) {
        return Container(
          height: 300,
          color: Colors.white,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.dateAndTime,
            initialDateTime: selectedDateTime,
            onDateTimeChanged: (DateTime newDateTime) {
              setState(() {
                dateController.text =
                    DateFormat('dd/MM/yyyy').format(newDateTime);
              });
            },
          ),
        );
      },
    );
  }

  Widget datetimePicker1(
      TextEditingController dateController, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 2.2,
          child: GestureDetector(
            onTap: () {
              _showDateTimePicker(dateController);
            },
            child: AbsorbPointer(
              child: TextField(
                readOnly: true,
                controller: dateController,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  suffixIcon: Icon(
                    Icons.calendar_today_outlined,
                    size: 20,
                    color: Colors.grey.shade600,
                  ),
                  hintText: "Chọn ngày và giờ",
                  hintStyle: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showDateTimePicker1(
      TextEditingController dateController) async {
    DateTime selectedDateTime = DateTime.now();
    if (dateController.text.isNotEmpty) {
      selectedDateTime =
          DateFormat('dd/MM/yyyy').parse('${dateController.text}');
    }

    await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builderContext) {
        return Container(
          height: 300,
          color: Colors.white,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.dateAndTime,
            initialDateTime: selectedDateTime,
            onDateTimeChanged: (DateTime newDateTime) {
              setState(() {
                dateController.text =
                    DateFormat('dd/MM/yyyy').format(newDateTime);
              });
            },
          ),
        );
      },
    );
  }
}
