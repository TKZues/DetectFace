class AttendanceModel {
  // String? id;
  String? checkInTime;
  String? status;
  String? label;
  String? checkOutTime;
  AttendanceModel({
    // this.id,
    this.checkInTime,
    this.status,
    this.label,
   this.checkOutTime,
  });

  factory AttendanceModel.fromJson(Map<dynamic, dynamic> json) {
    return AttendanceModel(
      // id: json['_id'],
      checkInTime: json['checkInTime'],
      status: json['status'],
      label: json['label'],
      checkOutTime: json['checkOutTime'],
    );
  }
}
