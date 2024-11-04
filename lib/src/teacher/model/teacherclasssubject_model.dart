import 'package:flutter/foundation.dart';

class ClassModel {
  final String id;
  final String mainClassName;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final List<Subject> subjects;
  final List<Student> students;
  final String teacher;
  final int version;

  ClassModel({
    required this.id,
    required this.mainClassName,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.subjects,
    required this.students,
    required this.teacher,
    required this.version,
  });

  // Phương thức để parse JSON thành ClassModel
  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
      id: json['_id'],
      mainClassName: json['mainClassName'],
      description: json['description'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      subjects: (json['subjects'] as List<dynamic>)
          .map((subject) => Subject.fromJson(subject))
          .toList(),
      students: (json['students'] as List<dynamic>)
          .map((student) => Student.fromJson(student))
          .toList(),
      teacher: json['teacher'],
      version: json['__v'],
    );
  }

  // Phương thức để convert ClassModel thành JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'mainClassName': mainClassName,
      'description': description,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'subjects': subjects.map((subject) => subject.toJson()).toList(),
      'students': students.map((student) => student.toJson()).toList(),
      'teacher': teacher,
      '__v': version,
    };
  }
}

class Subject {
  final String id;
  final String curriculumName;
  final int weekScheduleID;
  final String scheduleStudyUnitID;
  final int unit;
  final int periodID;
  final int numberOfPeriods;
  final int dayOfWeek;
  final int week;
  final String roomID;
  final int year;
  final String campusName;
  final String shiftName;
  final String thu;
  final String ngay;
  final int tuanHienTaiTrongNam;
  final String beginTime;
  final String endTime;
  final DateTime startDate;
  final DateTime endDate;
  final String address;
  final String buildingName;
  final String yearStudy;
  final String termID;
  final String curriculumID;
  final String listOfClassStudentID;
  final String tenCBGD;
  final int version;

  Subject({
    required this.id,
    required this.curriculumName,
    required this.weekScheduleID,
    required this.scheduleStudyUnitID,
    required this.unit,
    required this.periodID,
    required this.numberOfPeriods,
    required this.dayOfWeek,
    required this.week,
    required this.roomID,
    required this.year,
    required this.campusName,
    required this.shiftName,
    required this.thu,
    required this.ngay,
    required this.tuanHienTaiTrongNam,
    required this.beginTime,
    required this.endTime,
    required this.startDate,
    required this.endDate,
    required this.address,
    required this.buildingName,
    required this.yearStudy,
    required this.termID,
    required this.curriculumID,
    required this.listOfClassStudentID,
    required this.tenCBGD,
    required this.version,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['_id'],
      curriculumName: json['curriculumName'],
      weekScheduleID: json['weekScheduleID'],
      scheduleStudyUnitID: json['scheduleStudyUnitID'],
      unit: json['unit'],
      periodID: json['periodID'],
      numberOfPeriods: json['numberOfPeriods'],
      dayOfWeek: json['dayOfWeek'],
      week: json['week'],
      roomID: json['roomID'],
      year: json['year'],
      campusName: json['campusName'],
      shiftName: json['shiftName'],
      thu: json['thu'],
      ngay: json['ngay'],
      tuanHienTaiTrongNam: json['tuanHienTaiTrongNam'],
      beginTime: json['beginTime'],
      endTime: json['endTime'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      address: json['address'],
      buildingName: json['buildingName'],
      yearStudy: json['yearStudy'],
      termID: json['termID'],
      curriculumID: json['curriculumID'],
      listOfClassStudentID: json['listOfClassStudentID'],
      tenCBGD: json['tenCBGD'],
      version: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'curriculumName': curriculumName,
      'weekScheduleID': weekScheduleID,
      'scheduleStudyUnitID': scheduleStudyUnitID,
      'unit': unit,
      'periodID': periodID,
      'numberOfPeriods': numberOfPeriods,
      'dayOfWeek': dayOfWeek,
      'week': week,
      'roomID': roomID,
      'year': year,
      'campusName': campusName,
      'shiftName': shiftName,
      'thu': thu,
      'ngay': ngay,
      'tuanHienTaiTrongNam': tuanHienTaiTrongNam,
      'beginTime': beginTime,
      'endTime': endTime,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'address': address,
      'buildingName': buildingName,
      'yearStudy': yearStudy,
      'termID': termID,
      'curriculumID': curriculumID,
      'listOfClassStudentID': listOfClassStudentID,
      'tenCBGD': tenCBGD,
      '__v': version,
    };
  }
}

class Student {
  final String id;
  final String username;
  final String email;

  Student({
    required this.id,
    required this.username,
    required this.email,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['_id'],
      username: json['username'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'username': username,
      'email': email,
    };
  }
}
