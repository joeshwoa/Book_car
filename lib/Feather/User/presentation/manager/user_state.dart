

abstract class UserState {}

class AppInitialState extends UserState {}
class AnyUserState extends UserState {}
class UpdateLungState extends UserState {}

class LoadingLoginState extends UserState {}
class SuccessLoginState extends UserState {
  String ? msg;
  SuccessLoginState({this.msg});
}
class FailLoginState extends UserState {}
class ErrorLoginState extends UserState {}

class LoadingLoginGuestState extends UserState {}
class SuccessLoginGuestState extends UserState {
  String ? msg;
  SuccessLoginGuestState({this.msg});
}
class FailLoginGuestState extends UserState {}
class FailLoginGuestUserExistsState extends UserState {}
class ErrorLoginGuestState extends UserState {}

class LoadingGetDataState extends UserState {}
class SuccessGetDataState extends UserState {}
class ErrorGetDataState extends UserState {}

class LoadingForgetMailState extends UserState {}
class SuccessForgetMailState extends UserState {
  String ? msg;
  SuccessForgetMailState({this.msg});
}
class FailForgetMailState extends UserState {}
class ErrorForgetMailState extends UserState {}

class LoadingSignUpState extends UserState {}
class SuccessSignUpState extends UserState {}
class FailSignUpState extends UserState {
  String? msg;
  FailSignUpState({this.msg});
}
class ErrorSignUpState extends UserState {}

class LoadingSocialModelState extends UserState {}
class SuccessSocialModelState extends UserState {}
class ErrorSocialModelState extends UserState {}

class LoadingDeleteAccountState extends UserState {}
class SuccessDeleteAccountState extends UserState {}
class ErrorDeleteAccountState extends UserState {}

class LoadingEditProfileState extends UserState {}
class SuccessEditProfileState extends UserState {}
class FailEditProfileState extends UserState {}
class ErrorEditProfileState extends UserState {}

class LoadingChangePasswordState extends UserState {}
class SuccessChangePasswordState extends UserState {}
class FailChangePasswordState extends UserState {
  String ? msg;
  FailChangePasswordState({this.msg});
}
class ErrorChangePasswordState extends UserState {}

class LoadingGetPlacesState extends UserState {}
class SuccessGetPlacesState extends UserState {}
class ErrorGetPlacesState extends UserState {}

class LoadingEditPlacesState extends UserState {}
class SuccessEditPlacesState extends UserState {
  String ? msg;
  SuccessEditPlacesState({this.msg});
}
class ErrorEditPlacesState extends UserState {}

class LoadingSavePlacesState extends UserState {}
class SuccessSavePlacesState extends UserState {
  String ? msg;
  SuccessSavePlacesState({this.msg});
}
class ErrorSavePlacesState extends UserState {}

class LoadingSendMessageState extends UserState {}
class SuccessSendMessageState extends UserState {}
class ErrorSendMessageState extends UserState {}

class LoadingSendReportState extends UserState {}
class SuccessSendReportState extends UserState {}
class ErrorSendReportState extends UserState {}

class LoadingGetTermState extends UserState {}
class SuccessGetTermState extends UserState {}
class ErrorGetTermState extends UserState {}