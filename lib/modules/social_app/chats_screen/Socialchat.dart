import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/social_app/cubit/socialappstates.dart';
import 'package:todo_app/models/Social%20Register%20Model/SocialRegistermodel.dart';
import 'package:todo_app/modules/social_app/GroupDetailsScreen/GroupDetails.dart';
import 'package:todo_app/modules/social_app/GroupSelected/GroupSelected.dart';
import 'package:todo_app/shared/comapnents/companents.dart';
import 'package:todo_app/shared/styles/icon_broken.dart';

import '../../../layout/social_app/cubit/socialappcubit.dart';
import '../Chatdetails_Screen/SocialChatDetails.dart';

class SocialChats extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialUserModel model = SocialLayoutCubit.get(context).model! ;

        return BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
          listener: (context,state){},
          builder: (context,state){
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                    Text('Add agroup',style: Theme.of(context).textTheme.bodyText1,),
                    Spacer(),
                    IconButton(onPressed: (){
                      navigateTo(context, SocialGroupSelect());
                    }, icon: Icon(IconBroken.User1)),
                  ],),
                  if(SocialLayoutCubit.get(context).groupUId[model.uId]!=null)
                  Expanded(
                    child: Container(
                      child: ListView.separated(
                          itemBuilder: (context,index)=>buildGroups(SocialLayoutCubit.get(context).groupUId[model.uId]![index],context),
                          separatorBuilder:(context,index)=> myDivider(),
                          itemCount: SocialLayoutCubit.get(context).groupUId[model.uId]!.length),
                    ),
                  ),
                  if(SocialLayoutCubit.get(context).groupUId.isEmpty)
                    Text('No groups yet',style: Theme.of(context).textTheme.caption,) ,
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical:5),
                    child: Container(height: 1,
                      width: double.infinity,
                      color: Colors.grey[300],
                    ),
                  ),
                  Text('Users',style: Theme.of(context).textTheme.caption,) ,
                  Expanded(
                    child: Container(
                      child: ListView.separated(
                          itemBuilder: (context,index)=>buildChatUsers(SocialLayoutCubit.get(context).allUserModel[index],context),
                          separatorBuilder:(context,index)=> myDivider(),
                          itemCount: SocialLayoutCubit.get(context).allUserModel.length),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }
    );
  }
  Widget buildChatUsers(SocialUserModel model,context)=>
      InkWell(
        onTap: () {
          navigateTo(context, SocialChatDetails(model));
        },

        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
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
          ),
        ),
      );

  Widget buildGroups(String groupName,context)=>
      InkWell(
        onTap: () {
          navigateTo(context, SocialGroupDetails(groupName));
        },

        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
              children: [
                Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage('https://i.pinimg.com/originals/3d/ac/3e/3dac3edc8faea23f056035fe9455ec3d.jpg'),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(groupName),
                    ]),
              ]
          ),
        ),
      );
}