class SocialPostModel{
  late String name ;
  late String uId;
  late String image;
  late String postImage;
  late String text ;
  late String date ;


  SocialPostModel(this.name,this.uId,this.image,this.postImage,this.text,this.date);
  SocialPostModel.fromjson(Map<String,dynamic>?json){
    name = json!['name'] ;
    uId = json['uId'] ;
    image=json['image'] ;
    postImage=json['postImage'] ;
    text=json['text'] ;
    date=json['date'];
  }
  Map<String,dynamic> toMap(){
    return {
      'name' : name ,
      'uId' : uId ,
      'image':image ,
      'postImage':postImage ,
      'text':text ,
      'date':date ,
    } ;
  }
}