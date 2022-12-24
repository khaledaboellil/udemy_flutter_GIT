import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/social_app/cubit/socialappcubit.dart';
import 'package:todo_app/layout/social_app/cubit/socialappstates.dart';
import 'package:todo_app/models/Social%20Register%20Model/SocialRegistermodel.dart';
import 'package:todo_app/shared/comapnents/companents.dart';

import '../../../models/SocialGroupMessageModel/SocialGroupMessageModel.dart';
import '../../../shared/styles/icon_broken.dart';

class SocialGroupDetails extends StatelessWidget {
  String groupName ;
  SocialGroupDetails(this.groupName);
  var messageController = TextEditingController();
  ScrollController scoller_Controller=ScrollController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialUserModel model =SocialLayoutCubit.get(context).model! ;
        SocialLayoutCubit.get(context).getGroupMessages(groupName: groupName);
        return BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
          listener: (context,state){},
          builder: (context,state){
            var chatImage=SocialLayoutCubit.get(context).chatImage ;
            var chatImageUrl=SocialLayoutCubit.get(context).chatImageUrl ;
            return Scaffold(
              appBar: defaultAppBar(context: context
              ,title: groupName
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if( state is AddChatPhotoLoadingState)
                      LinearProgressIndicator(),
                    Expanded(
                        child: Container(
                          child: ListView.separated(
                            controller: scoller_Controller,
                              itemBuilder: (context,index){
                                if(SocialLayoutCubit.get(context).groupMessages[index].senderId!=model.uId)
                                  return buildotherMessage(SocialLayoutCubit.get(context).groupMessages[index],context) ;
                                else
                                  return buildMyMessage(SocialLayoutCubit.get(context).groupMessages[index],context) ;
                              },
                              separatorBuilder:(context,index)=>SizedBox(height: 10,),
                              itemCount: SocialLayoutCubit.get(context).groupMessages.length),
                        )),
                    if(chatImage!=null)
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.all(Radius.circular(4)) ,
                            ),
                            child:Image(image: NetworkImage(chatImageUrl)),
                          ),
                          CircleAvatar(child: IconButton(onPressed:(){
                            SocialLayoutCubit.get(context).removePostImage() ;
                          }, icon:Icon(IconBroken.Close_Square)),),
                        ],
                      ) ,
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: messageController,
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(borderSide: BorderSide.none),
                                  hintText: 'write your message....' ,
                                  icon: Icon(IconBroken.Edit),
                                ),
                              ),
                            ),
                            IconButton(onPressed: (){
                              SocialLayoutCubit.get(context).getChatImage();
                            }, icon: Icon(IconBroken.Image_2)),
                            IconButton(
                              onPressed: () {
                                if(messageController.text.isNotEmpty||chatImageUrl.isNotEmpty)
                                {
                                  SocialLayoutCubit.get(context).sendGroupMessage(profileName:model.name,
                                      groupName: groupName,
                                      profileImage: model.image,
                                      date: DateTime.now().toString(),
                                      text: messageController.text,
                                      imageUrl: chatImageUrl??'');
                                      SocialLayoutCubit.get(context).removePostImage();
                                      SocialLayoutCubit.get(context).sendMessageForGroupUsers(
                                      'New message One Group ${groupName}',
                                      messageController.text,
                                      SocialLayoutCubit.get(context).model!.image,
                                      groupName
                                      );
                                      SocialLayoutCubit.get(context).removePostImage();
                                      messageController.text='';
                                      scoller_Controller.animateTo(scoller_Controller.position.maxScrollExtent,
                                          duration: Duration(microseconds:100), curve: Curves.easeOut);
                                }

                              }, icon: Icon(IconBroken.Send),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },

        );
      });
  }

  Widget buildMyMessage(SocialGroupMessageModel model,context)=>Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(model.profileName,style: Theme.of(context).textTheme.bodyText1!.copyWith(
          fontSize: 10
        ),),
        if(model.text.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.5),
                  borderRadius: BorderRadiusDirectional.only(
                    bottomStart: Radius.circular(
                      10.0,
                    ),
                    topStart: Radius.circular(
                      10.0,
                    ),
                    topEnd: Radius.circular(
                      10.0,
                    ),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 10.0,
                ),
                child: Text(
                  model.text,
                ),
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(model.profileImage),
                radius: 10,
              ),
            ],
          ),
        if(model.imageUrl.isNotEmpty)
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(4)) ,
            ),
            child:Image(image: NetworkImage(model.imageUrl)),
          ),
        Text(model.dateTime,style: Theme.of(context).textTheme.caption,)
      ],
    ),
  ) ;

  Widget buildotherMessage(SocialGroupMessageModel model,context)=>Align(
    alignment: AlignmentDirectional.centerStart,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(model.profileName,style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: 10
        ),),
        if(model.text.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(model.profileImage),
                radius: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadiusDirectional.only(
                    bottomEnd: Radius.circular(
                      10.0,
                    ),
                    topStart: Radius.circular(
                      10.0,
                    ),
                    topEnd: Radius.circular(
                      10.0,
                    ),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 10.0,
                ),
                child: Text(
                  model.text,
                ),
              ),
            ],
          ),
        if(model.imageUrl.isNotEmpty)
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(4)) ,
            ),
            child:Image(image: NetworkImage(model.imageUrl)),
          ),
        Padding(
          padding: const EdgeInsets.all(0),
          child: Text(model.dateTime,style: Theme.of(context).textTheme.caption,),
        )
      ],
    ),
  );
}

