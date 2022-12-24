import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/social_app/cubit/socialappcubit.dart';
import 'package:todo_app/layout/social_app/cubit/socialappstates.dart';
import 'package:todo_app/modules/social_app/Edit_screen/SocialEditing.dart';
import 'package:todo_app/modules/social_app/login_screen/loginscreen.dart';
import 'package:todo_app/shared/comapnents/companents.dart';
import 'package:todo_app/shared/comapnents/constans.dart';
import 'package:todo_app/shared/network/locale/cache_helper.dart';

import '../../../shared/styles/icon_broken.dart';

class SocialSettings extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
        listener: (context,state){

        },
      builder: (context,state){
        var userData = SocialLayoutCubit.get(context).model ;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                  children: [
                    Container(
                      height: 190,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: 140,
                              width: double.infinity,
                              decoration:BoxDecoration(
                                image: DecorationImage(image: NetworkImage('${userData!.coverImage}'),
                                fit: BoxFit.cover,
                                ),
                                borderRadius:BorderRadius.only(
                                    topLeft:Radius.circular(4),
                                    topRight: Radius.zero ,
                                )
                              ),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                            radius: 64,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage('${userData.image}'),
                              radius: 60,
                            ),

                          ),
                        ],
                      ),
                    ),
                    Text('${userData.name}',style:Theme.of(context).textTheme.bodyText1,),
                    Text('${userData.bio}',style:Theme.of(context).textTheme.caption,),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: (){},
                              child: Column(
                                children: [
                                  Text('100',
                                    style:Theme.of(context).textTheme.subtitle1!.copyWith(
                                      height: 1.3
                                    ),),
                                  Text('posts',
                                    style:Theme.of(context).textTheme.caption!.copyWith(
                                      height: 1.3
                                    ),),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: (){},
                              child: Column(
                                children: [
                                  Text('100',
                                    style:Theme.of(context).textTheme.subtitle1!.copyWith(
                                        height: 1.3
                                    ),),
                                  Text('Followers',
                                    style:Theme.of(context).textTheme.caption!.copyWith(
                                        height: 1.3
                                    ),),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: (){},
                              child: Column(
                                children: [
                                  Text('100',
                                    style:Theme.of(context).textTheme.subtitle1!.copyWith(
                                        height: 1.3
                                    ),),
                                  Text('Followings',
                                    style:Theme.of(context).textTheme.caption!.copyWith(
                                        height: 1.3
                                    ),),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: (){},
                              child: Column(
                                children: [
                                  Text('100',
                                    style:Theme.of(context).textTheme.subtitle1!.copyWith(
                                        height: 1.3
                                    ),),
                                  Text('likes',
                                    style:Theme.of(context).textTheme.caption!.copyWith(
                                        height: 1.3
                                    ),),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(onPressed: (){}, child: Text('Add photo')),
                        SizedBox(width: 10,),
                        OutlinedButton(onPressed: (){
                          navigateTo(context, SocialEditProfile());
                        }, child:Icon(IconBroken.Edit)),
                      ],
                    ),
                    SizedBox(height: 100,),
                    OutlinedButton(
                    onPressed: () {
                      CacheHelper.removeData(key: 'uId').then((value) {
                        print(value.toString());
                        print(CacheHelper.loadStringData(key: 'uId'));
                        navigatePushAndDelete(context, SocialLoginScreen());
                      }).catchError((error) {
                        print(error.toString());
                      });
                    },
                    child: Text(
                      "Signout",
                    )),
              ],
              ),
            ),
          ) ;
      },
    );
  }
}
