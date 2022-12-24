import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/modules/social_app/Viewprofile/SocialViewProfile.dart';

import '../../../layout/social_app/cubit/socialappcubit.dart';
import '../../../layout/social_app/cubit/socialappstates.dart';
import '../../../models/Social Register Model/SocialRegistermodel.dart';
import '../../../shared/comapnents/companents.dart';

class SocialUsers extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
      listener: (context,state){},
      builder: (context,state){
        return ListView.separated(
            itemBuilder: (context,index)=>buildChatUsers(SocialLayoutCubit.get(context).allUserModel[index],context),
            separatorBuilder:(context,index)=> myDivider(),
            itemCount: SocialLayoutCubit.get(context).allUserModel.length);
      },
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