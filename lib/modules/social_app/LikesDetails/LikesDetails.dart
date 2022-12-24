import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/social_app/cubit/socialappcubit.dart';
import '../../../layout/social_app/cubit/socialappstates.dart';
import '../../../models/Social Register Model/SocialRegistermodel.dart';
import '../../../shared/comapnents/companents.dart';
import '../Viewprofile/SocialViewProfile.dart';

class SocialLikeDetails extends StatelessWidget {
  String postId ;
  SocialLikeDetails(this.postId);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialLayoutCubit.get(context).getWhoLike(postId);
        print(SocialLayoutCubit.get(context).whoLiked.length);
        return BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
          listener: (context,state){},
          builder: (context,state){
            return Scaffold(
              appBar: defaultAppBar(context: context,
              title: 'Likes',
              ),
              body:ListView.separated(
                  itemBuilder: (context,index)=>buildChatUsers(SocialLayoutCubit.get(context).whoLiked[index],context),
                  separatorBuilder:(context,index)=> myDivider(),
                  itemCount: SocialLayoutCubit.get(context).whoLiked.length),

            );
          },
        );
      }
    );
  }
  Widget buildChatUsers(SocialUserModel model,context)=>
      InkWell(
        onTap: () {
          navigateTo(context, SocialViewProfile(model));
        },

        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                children: [
                  Row(
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
                ]
            )
        ),
      );
}
