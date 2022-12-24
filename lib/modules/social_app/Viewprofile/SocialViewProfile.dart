import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/models/Social%20Register%20Model/SocialRegistermodel.dart';
import 'package:todo_app/shared/comapnents/companents.dart';

import '../../../layout/social_app/cubit/socialappcubit.dart';
import '../../../layout/social_app/cubit/socialappstates.dart';

class SocialViewProfile extends StatelessWidget {
SocialUserModel userData ;
SocialViewProfile(this.userData);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
      listener: (context,state){

      },
      builder: (context,state){

        return Scaffold(
          appBar: defaultAppBar(context: context,
          title: userData.name,

          ),
          body: Padding(
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
                                image: DecorationImage(image: NetworkImage('${userData.coverImage}'),
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
                  SizedBox(height: 10,),
                  TextButton(onPressed: (){}, child: Text('Follow')),

                ],
              ),
            ),
          ),
        ) ;
      },
    );
  }
}