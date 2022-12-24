abstract class SocialLoginStates {}
class SocialLoginLoadingState extends SocialLoginStates {}
class SocialLoginSucessState extends SocialLoginStates {
  String uId ;
  SocialLoginSucessState(this.uId) ;
}
class SocialLoginErrorState extends SocialLoginStates {
  late final String error ;
  SocialLoginErrorState(this.error) ;
}

class SocialLoginChangeVisbility extends SocialLoginStates {}
class SocialLoginInitialState extends SocialLoginStates {}
