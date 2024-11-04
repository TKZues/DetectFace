class AttendanceModel {
  // String? id;
  String? checkInTime;
  String? status;
  String? label;
  String? checkOutTime;
   String? subjectName;
  int? checkInLateMinutes;
  int? checkOutLateMinutes;
  AttendanceModel({
    // this.id,
    this.checkInTime,
    this.status,
    this.label,
   this.checkOutTime,
   this.subjectName,
    this.checkInLateMinutes,
   this.checkOutLateMinutes,
  });

  factory AttendanceModel.fromJson(Map<dynamic, dynamic> json) {
    return AttendanceModel(
      // id: json['_id'],
      checkInTime: json['checkInTime'],
      status: json['status'],
      label: json['label'],
      checkOutTime: json['checkOutTime'],
      subjectName: json['subjectName'],
      checkInLateMinutes: json['checkInLateMinutes'],
      checkOutLateMinutes: json['checkOutLateMinutes'],
    );
  }
}


class NotAttendanceModel {
  // String? id;
  String? checkInTime;
  String? status;
  String? label;
  String? checkOutTime;
   String? subjectName;
  int? checkInLateMinutes;
  int? checkOutLateMinutes;
  NotAttendanceModel({
    // this.id,
    this.checkInTime,
    this.status,
    this.label,
   this.checkOutTime,
   this.subjectName,
    this.checkInLateMinutes,
   this.checkOutLateMinutes,
  });

  factory NotAttendanceModel.fromJson(Map<dynamic, dynamic> json) {
    return NotAttendanceModel(
      // id: json['_id'],
      checkInTime: json['checkInTime'],
      status: json['status'],
      label: json['label'],
      checkOutTime: json['checkOutTime'],
      subjectName: json['subjectName'],
      checkInLateMinutes: json['checkInLateMinutes'],
      checkOutLateMinutes: json['checkOutLateMinutes'],
    );
  }
}
