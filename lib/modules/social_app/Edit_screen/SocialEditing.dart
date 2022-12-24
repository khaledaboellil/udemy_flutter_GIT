
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/social_app/cubit/socialappcubit.dart';
import 'package:todo_app/layout/social_app/cubit/socialappstates.dart';
import 'package:todo_app/modules/social_app/settings/socialsettings.dart';
import 'package:todo_app/shared/styles/icon_broken.dart';

import '../../../shared/comapnents/companents.dart';

class SocialEditProfile extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var userData = SocialLayoutCubit.get(context).model ;

    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var bioController = TextEditingController();
    var formKey =GlobalKey<FormState>() ;

    return BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
      listener: (context,state){

        if(state is UpdateAllPostsSucessState)
          {
            Navigator.pop(context);
          }
      },
      builder: (context,state){
        var image=SocialLayoutCubit.get(context).profileImage ;
        var coverImage=SocialLayoutCubit.get(context).coverImage ;
        nameController.text=SocialLayoutCubit.get(context).model!.name ;
        phoneController.text=SocialLayoutCubit.get(context).model!.phone ;
        bioController.text=SocialLayoutCubit.get(context).model!.bio ;
        return Scaffold(
          appBar: defaultAppBar(context: context,
              title: 'Edit Profile',
              actions:[
                ConditionalBuilder(
              condition: state is! UpdateProfileImageLoadingState && state is! UpdateCoverImageLoadingState ,
              builder: (context)=> IconButton(
                  onPressed: () {

                    if (coverImage == null && image == null) {
                      SocialLayoutCubit.get(context).updateProfile(
                          name: nameController.text,
                          phone: phoneController.text,
                          bio: bioController.text);
                    }
                    else if (coverImage != null && image != null) {

                      SocialLayoutCubit.get(context).updateProfile(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text,
                        cover: SocialLayoutCubit.get(context).coverImageUrl,
                        profileImage: SocialLayoutCubit.get(context).profileImageUrl,
                      );
                    }
                    else if (image == null) {
                      SocialLayoutCubit.get(context).updateProfile(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text,
                        cover: SocialLayoutCubit.get(context).coverImageUrl,
                      );
                    }
                    else{
                      print('Ento btl3boooo');
                      SocialLayoutCubit.get(context).updateProfile(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text,
                        profileImage: SocialLayoutCubit.get(context).profileImageUrl,
                      );
                    }

                  }, icon:Icon(Icons.check)),
              fallback: (context)=> Center(child: CircularProgressIndicator()),),

                SizedBox(width: 20,)
              ]),

          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(

                  children: [
                    if(state is UpdateProfileDataLoadingStates||state is UpdateCoverImageLoadingState)
                    LinearProgressIndicator(),
                    SizedBox(height: 10,),
                    Container(
                      height: 190,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [

                                Container(
                                  height: 140,
                                  width: double.infinity,
                                  decoration:BoxDecoration(
                                      image: DecorationImage(image:coverImage ==null ?
                                      NetworkImage('${userData!.coverImage}') : FileImage(coverImage) as ImageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius:BorderRadius.only(
                                        topLeft:Radius.circular(4),
                                        topRight: Radius.zero ,
                                      )
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.grey[300],
                                  radius: 20,
                                  child: IconButton(
                                    onPressed: (){
                                      SocialLayoutCubit.get(context).getCoverImage();
                                    },icon:Icon(IconBroken.Camera),color: Colors.black,),
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                radius: 64,
                                child: CircleAvatar(
                                  backgroundImage:image==null ?
                                  NetworkImage('${userData!.image}'):FileImage(image) as ImageProvider,
                                  radius: 60,
                                ),

                              ),
                              CircleAvatar(
                                backgroundColor: Colors.grey[300],
                                radius: 20,
                                child: IconButton(
                                  onPressed: (){
                                    SocialLayoutCubit.get(context).getImage();
                                  },icon:Icon(IconBroken.Camera),color: Colors.black,),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    defaultTextForm(

                        validate: (String ?value){
                          if(value!.isEmpty)
                            {
                              "please Enter your name " ;
                            }
                        },
                        controller: nameController,
                        type: TextInputType.text,
                        label: 'Name',
                        prefix: IconBroken.User),


                    SizedBox(height: 10,),
                    defaultTextForm(
                        validate: (String ?value){
                          if(value!.isEmpty)
                          {
                            "please Enter your phone " ;
                          }
                        },
                        controller: phoneController,
                        type: TextInputType.text,
                        label: 'phone',
                        prefix: IconBroken.Call),
                    SizedBox(height: 10,),
                    defaultTextForm(
                        validate: (String ?value){
                          if(value!.isEmpty)
                          {
                            "please Enter your bio " ;
                          }
                        },
                        controller: bioController,
                        type: TextInputType.text,
                        label: 'bio',
                        prefix: IconBroken.Edit_Square),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
