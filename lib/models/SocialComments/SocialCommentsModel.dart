class SocialCommentModel {
  late String text ;
  late String name ;
  late String image;
  late String date;
  late String uId;

  SocialCommentModel.fromjson(Map<String, dynamic> json){
    text = json['text'] ;
    name = json['name'] ;
    image = json['image'] ;
    date = json['data'] ;
    uId = json['uId'] ;

  }
}