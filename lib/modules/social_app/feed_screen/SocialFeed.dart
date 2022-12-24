import 'package:audioplayers/audioplayers.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo_app/layout/social_app/cubit/socialappcubit.dart';
import 'package:todo_app/layout/social_app/cubit/socialappstates.dart';
import 'package:todo_app/models/SocialComments/SocialCommentsModel.dart';
import 'package:todo_app/models/SocialPostModel/SocialPostmodel.dart';
import 'package:todo_app/modules/social_app/EditingPost/EditingPost.dart';
import 'package:todo_app/modules/social_app/LikesDetails/LikesDetails.dart';
import 'package:todo_app/modules/social_app/comment_Screen/socialcommentscreen.dart';
import 'package:todo_app/shared/comapnents/companents.dart';
import 'package:todo_app/shared/comapnents/constans.dart';

import '../../../shared/styles/icon_broken.dart';

class SocialFeed extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context){
      // SocialLayoutCubit.get(context).getPostData();
      // SocialLayoutCubit.get(context).getLikes();
      // SocialLayoutCubit.get(context).getComments();
      final player = AudioPlayer();

      return BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
        listener: (context,state){},
        builder: (context,state){
          return ConditionalBuilder(
              condition: SocialLayoutCubit.get(context).posts.length>0&& SocialLayoutCubit.get(context).model!=null
                  &&SocialLayoutCubit.get(context).likes.length>0&&SocialLayoutCubit.get(context).commentsNumber.length>0,
              builder: (context)=>SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                          margin:EdgeInsets.all(8.0) ,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 5,
                          child:Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              Image(
                                image:NetworkImage('https://img.freepik.com/free-photo/emotional-bearded-male-has-surprised-facial-expression-astonished-look-dressed-white-shirt-with-red-braces-points-with-index-finger-upper-right-corner_273609-16001.jpg?w=900&t=st=1671097417~exp=1671098017~hmac=e6075126a7bc557af81ef861a8ce8c88153d4ad83a5cb8821bc1b8d85aa6a58a'),
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20,right:10),
                                child: Text('Comminuacte With your Friends',
                                    style: Theme.of(context).textTheme.subtitle1
                                ) ,
                              ),
                            ],)

                      ),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder:(context,index)=>buildFeedPage(SocialLayoutCubit.get(context).posts[index],context,index,player),
                          separatorBuilder:(context,index)=>SizedBox(height: 10,),
                          itemCount: SocialLayoutCubit.get(context).posts.length),
                    ],
                  )
              ),
              fallback: (context)=>Center(child: CircularProgressIndicator(),));
        },
      );
    });
  }
Widget buildFeedPage(SocialPostModel model ,context,index,AudioPlayer player)=> Card(
  elevation: 5,
  clipBehavior: Clip.antiAliasWithSaveLayer,
  margin: EdgeInsets.symmetric(
    horizontal: 8.0,
  ),

  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(model.image),
              ),
              SizedBox(width: 10,) ,
              Expanded(child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(model.name),
                      SizedBox(width:5 ,),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius:BorderRadius.circular(20),
                            color:defaultcolor,
                          ),

                          child: Icon(Icons.check,color:Colors.white,size:12,))
                    ],
                  ) ,
                  Text(model.date,style: Theme.of(context).textTheme.caption,)
                ],
              )),
              if(model.uId==SocialLayoutCubit.get(context).model!.uId)
              PopupMenuButton(
                  onSelected: (value){
                    if(value==2)
                      SocialLayoutCubit.get(context).deletePost(SocialLayoutCubit.get(context).postId[index]);
                    else
                      navigateTo(context, SocialEditingPost(SocialLayoutCubit.get(context).postId[index],model));
                  },
                  itemBuilder: (context)=> [
                PopupMenuItem(
                  child: Text("Edit post"),
                  value: 1,
                ),
                PopupMenuItem(
                  child: Text("Delete post"),
                  value: 2,
                ),
              ]
              ),

            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical:5),
          child: Container(height: 1,
            width: double.infinity,
            color: Colors.grey[300],
          ),
        ),
        if(model.text.isNotEmpty)
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(model.text
            ,style: Theme.of(context).textTheme.subtitle1!.copyWith(
                height: 1.3
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(bottom: 10),
        //   child: Wrap(children: [
        //     Container(
        //       height: 20,
        //       child: MaterialButton(onPressed: (){},
        //         minWidth: 1,
        //         child: Text("#software",
        //           style:TextStyle(
        //             color: defaultcolor ,
        //           ),),
        //       ),
        //     ) ,
        //     Container(
        //       height: 20,
        //       child: MaterialButton(onPressed: (){},
        //         minWidth: 1,
        //         child: Text("#programming",
        //           style:TextStyle(
        //             color: defaultcolor ,
        //           ),),
        //       ),
        //     )
        //   ]),
        // ),
        if(model.postImage.isNotEmpty)
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 5,
            child:Image(
              image:NetworkImage(model.postImage),
              height: 160,
              width: double.infinity,
              fit: BoxFit.fill,
            )

        ),
        if(model.postImage.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical:5),
            child: Container(height: 1,
              width: double.infinity,
              color: Colors.grey[300],
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: (){
                    navigateTo(context, SocialLikeDetails(SocialLayoutCubit.get(context).postId[index]));
                  },
                  child: Row(
                    children: [
                      Icon(IconBroken.Heart,color: Colors.red,size: 20,) ,
                      SizedBox(width: 5,) ,
                      Text('${SocialLayoutCubit.get(context).likes[SocialLayoutCubit.get(context).postId[index]]}',style:Theme.of(context).textTheme.caption ,) ,
                    ],
                  ),
                ),),
              Expanded(
                child: InkWell(
                  onTap: (){
                    navigateTo(context,SocialComment(SocialLayoutCubit.get(context).postId[index]));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(IconBroken.Document,color: Colors.amber,size: 20,) ,
                      SizedBox(width: 5,) ,
                      Text('${SocialLayoutCubit.get(context).commentsNumber[SocialLayoutCubit.get(context).postId[index]]}',style:Theme.of(context).textTheme.caption ,) ,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical:5),
          child: Container(height: 1,
            width: double.infinity,
            color: Colors.grey[300],
          ),
        ),  //divider
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(child: InkWell(
                onTap: (){
                  if(SocialLayoutCubit.get(context).likeStatus[SocialLayoutCubit.get(context).postId[index]]! =='like')
                    {
                      SocialLayoutCubit.get(context).addLike(SocialLayoutCubit.get(context).postId[index]);
                      SocialLayoutCubit.get(context).sendMessageForAllUsers(SocialLayoutCubit.get(context).tokensList
                          , 'New like by ${SocialLayoutCubit.get(context).model!.name}',
                          '',
                          SocialLayoutCubit.get(context).model!.image);
                    }

                  else
                  SocialLayoutCubit.get(context).removeLike(SocialLayoutCubit.get(context).postId[index]);
                  
                  player.play(AssetSource('sounds/like.mp3'));

                  
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(IconBroken.Heart,color: Colors.red,size: 20,),
                    SizedBox(width: 10,),
                    Text(SocialLayoutCubit.get(context).likeStatus[SocialLayoutCubit.get(context).postId[index]]!,style:Theme.of(context).textTheme.caption,),
                  ],
                ),
              ),),
              Expanded(child: InkWell(
                onTap: (){
                    navigateTo(context,SocialComment(SocialLayoutCubit.get(context).postId[index]));
                },
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(IconBroken.Document,color: Colors.amber,size: 20,),
                    SizedBox(width: 10,),
                    Text('Comments',style:Theme.of(context).textTheme.caption,),
                  ],
                ),
              ),)
            ],
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(vertical:5),
        //   child: Container(height: 1,
        //     width: double.infinity,
        //     color: Colors.grey[300],
        //   ),
        // ),  //divider
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Row(
        //     children: [
        //       Expanded(
        //         child: InkWell(
        //           onTap: (){
        //             navigateTo(context, SocialComment());
        //           },
        //           child: Container(
        //             decoration: BoxDecoration(
        //               color: HexColor('#e8e8e8'),
        //               borderRadius: BorderRadius.all(Radius.circular(30))
        //             ),
        //             child: Row(
        //               children: [
        //                 CircleAvatar(
        //                   radius: 25,
        //                   backgroundImage: NetworkImage(model.image),
        //                 ),
        //                 SizedBox(width: 10,) ,
        //                 Text('Write a comment...',
        //                   style:Theme.of(context).textTheme.caption,),
        //               ],
        //             ),
        //           ),
        //         ),
        //       ),
        //
        //
        //     ],
        //   ),
        // ),
      ],
    ),
  ),
) ;

}