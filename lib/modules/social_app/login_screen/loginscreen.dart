import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/social_app/cubit/socialappcubit.dart';
import 'package:todo_app/layout/social_app/socialhomescreen.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/modules/social_app/Register_Screen/registerscreen.dart';
import 'package:todo_app/modules/social_app/login_screen/cubit/logincubit.dart';
import 'package:todo_app/modules/social_app/login_screen/cubit/loginstates.dart';
import 'package:todo_app/shared/network/locale/cache_helper.dart';

import '../../../shared/comapnents/companents.dart';

class SocialLoginScreen extends StatelessWidget {

  var formkey = GlobalKey<FormState>();
  var emailController = TextEditingController() ;
  var passwordController = TextEditingController() ;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>SocialLoginCubit(),

      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
        listener: (context,state){
          if(state is SocialLoginErrorState){
            toastShow(msg: state.error, state: toastStatus.ERROR);
          }
          if(state is SocialLoginSucessState)
          {
            toastShow(msg: 'account has successfully Logged in ', state: toastStatus.SUCESS) ;
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value){

              navigatePushAndDelete(context, SocialHomeScreen());

            }).catchError((error){
              print(error.toString()) ;
            });
          }
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Login',style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.black
                        ),),
                        Text('Login now and communictae with your friends',style:Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey
                        )),
                        SizedBox(height: 30,),
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

                            SocialLoginCubit.get(context).changeVisibilty() ;} ,
                          isPassword: SocialLoginCubit.get(context).isPassword,
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          label: 'password',
                          prefix: Icons.lock_outline,
                          suffix: SocialLoginCubit.get(context).suffix ,

                        ) ,
                        SizedBox(height:15) ,
                        ConditionalBuilder(condition: state is! SocialLoginLoadingState,
                            builder: (context)=>defaultButton(function: (){
                              if(formkey.currentState!.validate())
                              {
                                SocialLoginCubit.get(context).userLogin(email: emailController.text, password: passwordController.text) ;
                              }
                            }, text: 'Login'), fallback: (context)=>Center(child:CircularProgressIndicator())) ,

                        SizedBox(height:15) ,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?'),
                            TextButton(onPressed: (){
                              navigateTo(context, SocialRegisterScreen()) ;
                            }, child: Text('Register'))
                          ],)

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
