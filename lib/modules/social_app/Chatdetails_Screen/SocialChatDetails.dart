import 'package:audioplayers/audioplayers.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/layout/social_app/cubit/socialappcubit.dart';
import 'package:todo_app/layout/social_app/cubit/socialappstates.dart';
import 'package:todo_app/models/Social%20Register%20Model/SocialRegistermodel.dart';
import 'package:todo_app/shared/network/remote/dio_helper.dart';

import '../../../models/SocialMessageModel/SocialMessageModel.dart';
import '../../../shared/styles/icon_broken.dart';


class SocialChatDetails extends StatelessWidget {
  var messageController = TextEditingController();
  ScrollController scoller_Controller=ScrollController();
  SocialUserModel model ;
  SocialChatDetails(this.model);
  @override
  Widget build(BuildContext context) {

    return Builder(builder: (BuildContext context){
      SocialLayoutCubit.get(context).getMessages(recieverId: model.uId);
      final player = AudioPlayer();
      return BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
        listener:(context,state){},
        builder: (context,state){
          var chatImage=SocialLayoutCubit.get(context).chatImage ;
          var chatImageUrl=SocialLayoutCubit.get(context).chatImageUrl ;
          return Scaffold(
            appBar: AppBar(
              title:  Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(model.image),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(model.name),
                  ]),
              titleSpacing: 1,
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
                              if(SocialLayoutCubit.get(context).messages[index].senderId==model.uId)
                                return buildotherMessage(SocialLayoutCubit.get(context).messages[index],context) ;
                              else
                                return buildMyMessage(SocialLayoutCubit.get(context).messages[index],context) ;
                            },
                            separatorBuilder:(context,index)=>SizedBox(height: 10,),
                            itemCount: SocialLayoutCubit.get(context).messages.length),
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
                                  SocialLayoutCubit.get(context).sendMessage(recieverId: model.uId,
                                      date: DateTime.now().toString(),
                                      text: messageController.text,
                                      imageUrl: chatImageUrl??'');
                                  SocialLayoutCubit.get(context).removePostImage();
                                  SocialLayoutCubit.get(context).sendMessageForOneUser(model.token,
                                      'New message From ${SocialLayoutCubit.get(context).model!.name}',
                                      messageController.text,
                                      SocialLayoutCubit.get(context).model!.image);
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

  Widget buildMyMessage(SocialMessageModel model,context)=>Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if(model.text.isNotEmpty)
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

  Widget buildotherMessage(SocialMessageModel model,context)=>Align(
    alignment: AlignmentDirectional.centerStart,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(model.text.isNotEmpty)
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
