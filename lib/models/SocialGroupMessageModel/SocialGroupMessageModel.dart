class SocialGroupMessageModel{
  late String senderId;
  late String text ;
  late String imageUrl;
  late String dateTime;
  late String profileImage;
  late String profileName;

  SocialGroupMessageModel(this.text,this.senderId,this.imageUrl,this.dateTime,this.profileImage,this.profileName);

  SocialGroupMessageModel.fromjson(Map<String,dynamic>json){
    senderId=json['senderId'];
    text=json['text'];
    imageUrl=json['imageUrl'];
    dateTime=json['dateTime'];
    profileImage=json['profileImage'];
    profileName=json['profileName'];
  }
  Map<String,dynamic> toMap(){
    return {
      'senderId' : senderId ,
      'text' : text ,
      'imageUrl' : imageUrl ,
      'dateTime':dateTime ,
      'profileImage':profileImage ,
      'profileName':profileName ,
    } ;
  }
}