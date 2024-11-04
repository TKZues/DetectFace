class InforStudentModel {
  String? id;
  String? name;
  String? gender;
  String? classes;
  String? course;
  int? accumulatedCredits;
  int? remainingCredits;
  int? aPlus;
  int? a;
  int? bPlus;
  int? b;
  int? cPlus;
  int? c;
  int? ePlus;
  int? e;

  InforStudentModel(
      {this.id,
      this.name,
      this.gender,
      this.classes,
      this.course,
      this.accumulatedCredits,
      this.remainingCredits,
      this.aPlus,
      this.a,
      this.bPlus,
      this.b,
      this.cPlus,
      this.c,
      this.ePlus,
      this.e});

  factory InforStudentModel.fromJson(Map<String, dynamic> json) {
    return InforStudentModel(
      id: json['_id'],
      name: json['name'],
      gender: json['gender'],
      classes: json['classes'],
      course: json['course'],
      accumulatedCredits: json['accumulatedCredits'],
      remainingCredits: json['remainingCredits'],
      a: json['a'],
      aPlus: json['aPlus'],
      bPlus: json['bPlus'],
      b: json['b'],
      cPlus: json['cPlus'],
      c: json['c'],
      ePlus: json['ePlus'],
      e: json['e'],
    );
  }
}
