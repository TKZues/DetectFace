// ignore: camel_case_types
class itemblogModel{
  String? id;
  String? itemblogName;
  itemblogModel(
   {
     this.id,
    this.itemblogName
   }
  );

  factory itemblogModel.fromJson(Map<dynamic, dynamic> json){
    return itemblogModel(
      id: json['_id'],
      itemblogName: json['blogName']
    );
  }
}