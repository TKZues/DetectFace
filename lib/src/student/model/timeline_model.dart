class TimelineModel {
  String? id;
  String? curriculumName;
  int? weekScheduleID;
  String? scheduleStudyUnitID;
  int? unit;
  int? periodID;
  int? numberOfPeriods;
  int? dayOfWeek;
  int? week;
  String? roomID;
  int? year;
  String? campusName;
  String? shiftName;
  String? thu;
  String? ngay;
  int? tuanHienTaiTrongNam;
  String? beginTime;
  String? endTime;
  String? startDate;
  String? endDate;
  String? address;
  String? buildingName;
  String? yearStudy;
  String? termID;
  String? curriculumID;
  String? listOfClassStudentID;
  String? tenCBGD;
  String? tkhhienThi;

  TimelineModel({
    this.id,
    this.curriculumName,
    this.weekScheduleID,
    this.scheduleStudyUnitID,
    this.unit,
    this.periodID,
    this.numberOfPeriods,
    this.dayOfWeek,
    this.week,
    this.roomID,
    this.year,
    this.campusName,
    this.shiftName,
    this.thu,
    this.ngay,
    this.tuanHienTaiTrongNam,
    this.beginTime,
    this.endTime,
    this.startDate,
    this.endDate,
    this.address,
    this.buildingName,
    this.yearStudy,
    this.termID,
    this.curriculumID,
    this.listOfClassStudentID,
    this.tenCBGD,
    this.tkhhienThi,
  });

  factory TimelineModel.fromJson(Map<String, dynamic> json) {
    return TimelineModel(
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
      startDate: json['startDate'],
      endDate: json['endDate'],
      address: json['address'],
      buildingName: json['buildingName'],
      yearStudy: json['yearStudy'],
      termID: json['termID'],
      curriculumID: json['curriculumID'],
      listOfClassStudentID: json['listOfClassStudentID'],
      tenCBGD: json['tenCBGD'],
      tkhhienThi: json['tkhhienThi'],
    );
  }
}
