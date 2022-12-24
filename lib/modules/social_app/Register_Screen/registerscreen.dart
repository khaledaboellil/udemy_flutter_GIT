import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/social_app/socialhomescreen.dart';
import 'package:todo_app/modules/social_app/login_screen/cubit/loginstates.dart';
import 'package:todo_app/modules/social_app/login_screen/loginscreen.dart';

import '../../../shared/comapnents/companents.dart';
import 'cubit/registercubit.dart';
import 'cubit/registerstates.dart';

class SocialRegisterScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var emailController = TextEditingController() ;
  var passwordController = TextEditingController() ;
  var phoneController=TextEditingController();
  var nameController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>SocialRegisterCubit(),

      child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
        listener: (context,state){
          if(state is SocialRegisterErrorState){
            toastShow(msg: state.error, state: toastStatus.ERROR);
          }
          if(state is SocialUserSuccessState)
            {
              toastShow(msg: 'account has successfully Registered please Login in  ', state: toastStatus.SUCESS) ;
              navigatePushAndDelete(context, SocialLoginScreen());
            }

        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.black,
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Register',style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.black
                        ),),
                        Text('Register to Communicate with your Friends',style:Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey
                        )),
                        SizedBox(height: 30,),
                        defaultTextForm(
                            validate: (String? value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'please enter your username';
                              }
                            },
                            controller: nameController,
                            type: TextInputType.name, label: 'UserName', prefix: Icons.drive_file_rename_outline) ,
                        SizedBox(height: 15),
                        defaultTextForm(
                            validate: (String? value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'please enter your email address';
                              }
                            },
                            controller: emailController,
                            type: TextInputType.emailAddress, label: 'Email', prefix: Icons.email) ,
                        SizedBox(height: 15),
                        defaultTextForm(validate: (String? value){
                          if(value!.isEmpty)
                          {
                            return 'password is too short';
                          }

                        },
                          visblepass: (){

                            SocialRegisterCubit.get(context).changeVisibilty() ;} ,
                          isPassword: SocialRegisterCubit.get(context).isPassword,
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          label: 'password',
                          prefix: Icons.lock_outline,
                          suffix: SocialRegisterCubit.get(context).suffix ,

                        ) ,
                        SizedBox(height:15) ,
                        defaultTextForm(
                            validate: (String? value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'please enter your PhoneNumber';
                              }
                            },
                            controller: phoneController,
                            type: TextInputType.phone, label: 'Phonenumber', prefix: Icons.email) ,
                        SizedBox(height: 15),
                        ConditionalBuilder(condition: state is! SocialRegisterLoadingState,
                            builder: (context)=>defaultButton(function: (){
                              if(formkey.currentState!.validate())
                              {
                                SocialRegisterCubit.get(context).registerUser(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone:phoneController.text,
                                  name: nameController.text ,

                                ) ;
                              }
                            }, text: 'Register'), fallback: (context)=>Center(child:CircularProgressIndicator())) ,


                      ],
                    ),
                  ),
                ),
              ),
            ),


          ) ;
        },
      ),
    );
  }
}
