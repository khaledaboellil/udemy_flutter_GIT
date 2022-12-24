import 'package:audioplayers/audioplayers.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/layout/social_app/cubit/socialappstates.dart';
import 'package:todo_app/models/SocialPostModel/SocialPostmodel.dart';
import 'package:todo_app/shared/styles/icon_broken.dart';

import '../../../layout/social_app/cubit/socialappcubit.dart';
import '../../../models/SocialComments/SocialCommentsModel.dart';
import '../../../shared/comapnents/companents.dart';

class SocialComment extends StatelessWidget {
  String postId ;
  SocialComment(this.postId) ;
  var commentContoller=TextEditingController();
  ScrollController scoller_Controller=ScrollController();
  final player = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialLayoutCubit.get(context).getComments(postId);
        print('this is post id');
        print(postId);
        print(SocialLayoutCubit.get(context).commentsNumber['$postId']);
        print(SocialLayoutCubit.get(context).commentModel['$postId']);
        return BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
            listener:(context,state){},
            builder: (context,state){

              return Scaffold(
                appBar: defaultAppBar(context: context,
                  title: 'Comments' ,
                  actions: [],
                ),
                body: Padding(
                  padding: const EdgeInsets.all(20),
                  child :Column(
                      children: [
                        Expanded(
                          child: Container(
                            child: SingleChildScrollView(
                              child: ConditionalBuilder(condition: SocialLayoutCubit.get(context).commentModel.isNotEmpty
                                  , builder:(context)=>ListView.separated(
                                    controller: scoller_Controller,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context,index)=>buildCommentsList(context,SocialLayoutCubit.get(context).commentModel['${postId}']![index]),
                                  separatorBuilder:(context,index)=>SizedBox(height: 30,) ,
                                  itemCount:SocialLayoutCubit.get(context).commentModel['${postId}']!.length),
                                  fallback:(context)=>Center(child: Container(),))
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: HexColor('#e8e8e8'),
                                        borderRadius: BorderRadius.all(Radius.circular(30))),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      child: TextFormField(
                                          controller: commentContoller,
                                          validator: (value){
                                            if(value!.isEmpty)
                                            {
                                              return 'please enter the comment' ;
                                            }
                                          },
                                          decoration: InputDecoration(
                                            labelText: 'write your comment....' ,
                                            icon: Icon(IconBroken.Edit),
                                            border: InputBorder.none ,
                                          ),
                                          onFieldSubmitted: (value) {
                                            SocialLayoutCubit.get(context).addComment(
                                              postId,
                                              value,
                                              SocialLayoutCubit.get(context).model!.image,
                                              SocialLayoutCubit.get(context).model!.name,
                                              DateTime.now().toString(),
                                              SocialLayoutCubit.get(context).model!.uId,
                                            ) ;
                                            SocialLayoutCubit.get(context).sendMessageForAllUsers(SocialLayoutCubit.get(context).tokensList
                                                , 'New comment by ${SocialLayoutCubit.get(context).model!.name}',
                                                commentContoller.text,
                                                SocialLayoutCubit.get(context).model!.image);
                                           commentContoller.text='';
                                            scoller_Controller.animateTo(scoller_Controller.position.maxScrollExtent,
                                                duration: Duration(microseconds:100), curve: Curves.easeOut);
                                           player.play(AssetSource('sounds/like.mp3'));
                                          }
                                      ),
                                    )
                                )),
                          ],
                        ),
                      ]
                  ),
                ),
              ) ;
            },
        );
      }
    );
  }

  Widget buildCommentsList(context,SocialCommentModel model)=>Column(
    children: [
      Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage:
            NetworkImage(model.image),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(model.name,style: Theme.of(context).textTheme.subtitle2,) ,
                SizedBox(height: 10,) ,
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(

                            color: HexColor('#e8e8e8'),
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(model.text,

                          maxLines: 100,
                          style: Theme.of(context).textTheme.subtitle1,),
                            ),
                      ),
                    ),
                  ],
                ),
                Text(model.date,style: Theme.of(context).textTheme.caption,)
              ],
            ),
          ),
        ],
      )
    ],
  );
}
