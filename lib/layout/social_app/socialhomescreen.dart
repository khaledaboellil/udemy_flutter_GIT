import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/social_app/cubit/socialappcubit.dart';
import 'package:todo_app/modules/social_app/NewPost_screen/newpost_screen.dart';
import 'package:todo_app/modules/social_app/Search_screen/SocialSearch.dart';
import 'package:todo_app/modules/social_app/notification_screen/SocialNotification.dart';
import 'package:todo_app/shared/comapnents/companents.dart';

import '../../shared/styles/icon_broken.dart';
import 'cubit/socialappstates.dart';

class SocialHomeScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return Builder(
      builder: (context) {
        var navCubit = SocialLayoutCubit.get(context) ;
        SocialLayoutCubit.get(context).getUserData();
        SocialLayoutCubit.get(context).getAllUsers();
        return BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
          listener: (context,state){
            if(state is SocialNewPostState)
              {
                navigateTo(context, SocialNewPost());
              }
          },
          builder: (context,state){
            return ConditionalBuilder(
                condition: SocialLayoutCubit.get(context).model!=null ,
                builder: (context){
                  return Scaffold(
                    appBar: AppBar(
                      title: Text(navCubit.titles[navCubit.screen_Index],style: TextStyle(
                        fontFamily: 'Jannah',
                      ),),
                      actions: [
                        IconButton(onPressed:(){
                          navigateTo(context,SocialNotification() );
                        }, icon: Icon(IconBroken.Notification)),
                        IconButton(onPressed:(){
                          navigateTo(context,SocialSearch() );
                        }, icon: Icon(IconBroken.Search))
                      ],
                    ),
                    body:navCubit.Screens[navCubit.screen_Index] ,
                    bottomNavigationBar: BottomNavigationBar(items:navCubit.socialNavBar,
                      currentIndex: navCubit.nav_Index,
                      onTap: (index){navCubit.changeSocialScreen(index) ;},
                    ),
                  );
                },
                fallback:(context)=>Center(child: CircularProgressIndicator()));
          },
        );
      }
    );
  }
}
// return  Column(
//   children: [
//
//     if(!model)
//     Container(
//       color: Colors.amber.withOpacity(.6),
//       child: Padding(
//          padding: const EdgeInsets.all(10.0),
//          child: Row(
//            children: [
//              Icon(Icons.info_outline) ,
//              SizedBox(width: 10,),
//              Text('please verify your email') ,
//              Spacer(),
//              defaultButton(function: (){
//                FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value){
//                  toastShow(msg: 'check your mail', state: toastStatus.SUCESS);
//                }).catchError((error){print(error.toString());}) ;
//              }, text: 'send',width: 100) ,
//            ],
//          ),
//        ),
//     ),
//   ],
// ) ;