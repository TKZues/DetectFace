class AttendanceHistoryModel {
  // String? id;
  String? checkInTime;
  String? status;
  String? checkInDate;
  String? checkOutTime;
   String? subjectName;
  int? checkInLateMinutes;
  int? checkOutLateMinutes;
  AttendanceHistoryModel({
    // this.id,
    this.checkInTime,
    this.status,
    this.checkInDate,
   this.checkOutTime,
   this.subjectName,
    this.checkInLateMinutes,
   this.checkOutLateMinutes,
  });

  factory AttendanceHistoryModel.fromJson(Map<dynamic, dynamic> json) {
    return AttendanceHistoryModel(
      // id: json['_id'],
      checkInTime: json['checkInTime'],
      status: json['status'],
      checkInDate: json['checkInDate'],
      checkOutTime: json['checkOutTime'],
      subjectName: json['subjectName'],
      checkInLateMinutes: json['checkInLateMinutes'],
      checkOutLateMinutes: json['checkOutLateMinutes'],
    );
  }
}


// class NotAttendanceHistoryModel {
//   // String? id;
//   String? checkInTime;
//   String? status;
//   String? label;
//   String? checkOutTime;
//    String? subjectName;
//   int? checkInLateMinutes;
//   int? checkOutLateMinutes;
//   NotAttendanceHistoryModel({
//     // this.id,
//     this.checkInTime,
//     this.status,
//     this.label,
//    this.checkOutTime,
//    this.subjectName,
//     this.checkInLateMinutes,
//    this.checkOutLateMinutes,
//   });

//   factory NotAttendanceHistoryModel.fromJson(Map<dynamic, dynamic> json) {
//     return NotAttendanceHistoryModel(
//       // id: json['_id'],
//       checkInTime: json['checkInTime'],
//       status: json['status'],
//       label: json['label'],
//       checkOutTime: json['checkOutTime'],
//       subjectName: json['subjectName'],
//       checkInLateMinutes: json['checkInLateMinutes'],
//       checkOutLateMinutes: json['checkOutLateMinutes'],
//     );
//   }
// }
