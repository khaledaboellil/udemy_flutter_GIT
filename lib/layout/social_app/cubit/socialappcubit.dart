import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/social_app/cubit/socialappstates.dart';
import 'package:todo_app/models/Social%20Register%20Model/SocialRegistermodel.dart';
import 'package:todo_app/models/SocialComments/SocialCommentsModel.dart';
import 'package:todo_app/models/SocialGroupMessageModel/SocialGroupMessageModel.dart';
import 'package:todo_app/models/SocialMessageModel/SocialMessageModel.dart';
import 'package:todo_app/models/SocialPostModel/SocialPostmodel.dart';
import 'package:todo_app/modules/social_app/chats_screen/Socialchat.dart';
import 'package:todo_app/modules/social_app/feed_screen/SocialFeed.dart';
import 'package:todo_app/modules/social_app/settings/socialsettings.dart';
import 'package:todo_app/modules/social_app/user_screen/SocialUSer.dart';
import 'package:todo_app/shared/comapnents/companents.dart';
import 'package:todo_app/shared/comapnents/constans.dart';
import 'package:todo_app/shared/styles/icon_broken.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../../shared/network/remote/dio_helper.dart';
class SocialLayoutCubit extends Cubit<SocialLayoutStates> {
  SocialLayoutCubit() : super(SocialLayoutInitialStates());

  static SocialLayoutCubit get(context)=>BlocProvider.of(context) ;
  SocialUserModel? model ;

  void getUserData()
  {
    print('anaaaaaaaaaaaaaaaaaaaaabt2lm');
    emit(SocialGetUserLoadingStates()) ;
    FirebaseFirestore.instance.collection('users').doc(uID).snapshots().listen((value) {
      print('ana et3irt');
              if(value.data()!= null)
              model = SocialUserModel.fromjson(value.data()) ;
              print(model!.email) ;
              emit(SocialGetUserSucessfullStates());
            }) ;
  }
List<SocialUserModel>allUserModel=[];
List<String>tokensList=[];
List< bool >checkBox=[];
  void getAllUsers(){
    allUserModel=[];
    tokensList=[];
    emit(SocialGetAllUserLoadingStates());
    if(allUserModel.length==0)
    FirebaseFirestore.instance.collection('users').get().then((value){
      value.docs.forEach((element) {
        tokensList.add(SocialUserModel.fromjson(element.data()).token);
        if(SocialUserModel.fromjson(element.data()).uId!=uID)
        allUserModel.add(SocialUserModel.fromjson(element.data()));
      });
      emit(SocialGetAllUserSucessfullStates());
    }).catchError((error){
      emit(SocialGetAllUserErrorStates(error));
    });
  }

List<BottomNavigationBarItem>socialNavBar =[
  BottomNavigationBarItem(icon: Icon(IconBroken.Home),label: 'Home') ,
  BottomNavigationBarItem(icon: Icon(IconBroken.Chat),label: 'Chats') ,
  BottomNavigationBarItem(icon: Icon(IconBroken.Paper_Upload),label: 'NewPost') ,
  BottomNavigationBarItem(icon: Icon(IconBroken.User),label: 'User') ,
  BottomNavigationBarItem(icon: Icon(IconBroken.Setting),label: 'Settings')
] ;

int nav_Index= 0 ;
int screen_Index= 0 ;
List<String>titles=[
  "News Feed",
  "Chats",
  "User",
  "Settings",
];
List<Widget>Screens=[
  SocialFeed() ,
  SocialChats(),
  SocialUsers(),
  SocialSettings(),
];

void changeSocialScreen(index)
{
  if(index==1)
    getAllUsers();
  if(index==2)
    {
      emit(SocialNewPostState()) ;
    }
  else{
    nav_Index=index;
    if(index>2){
      screen_Index = index-1 ;
    }
    else
      {
        screen_Index = index ;
      }
    emit(SocialChangeNavBar()) ;
  }
}

Map<String,List<SocialUserModel>>groupChat = {};
List<SocialUserModel>groupMemeber=[];
  List<String> groupsNames=[] ;
Map<String,List<String>>groupUId= {};
void addGroupChatMembers(String groupName,List<SocialUserModel> model,List<bool>value)
{
  groupMemeber=[];
  groupUId={} ;
  groupUId= {};
  for( var i = 0 ; i <value.length; i++ ) {
    if(value[i])
      {
        emit(AddGroupLoadingState());
        FirebaseFirestore.instance.collection('Group').doc(groupName).set({"group":true}).then((value){});
        FirebaseFirestore.instance.collection('Group').doc(groupName).collection('users').doc(model[i].uId).set(model[i].toMap()).then(
                (value){
                  emit(AddGroupSucessState());
                }).catchError((){
          emit(AddGroupErrorState());
        });
        groupMemeber.add(model[i]);
        if(model[i].uId == this.model!.uId ){
          groupUId={} ;
          groupsNames.add(groupName);
          groupUId.addAll({this.model!.uId:groupsNames});
        }
      }
  }
  groupChat.addAll({groupName:groupMemeber});
}
Map<String,List<String>>nameToUId={};
  List<String>U_ID=[];
void getGroupUsers(){
  emit(GetGroupLoadingState());

  FirebaseFirestore.instance.collection('Group').snapshots().listen((event) {
   U_ID=[];
   nameToUId={};
   groupsNames=[];
    event.docs.forEach((element) {

      print(element.id);
      element.reference.collection('users').snapshots().listen((value) {
        value.docs.forEach((b) {
          U_ID.add(b.id);
          if(b.id==model!.uId)
            {
              groupUId={};
              groupsNames.add(element.id);
              groupUId.addAll({model!.uId:groupsNames}) ;
            }

        });
      });
      nameToUId.addAll({element.id:U_ID});
    });

    emit(GetGroupSucessState());
  });
}
  File ?profileImage ;
  String ?profileImageUrl ;
Future<void> getImage()async{
  final ImagePicker picker = ImagePicker();
  emit(UpdateProfileImageLoadingState());
  final XFile? image = await picker.pickImage(source: ImageSource.gallery).then(
      (value){
        print(value!.path);

        profileImage=File(value.path) ;
        firebase_storage.FirebaseStorage.instance
            .ref()
            .child('users/${Uri.file(value.name).pathSegments.last}')
            .putFile(profileImage!).then((element){
              element.ref.getDownloadURL().then((value){
                profileImageUrl=value ;
                print('ana fe el get Image ') ;
                print(profileImageUrl) ;
                emit(UpdateProfileImageSucessState());
              }
              ).catchError((error){print('ana error feh el get image XD');});
        }).catchError((e){print(e.toString());});

      })
      .catchError((error){
        print("ana error yasta");
        print(error.toString());
        emit(UpdateProfileImageErrorState());

  });

}



  File ?coverImage ;
  String ?coverImageUrl ;
  Future<void> getCoverImage()async{
    final ImagePicker picker = ImagePicker();
    emit(UpdateCoverImageLoadingState());
    final XFile? image = await picker.pickImage(source: ImageSource.gallery).then(
            (value){
          print(value!.path);
          coverImage=File(value.path) ;
          firebase_storage.FirebaseStorage.instance
              .ref()
              .child('users/${Uri.file(value.name).pathSegments.last}')
              .putFile(coverImage!).then((element){
            emit(UpdateCoverImageLoadingState());
            element.ref.getDownloadURL().then((value){

              coverImageUrl=value ;
              print(coverImageUrl);
              emit(UpdateCoverImageSucessState());
            }).catchError((error){print(error.toString());});
          }).catchError((e){
            print('ana error fe l get cover') ;
            print(e.toString());});

        })
        .catchError((error){
      print("ana error yasta");
      print(error.toString());
      emit(UpdateCoverImageErrorState());
    });
  }

  void updateProfile({
    required String name ,
    required String phone ,
    required String bio ,
    String ?cover ,
    String ?profileImage,
}){
    emit(UpdateProfileDataLoadingStates());
    print('ana fe elupdate') ;
    print(profileImage);
    print(cover);
    SocialUserModel updateModel = SocialUserModel(
        name,
        phone,
        model!.email,
        model!.uId,
        false,
        profileImage??model!.image,
        cover??model!.coverImage,
        bio,
        token!,
    ) ;
    FirebaseFirestore.instance.collection('users').doc(model!.uId).update(updateModel.toMap()).then(
            (value){

                print("ana 3mlt update") ;
                getUserData();
                updateAllPost();
                updateAllComment();
                profileImage=null ;
                coverImage=null ;
                profileImageUrl=null;
                coverImageUrl=null ;
            }).catchError((Error){
              emit(UpdateProfileDataErrorStates());
              print(Error.toString());
    });
  }

  File ?postImage ;
  String postImageUrl='' ;
  Future<void> getPostImage()async{
    final ImagePicker picker = ImagePicker();
    emit(AddPostPhotoLoadingState());
    final XFile? image = await picker.pickImage(source: ImageSource.gallery).then(
            (value){
          print(value!.path);
          postImage=File(value.path) ;
          firebase_storage.FirebaseStorage.instance
              .ref()
              .child('posts/${Uri.file(value.name).pathSegments.last}')
              .putFile(postImage!).then((element){
            element.ref.getDownloadURL().then((value){
              postImageUrl=value ;
              print('ana fe el get Image ') ;
              print(postImageUrl) ;
              emit(AddPostPhotoSucessState());
            }
            ).catchError((error){print('ana error feh el get image XD');});
          }).catchError((e){print(e.toString());});

        })
        .catchError((error){
      print("ana error yasta");
      print(error.toString());
      emit(AddPostPhotoErrorState());

    });

  }

  void addPost({
    required String name ,
    required String image ,
    required String date ,
    required String uId,
    required String text ,
    required postImage ,


  }){
    emit(UploadPostPhotoLoadingState());

    print(postImage);

    SocialPostModel postModel = SocialPostModel(name, uId, image, postImage, text, date) ;
    FirebaseFirestore.instance.collection('posts').add(postModel.toMap()).then(
            (value){


          postImage=null ;
          postImageUrl='';
          emit(UploadPostPhotoSucessState());

        }).catchError((Error){
      emit(UploadPostPhotoErrorState());
      print(Error.toString());
    });
  }
  List<SocialPostModel>posts=[] ;
  List<String>postId=[];
  List<String>comments=[];
  Map<String,int>likes = {};
  Map<String,String>likeStatus = {};
  Map<String,int>commentsNumber={};
  List <SocialCommentModel> commentMap =[] ;
  Map<String,List<SocialCommentModel>> commentModel={} ;
  void getCommentsNumber(){
    FirebaseFirestore.instance.collection('posts').orderBy('date').snapshots().listen((value) {
      commentsNumber={};

      value.docs.forEach((element) {

        FirebaseFirestore.instance.collection('posts').doc(element.id).collection('comments').snapshots().listen((value) {

          commentsNumber.addAll({element.id: value.docs.length});
          emit(GetCommentNumSucessState());
        });

      });
    });
  }
  void getComments(String id){

    emit(GetCommentLoadingState());
    FirebaseFirestore.instance.collection('posts').doc(id).collection('comments').orderBy('data').snapshots().listen((value) {
      commentMap=[];
      commentModel={};

      value.docs.forEach((b) {
        if (b.data() != null)
          commentMap.add(SocialCommentModel.fromjson(b.data()));
      });
      commentModel.addAll({id: commentMap});
      emit(GetCommentSucessState());
    });


  }
  bool status=true ;
  void getLikes(){
    emit(GetLikeLoadingState());
    FirebaseFirestore.instance.collection('posts').orderBy('date').snapshots().listen((value) {
          value.docs.forEach((element) {
            likeStatus={};

            element.reference.collection('likes').snapshots().listen((event) {
              status=false ;

              event.docs.forEach((b) {
                if(b.id==uID)
                {

                  likeStatus.addAll({element.id:'dislike'});
                  status = true ;
                }
              });

              if(status!=true){

                likeStatus.addAll({element.id:'like'});
              }
              likes.addAll({element.id:event.docs.length});

              emit(GetLikeSucessState());
            });
        });
  });
        }
  void getPostData()
  {


    emit(SocialGetPostLoadingStates()) ;
    FirebaseFirestore.instance.collection('posts').orderBy('date',descending:true).snapshots().listen((value) {
              postId=[];
              posts=[];
          value.docs.forEach((element) {
              postId.add(element.id);
              posts.add(SocialPostModel.fromjson(element.data()));

              emit(SocialGetPostSucessfullStates());
          });
        });
  }
  void addLike(String id ){
    FirebaseFirestore.instance.collection('posts').doc(id).collection('likes').doc(model!.uId).set(model!.toMap()).then(
            (value){
              emit(AddLikeSucessState());
            }).catchError((error){
              emit(AddLikeSucessState());
    });
  }

  void removeLike(String id ){
      FirebaseFirestore.instance.collection('posts').doc(id).collection('likes').doc(uID).delete().then((value){
        emit(RemoveLikeSucessState());
      }).catchError((error){
        emit(RemoveLikeErrorState());
      });
  }
  void addComment(String id,String text,String image ,String name,String date,String uId) {
    FirebaseFirestore.instance.collection('posts').doc(id).collection('comments').add({
      'text': text,
      'image': image,
      'name': name,
      'data':date,
      'uId':uId,
    }).then(
            (value){
      emit(AddCommentSucessState());
        }).catchError((error){
      emit(AddCommentSucessState());
    });
  }
  void deletePost(String id ){
    FirebaseFirestore.instance.collection('posts').doc(id).delete().then((value){
      emit(RemovePostSucessState());
    }).catchError((error){
      emit(RemovePostErrorState());
    });
  }
  void editPost(String id,String name ,String uId ,String image, String postImage,String text ,String date){
    SocialPostModel model = SocialPostModel(name, uId, image, postImage, text, date);
    FirebaseFirestore.instance.collection('posts').doc(id).update(model.toMap()).then((value){
      emit(EditPostSucessState());
    }).catchError((){
      emit(EditPostErrorState());
    });

  }
  void updateAllPost()
  {
    emit(UpdateAllPostsLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value){
      value.docs.forEach((element) {
        print('ana hna feh el update');
        element.reference.get().then((b){
          if(b.data()!['uId']==model!.uId)
            {
              b.reference.update(
                  {'date': b.data()!['date'],
                    'image':model!.image,
                    'name':model!.name,
                    'postImage':b.data()!['postImage'],
                    'text':b.data()!['text'],
                    'uId':b.data()!['uId'],
              });
            }
          print(b.data()!['uId']);
        });
      });
      emit(UpdateAllPostsSucessState());
    }).catchError((){
      emit(UpdateAllPostsErrorState());
    });
  }
  void updateAllComment()
  {
    print('ysta');
    emit(UpdateAllCommentsLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value){
      value.docs.forEach((element) {
        element.reference.collection('comments').get().then((value){
          value.docs.forEach((element) {
            element.reference.get().then((b){
              print('انا فى uid') ;
              print(b.data()!['uId']);
              print(model!.uId);
            if(b.data()!['uId']==model!.uId)
            {
              print('anahna');
              b.reference.update(
                  {
                    'data': b.data()!['data'],
                    'image':model!.image,
                    'name':model!.name,
                    'text':b.data()!['text'],
                    'uId':b.data()!['uId'],
                  });
            }
            print(b.data()!['uId']);
            });
          });

        });
      });
      emit(UpdateAllCommentsSucessState());
    }).catchError((){
      emit(UpdateAllCommentsErrorState());
    });
  }

  List<SocialUserModel> whoLiked=[]  ;

  void getWhoLike(String postId){
    FirebaseFirestore.instance.collection('posts').doc(postId).collection('likes').snapshots().listen((value) {
      whoLiked=[];
      value.docs.forEach((element) {
        element.reference.snapshots().listen((value){
          print('get who likes ');
          print(SocialUserModel.fromjson(value.data()).name);
           whoLiked.add(SocialUserModel.fromjson(value.data())) ;
        });
      });
      emit(GetWhoLikedSucessState());
    });

  }

  void sendMessage(
      {
    required String recieverId,
    required String date,
    required String text,
    required imageUrl
}
      ){
    SocialMessageModel messagemodel = SocialMessageModel(text,model!.uId, recieverId, imageUrl, date);
    FirebaseFirestore.instance.collection('users')
    .doc(model!.uId).
    collection('chats').
    doc(recieverId).collection('messages').add(messagemodel.toMap()).then((value){
      emit(SendMessageSucessState());
    }).catchError((error){
      emit(SendMessageErrorState());
    });
    FirebaseFirestore.instance.collection('users')
        .doc(recieverId).
        collection('chats').
        doc(model!.uId).collection('messages').add(messagemodel.toMap()).then((value){
          emit(SendMessageSucessState());
    }).catchError((error){
          emit(SendMessageErrorState());
    });
  }
  List<SocialMessageModel> messages = [];
  void getMessages({
  required recieverId,
}){

    FirebaseFirestore.instance.collection('users')
        .doc(model!.uId)
        .collection('chats')
        .doc(recieverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
          messages=[] ;
          event.docs.forEach((element) {
            messages.add(SocialMessageModel.fromjson(element.data()));
          });
          emit(GetMessageSucessState());
    });
  }

  void sendGroupMessage(
      {
        required String date,
        required String text,
        required imageUrl,
        required groupName,
        required profileImage,
        required profileName,
      }
      ){
    SocialGroupMessageModel messagemodel = SocialGroupMessageModel(text,model!.uId, imageUrl, date,profileImage,profileName);

    FirebaseFirestore.instance.collection('Group').doc(groupName).collection('users').get().then((value){
      value.docs.forEach((element) {
        element.reference.collection('groupchat').add(messagemodel.toMap());
      });
    emit(SendGroupMessageSucessState());
    }).catchError((){
      emit(SendGroupMessageErrorState());
    });


  }
  List<SocialGroupMessageModel> groupMessages = [];
  void getGroupMessages({
    required groupName,
  }){
    print('ana t3bt ');
    FirebaseFirestore.instance.collection('Group').doc(groupName).collection('users')
        .doc(model!.uId)
        .collection('groupchat')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      print('ana t3bt ');
     groupMessages=[] ;
     print(event.docs.length);
      event.docs.forEach((element) {
        print('ana t3bt ');
        print(SocialGroupMessageModel.fromjson(element.data()).text);
       groupMessages.add(SocialGroupMessageModel.fromjson(element.data()));
      });
      emit(GetGroupMessageSucessState());
    });
  }
  void removePostImage(){
    postImage = null ;
    postImageUrl='' ;
    chatImage = null ;
    chatImageUrl='' ;
    emit(RemovePostPhotoState());
  }


  String text='' ;
  void changePostButtonColor(String input){
    text = input ;
    emit(ChangePostButtonColor());
  }
  void remove(){
    print('ana hna feh el remove cubit ') ;
    text = '' ;
  }
  File ?chatImage ;
  String chatImageUrl='' ;
  Future<void> getChatImage()async{
    final ImagePicker picker = ImagePicker();
    emit(AddChatPhotoLoadingState());

    final XFile? image = await picker.pickImage(source: ImageSource.gallery).then(
            (value){
              toastShow(msg: 'please wait unitl message upload', state: toastStatus.WARNING);
          print(value!.path);
          chatImage=File(value.path) ;
          firebase_storage.FirebaseStorage.instance
              .ref()
              .child('chats/${Uri.file(value.name).pathSegments.last}')
              .putFile(chatImage!).then((element){
            element.ref.getDownloadURL().then((value){
              chatImageUrl=value ;
              print('ana fe el get chatImage ') ;
              print(chatImageUrl) ;
              emit(AddChatPhotoSucessState());
            }
            ).catchError((error){print('ana error feh el get image XD');});
          }).catchError((e){print(e.toString());});

        })
        .catchError((error){
      print("ana error yasta");
      print(error.toString());
      emit(AddChatPhotoErrorState());

    });

  }
  List<String>groupMembersTokens=[] ;
  void sendMessageForGroupUsers(String title,String body,String image,String groupName){
    groupMembersTokens=[];

    FirebaseFirestore.instance.collection("Group").doc(groupName).collection('users').get().then((value){

      value.docs.forEach((element) {

        groupMembersTokens.add(SocialUserModel.fromjson(element.data()).token);
      });

      groupMembersTokens.forEach((element) {

        DioHelper.postData(url: 'send', data: {
          "to":element,
          "notification": {
            "title": title,
            "body":body ,
            "mutable_content": true,
            "sound": "Tri-tone",
            "image":image
          }
        });
    });
    });
  }
  void sendMessageForAllUsers(List<String>tokens,String title,String body,String image){
    tokens.forEach((element) {
      DioHelper.postData(url: 'send', data: {
        "to":element,
        "notification": {
          "title": title,
          "body":body ,
          "mutable_content": true,
          "sound": "Tri-tone",
          "image":image
        }
      });
    });
  }

  void sendMessageForOneUser(String tokens,String title,String body,String image){
    DioHelper.postData(url: 'send', data: {
      "to":tokens,
      "notification": {
        "title": title,
        "body":body ,
        "mutable_content": true,
        "sound": "Tri-tone",
        "image":image
      }
    });
  }

  void changeCheckBoxValue(){

    emit(ChangeCheckBoxState());
  }
}
