import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/social_app/cubit/socialappcubit.dart';
import 'package:todo_app/layout/social_app/cubit/socialappstates.dart';
import 'package:todo_app/models/SocialPostModel/SocialPostmodel.dart';
import 'package:todo_app/shared/comapnents/companents.dart';

class SocialEditingPost extends StatelessWidget {
  SocialPostModel postModel ;
  String postId ;
  SocialEditingPost(this.postId,this.postModel);
  var textController =TextEditingController() ;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
        listener:(context,state){},
        builder:(context,state){
          textController.text=postModel.text ;
          return Scaffold(
            appBar: defaultAppBar(context: context,
            title: 'Edit Post',
            actions: [
              IconButton(onPressed: (){
               SocialLayoutCubit.get(context).editPost(postId,
                   postModel.name,
                   postModel.uId,
                   postModel.image,
                   postModel.postImage,
                   textController.text,
                   DateTime.now().toString());
               Navigator.pop(context);
              }, icon: Icon(Icons.check),color: Colors.blue,),
              SizedBox(width: 10,)
            ]
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(postModel.image),
                      radius: 25,
                    ),
                    SizedBox(width: 10,),
                    Text(postModel.name,style: Theme.of(context).textTheme.subtitle1,),
                  ],
                ),
                SizedBox(height: 10,),
                if(postModel.postImage.isNotEmpty)
                  Expanded(child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(postModel.postImage),
                      ),
                    ),

                  )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      
                    ),
                  ),
                ),
              ],),
            ),
          );
        },
    );
  }
}
