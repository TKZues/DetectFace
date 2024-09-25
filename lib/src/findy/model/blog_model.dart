class BlogModel{
  String? id;
  String? author;
  String? image;
  String? title;
  String? description;
  String? datePosted;
  BlogModel({
    this.id,
    this.author,
    this.image,
    this.title,
    this.description,
    this.datePosted
  });

  factory BlogModel.fromJson(Map<dynamic, dynamic> json){
    return BlogModel(
      id: json['_id'],
      author: json['author'],
      image: json['image'],
      title: json['title'],
      description: json['description'],
      datePosted: json['datePosted'],
    );
  }
}