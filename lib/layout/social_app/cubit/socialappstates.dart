class SocialLayoutStates{

}

class SocialLayoutInitialStates extends SocialLayoutStates {}

class SocialGetUserLoadingStates extends SocialLayoutStates{}

class SocialGetUserSucessfullStates extends SocialLayoutStates{}

class SocialGetUserErrorStates extends SocialLayoutStates{
  String error ;
  SocialGetUserErrorStates(this.error) ;
}

class SocialChangeNavBar extends SocialLayoutStates{}
class SocialChangePopUpMenu extends SocialLayoutStates{}
class SocialNewPostState extends SocialLayoutStates{}

class ProfileInitialState extends SocialLayoutStates{}

class UpdateProfileImageLoadingState extends SocialLayoutStates{}
class UpdateProfileImageSucessState extends SocialLayoutStates{}
class UpdateProfileImageErrorState extends SocialLayoutStates{}

class UpdateCoverImageLoadingState extends SocialLayoutStates{}
class UpdateCoverImageSucessState extends SocialLayoutStates{}
class UpdateCoverImageErrorState extends SocialLayoutStates{}

class UpdateProfileDataLoadingStates extends SocialLayoutStates{}


class UpdateProfileDataErrorStates extends SocialLayoutStates{}

class AddPostPhotoLoadingState extends SocialLayoutStates{}
class AddPostPhotoSucessState extends SocialLayoutStates{}
class AddPostPhotoErrorState extends SocialLayoutStates{}

class ChangePostButtonColor extends SocialLayoutStates{}

class UploadPostPhotoLoadingState extends SocialLayoutStates{}
class UploadPostPhotoSucessState extends SocialLayoutStates{}
class UploadPostPhotoErrorState extends SocialLayoutStates{}


class RemovePostPhotoState extends SocialLayoutStates{}

class SocialGetPostLoadingStates extends SocialLayoutStates{}

class SocialGetPostSucessfullStates extends SocialLayoutStates{}

class SocialGetPostErrorStates extends SocialLayoutStates{
  String error ;
  SocialGetPostErrorStates(this.error) ;
}
class AddLikeSucessState extends SocialLayoutStates{}
class AddLikeErrorState extends SocialLayoutStates{}

class AddCommentSucessState extends SocialLayoutStates{}
class AddCommentErrorState extends SocialLayoutStates{}

class GetCommentLoadingState extends SocialLayoutStates{}
class GetCommentSucessState extends SocialLayoutStates{}
class GetCommentErrorState extends SocialLayoutStates{}

class GetLikeLoadingState extends SocialLayoutStates{}
class GetLikeSucessState extends SocialLayoutStates{}
class GetLikeErrorState extends SocialLayoutStates{}

class GetCommentNumSucessState extends SocialLayoutStates{}
class GetCommentNumErrorState extends SocialLayoutStates{}

class SocialGetAllUserLoadingStates extends SocialLayoutStates{}

class SocialGetAllUserSucessfullStates extends SocialLayoutStates{}

class SocialGetAllUserErrorStates extends SocialLayoutStates{
  String error ;
  SocialGetAllUserErrorStates(this.error) ;
}

class SendMessageSucessState extends SocialLayoutStates{}
class SendMessageErrorState extends SocialLayoutStates{}


class GetMessageSucessState extends SocialLayoutStates{}
class GetMessageErrorState extends SocialLayoutStates{}
class AddChatPhotoLoadingState extends SocialLayoutStates{}
class AddChatPhotoSucessState extends SocialLayoutStates{}
class AddChatPhotoErrorState extends SocialLayoutStates{}

class ChangeLikeAndDislikeState extends SocialLayoutStates{}


class RemoveLikeSucessState extends SocialLayoutStates{}
class RemoveLikeErrorState extends SocialLayoutStates{}


class RemovePostSucessState extends SocialLayoutStates{}
class RemovePostErrorState extends SocialLayoutStates{}

class EditPostSucessState extends SocialLayoutStates{}
class EditPostErrorState extends SocialLayoutStates{}

class UpdateAllPostsLoadingState extends SocialLayoutStates{}
class UpdateAllPostsSucessState extends SocialLayoutStates{}
class UpdateAllPostsErrorState extends SocialLayoutStates{}


class UpdateAllCommentsLoadingState extends SocialLayoutStates{}
class UpdateAllCommentsSucessState extends SocialLayoutStates{}
class UpdateAllCommentsErrorState extends SocialLayoutStates{}

class GetWhoLikedLoadingState extends SocialLayoutStates{}
class GetWhoLikedSucessState extends SocialLayoutStates{}


class ChangeCheckBoxState extends SocialLayoutStates{}
class AddGroupLoadingState extends SocialLayoutStates{}
class AddGroupSucessState extends SocialLayoutStates{}
class AddGroupErrorState extends SocialLayoutStates{}

class GetGroupLoadingState extends SocialLayoutStates{}
class GetGroupSucessState extends SocialLayoutStates{}
class GetGroupErrorState extends SocialLayoutStates{}

class SendGroupMessageSucessState extends SocialLayoutStates{}
class SendGroupMessageErrorState extends SocialLayoutStates{}


class GetGroupMessageSucessState extends SocialLayoutStates{}
class GetGroupMessageErrorState extends SocialLayoutStates{}