class BlogModel{
  String? id;
  String? username;
  String? image;
  String? description;
  String? datePosted;
  BlogModel({
    this.id,
    this.username,
    this.image,
    this.description,
    this.datePosted
  });

  factory BlogModel.fromJson(Map<dynamic, dynamic> json){
    return BlogModel(
      id: json['_id'],
      username: json['student']['username'],
      image: json['image'],
      description: json['description'],
      datePosted: json['datePosted'],
    );
  }
}