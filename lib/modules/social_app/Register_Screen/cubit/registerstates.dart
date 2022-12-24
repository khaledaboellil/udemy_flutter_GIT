abstract class SocialRegisterStates{}


class SocialRegisterInitialState extends SocialRegisterStates {}

class SocialRegisterChangePass extends SocialRegisterStates{}
class SocialRegisterLoadingState extends SocialRegisterStates {}


class SocialRegisterSuccessState extends SocialRegisterStates {}
class SocialRegisterErrorState extends SocialRegisterStates {
  String error ;
  SocialRegisterErrorState(this.error);
}

class SocialUserSuccessState extends SocialRegisterStates {}
class SocialUserErrorState extends SocialRegisterStates {
  String error ;
  SocialUserErrorState(this.error);
}