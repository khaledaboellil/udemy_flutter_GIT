import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/social_app/cubit/socialappstates.dart';
import 'package:todo_app/layout/social_app/socialhomescreen.dart';
import 'package:todo_app/shared/comapnents/companents.dart';
import 'package:todo_app/shared/styles/icon_broken.dart';

import '../../../layout/social_app/cubit/socialappcubit.dart';
import '../../../models/Social Register Model/SocialRegistermodel.dart';
import '../chats_screen/Socialchat.dart';

class SocialGroupSelect extends StatelessWidget {
  List<bool>value=[] ;
  String groupName='';
  var textController =TextEditingController();
  var formKey =GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Builder(

      builder: (context) {
        List<SocialUserModel> userModel=SocialLayoutCubit.get(context).allUserModel ;
        userModel.add(SocialLayoutCubit.get(context).model!);
        print(userModel.length);
        userModel.forEach((element) {
          value.add(false);
          print('wla');

        });
        print(value);

        return BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
            listener:(context,state){},
            builder: (context,state){
              return Scaffold(
                appBar: defaultAppBar(context: context,
                    title: 'Choose Member',
                    actions: [TextButton(onPressed: (){
                      print(value);
                      showDialog(context: context, builder: (context)=>AlertDialog(
                        title: Text('Group Name'),
                        content: Text('Please Enter Group name '),
                        actions: [
                          Row(
                            children: [
                              Expanded(
                                  child: TextFormField(
                                    controller: textController,
                                    validator: (value){
                                      if(value!.isEmpty)
                                      return"Please enter the group name ";
                                    },
                                    decoration: InputDecoration(
                                      labelText: "Group Name ",
                                      hintText: "Enter The Group name" ,
                                    ),
                                  )),
                              IconButton(onPressed: (){

                                groupName=textController.text ;
                                SocialLayoutCubit.get(context).addGroupChatMembers(groupName, userModel, value);
                                print(groupName);
                                if(formKey.currentState!.validate())
                               navigateTo(context, SocialHomeScreen());
                              }, icon: Icon(Icons.check))
                            ],
                          )
                        ],
                      ));
                      print('ana 5rgt');
                    }, child: Text('Create')),
                    SizedBox(width: 10,),
                    ]

                ),

                body: Form(
                  key:formKey ,
                  child: ListView.separated(
                      itemBuilder: (context,index)=>buildChatUsers(SocialLayoutCubit.get(context).allUserModel[index],context,index),
                      separatorBuilder:(context,index)=> myDivider(),
                      itemCount: SocialLayoutCubit.get(context).allUserModel.length),
                ),
              );
        },
        );
      }
    );
  }
  Widget buildChatUsers(SocialUserModel model,context,index)=>
      Padding(
        padding: const EdgeInsets.all( 20.0),
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
                    Expanded(child: Text(model.name,style: Theme.of(context).textTheme.bodyText1,)),
                   Checkbox(value: value[index], onChanged: (value){
                     this.value[index] = value! ;
                     SocialLayoutCubit.get(context).changeCheckBoxValue();
                   })
                  ]),
            ]
        ),
      );
}
