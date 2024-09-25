class UserModel {
  String? id;
  String? username;
  String? email;
  String? fullName;
  String? role;
  String? graduateLevelID;
  String? graduateLevelName;
  String? studyStatusID;
  String? studyStatusName;
  UserModel({
    this.id,
    this.username,
    this.email,
    this.fullName,
    this.role,
    this.graduateLevelID,
    this.graduateLevelName,
    this.studyStatusID,
    this.studyStatusName,
  });

  factory UserModel.fromJson(Map<dynamic, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      fullName: json['FullName'],
      role: json['Role'],
      graduateLevelID: json['GraduateLevelID'],
      graduateLevelName: json['GraduateLevelName'],
      studyStatusID: json['StudyStatusID'],
      studyStatusName: json['StudyStatusName'],
    );
  }
}
