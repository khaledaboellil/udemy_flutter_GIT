class SocialMessageModel{
 late String senderId;
  late String reciverId;
  late String text ;
  late String imageUrl;
  late String dateTime;

  SocialMessageModel(this.text,this.senderId,this.reciverId,this.imageUrl,this.dateTime);

  SocialMessageModel.fromjson(Map<String,dynamic>json){
    senderId=json['senderId'];
    reciverId=json['reciverId'];
    text=json['text'];
    imageUrl=json['imageUrl'];
    dateTime=json['dateTime'];
  }
 Map<String,dynamic> toMap(){
   return {
     'senderId' : senderId ,
     'reciverId' : reciverId ,
     'text' : text ,
     'imageUrl' : imageUrl ,
     'dateTime':dateTime ,
   } ;
 }
}