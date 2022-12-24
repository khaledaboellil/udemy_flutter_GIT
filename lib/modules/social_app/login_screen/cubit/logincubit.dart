import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/modules/social_app/login_screen/cubit/loginstates.dart';
import 'package:todo_app/shared/comapnents/constans.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates>{
  SocialLoginCubit() : super(SocialLoginInitialState());
  static SocialLoginCubit get(context)=> BlocProvider.of(context) ;


  void userLogin(
      {
        required String email ,
        required String password,
      }
      ){
    emit(SocialLoginLoadingState()) ;
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email.trim(), password: password).then(
            (value){
              print(value.user!.emailVerified) ;
              uID=value.user!.uid;
              emit(SocialLoginSucessState(value.user!.uid));

            }).catchError((e){
              print(e.toString());
             emit(SocialLoginErrorState(e.toString()));
          });
  }
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changeVisibilty(){

    isPassword = ! isPassword ;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;

    emit(SocialLoginChangeVisbility());
  }
}