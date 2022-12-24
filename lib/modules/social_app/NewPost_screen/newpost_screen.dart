import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/social_app/cubit/socialappcubit.dart';
import 'package:todo_app/layout/social_app/cubit/socialappstates.dart';
import 'package:todo_app/modules/social_app/feed_screen/SocialFeed.dart';
import 'package:todo_app/shared/comapnents/companents.dart';
import 'package:todo_app/shared/styles/icon_broken.dart';

class SocialNewPost extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var formKey =GlobalKey<FormState>() ;
    var textController = TextEditingController();
    return BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
      listener: (context,state){
        if(state is UploadPostPhotoSucessState)
          {
            toastShow(msg: 'post sucessfully added', state: toastStatus.SUCESS);
            SocialLayoutCubit.get(context).sendMessageForAllUsers(SocialLayoutCubit.get(context).tokensList
                , 'New post by ${SocialLayoutCubit.get(context).model!.name}',
                SocialLayoutCubit.get(context).text,
                SocialLayoutCubit.get(context).model!.image);
            Navigator.pop(context);
          }
      },
      builder: (context,state){
        var postImage=SocialLayoutCubit.get(context).postImage ;
        var postImageUrl=SocialLayoutCubit.get(context).postImageUrl ;
        return  WillPopScope(
          onWillPop:() => removeText(context) ,
          child: Scaffold(
            appBar: defaultAppBar(
                context: context,
                title: 'Create Post',
                actions: [
                  ConditionalBuilder(
                      condition: SocialLayoutCubit.get(context).text.isNotEmpty || postImage != null ,
                      builder:(context)=>TextButton(onPressed: (){
                        print('ana go hna');
                        SocialLayoutCubit.get(context).addPost(
                            name: SocialLayoutCubit.get(context).model!.name,
                            image: SocialLayoutCubit.get(context).model!.image,
                            date: DateTime.now().toString(),
                            uId: SocialLayoutCubit.get(context).model!.uId,
                            text: SocialLayoutCubit.get(context).text.isEmpty ?'' :SocialLayoutCubit.get(context).text,
                            postImage:postImageUrl.isEmpty ? '':postImageUrl,
                        );

                      },
                          child: Container(
                              height: 30,
                              width: 60,
                              decoration: BoxDecoration(

                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(5),
                              ),

                              child: Center(child: Text('POST',
                                style: TextStyle(fontSize: 17,
                                    color:Colors.white ),)))),
                      fallback: (context)=> Padding(
                        padding: const EdgeInsets.only(right:10.0,top: 13,bottom: 13),
                        child: Container(
                            height: 30,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(5),
                            ),

                            child: Center(child: Text('POST',
                              style: TextStyle(fontSize: 17,
                                  color:Colors.grey[300] ),))),
                      )),
                  SizedBox(width: 10,),
                ],
            ),
            body: Form(
              key: formKey,

              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      if(state is UploadPostPhotoLoadingState || state is AddPostPhotoLoadingState)
                      LinearProgressIndicator(),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(SocialLayoutCubit.get(context).model!.image),),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            SocialLayoutCubit.get(context).model!.name,
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 15
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Expanded(
                        child: TextFormField(
                          onChanged: (text)=>SocialLayoutCubit.get(context).changePostButtonColor(text),
                          controller: textController,
                          validator: (validate){
                            if (validate!.isEmpty)
                              {
                                print("please enter what is in your mind") ;
                              }
                          },
                          decoration: InputDecoration(
                            hintText: "what is in your mind ",
                            border: InputBorder.none ,
                          ),
                        ),
                      ),
                      if(postImage!=null)
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
                              child:Image(image: NetworkImage(postImageUrl!)),
                            ),
                            CircleAvatar(child: IconButton(onPressed:(){
                              SocialLayoutCubit.get(context).removePostImage() ;
                            }, icon:Icon(IconBroken.Close_Square)),),
                          ],
                        ) ,
                      Row(
                        children: [
                           Expanded(
                             child: TextButton(onPressed: (){
                              SocialLayoutCubit.get(context).getPostImage();
                             }, child: Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Icon(IconBroken.Image_2),
                                 Text('Add Photo') ,
                               ],
                             )
                             ),
                           ),
                           Expanded(
                            child: TextButton(onPressed: (){

                            }, child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(IconBroken.Bookmark),
                                Text('Add Tags') ,
                              ],
                            )),
                          ),
                        ],
                      ),

                    ],
                  ),

              ),
            ),
          ),
        );
      },
    );
  }

  Future<bool> removeText(context)async{
    SocialLayoutCubit.get(context).remove();
    SocialLayoutCubit.get(context).removePostImage();
    print('dah el text') ;
    print(SocialLayoutCubit.get(context).text);
    return  true ;
  }
}
