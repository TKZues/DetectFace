class DiemchuyencanModel {
  String? className;
  int? totalSubjects;
  int? totalCheckIns;
  int? totalAbsences;
  int? totalLate;
 

  DiemchuyencanModel({
    this.className,
    this.totalSubjects,
    this.totalCheckIns,
    this.totalAbsences,
    this.totalLate,

  });

  factory DiemchuyencanModel.fromJson(Map<String, dynamic> json) {
    return DiemchuyencanModel(
      className: json['className'],
      totalSubjects: json['totalSubjects'],
      totalCheckIns: json['totalCheckIns'],
      totalAbsences: json['totalAbsences'],
      totalLate: json['totalLate'],
  
    );
  }
}
