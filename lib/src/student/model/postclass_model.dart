class PostClassModel{
  String? id;
  String? username;
  String? description;
  String? image;
  String? date;
  PostClassModel({
    this.id,
    this.username,
    this.description,
    this.image,
    this.date
  });

  factory PostClassModel.fromJson(Map<dynamic, dynamic> json){
    return PostClassModel(
      id: json["id"],
      username: json["user"]["username"],
      description: json["description"],
      image: json['imageUrl'],
      date: json["createdAt"]
    );
  }
}