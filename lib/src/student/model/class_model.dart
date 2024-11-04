class ClassModel {
  String? id;
  String? mainClassName;
  String? description;
  String? startDate;
  String? endDate;
 

  ClassModel({
    this.id,
    this.mainClassName,
    this.description,
    this.startDate,
    this.endDate,

  });

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
      id: json['_id'],
      mainClassName: json['mainClassName'],
      description: json['description'],
      startDate: json['startDate'],
      endDate: json['endDate'],
  
    );
  }
}
