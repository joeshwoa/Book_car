
import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:public_app/Core/api/constant_api.dart';
import 'package:public_app/Core/services/shared_pref_services.dart';
import 'package:public_app/Core/unit/constant_data.dart';
import 'package:public_app/Feather/User/data/model/places_model.dart';
import 'package:public_app/Feather/User/data/model/social_model.dart';
import 'package:public_app/Feather/User/data/model/term_model.dart';
import 'package:public_app/Feather/User/data/model/user_model.dart';
import 'package:public_app/Feather/User/data/repository/user_repository.dart';
import 'package:public_app/Feather/User/presentation/manager/user_state.dart';
import 'package:http/http.dart' as http;

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(AppInitialState());

  static UserCubit get(context) => BlocProvider.of(context);


  void updateLung({required String lung,required BuildContext context}){
    context.setLocale( Locale(lung));
    SharedPreferencesServices.setData(key: ConstantData.kLung,value:  lung);
    emit(UpdateLungState());
  }

  int currentIndexLayout = 0;
  void changeCurrentIndexLayout(int index){
    currentIndexLayout = index;
    emit(AnyUserState());
  }

  void restartState(){
    emit(AnyUserState());
  }

  bool isUserLogin=false;
  void checkIsLogin({bool ? val}){
    isUserLogin = val??SharedPreferencesServices.getData(key: ConstantData.kLogin)??false;
    if(isUserLogin){
      getDataUser();
    }else{
      userModel = null;
    }
    emit(AnyUserState());
  }

  bool showPasswordLogin = true;
  changeShowPasswordLogin() {
    showPasswordLogin = !showPasswordLogin;
    emit(AnyUserState());
  }
  bool showConfirmPassword = true;
  changeShowConfirmPassword() {
    showConfirmPassword = !showConfirmPassword;
    emit(AnyUserState());
  }

  void login({required String email , required String password}){
    emit(LoadingLoginState());
    Map<String , dynamic> body={
      'email':email,
      'password':password,
    };
    UserRepository.login(body: body).then((value){
      print(value);
      if((value['status']??'') == 'success'){
        SharedPreferencesServices.setData(key: ConstantData.kLogin, value: true);
        SharedPreferencesServices.setData(key: ConstantData.kToken, value: value['token']??'');
        SharedPreferencesServices.setData(key: ConstantData.kEmail, value: email);
        debugPrint('Success Login');
        emit(SuccessLoginState(msg: value['message']??''));
        checkIsLogin();
      }else{
        debugPrint('Fail Login');
        emit(FailLoginState());
      }
    }).onError((error, stackTrace){
      debugPrint('Error Login ${error.toString()}');
      emit(ErrorGetDataState());
    });
  }

  void loginGuest({required String email , required String name, required String phone}){
    emit(LoadingLoginGuestState());
    Map<String , dynamic> body={
      'email':email,
      'name':name,
      'phone':phone,
    };
    UserRepository.login(body: body).then((value){
      if((value['status']??'') == 'success'){
        SharedPreferencesServices.setData(key: ConstantData.kLogin, value: true);
        SharedPreferencesServices.setData(key: ConstantData.kToken, value: value['token']??'');
        SharedPreferencesServices.setData(key: ConstantData.kEmail, value: email);
        debugPrint('Success Guest Login');
        emit(SuccessLoginGuestState(msg: value['message']??''));
        checkIsLogin();
      }else{
        if(value['message'] == 'User already exists') {
          debugPrint('Fail Guest Login => User already exists');
          emit(FailLoginGuestState());
        } else {
          debugPrint('Fail Guest Login');
          emit(FailLoginGuestState());
        }
      }
    }).onError((error, stackTrace){
      debugPrint('Error Guest Login ${error.toString()}');
      emit(ErrorGetDataState());
    });
  }

  UserModel ? userModel ;
  void getDataUser(){
    emit(LoadingGetDataState());
    userModel = null;
    UserRepository.getDateUser().then((value){
      debugPrint('Success Get Data');
      userModel = value;
      emit(SuccessGetDataState());
    }).onError((error, stackTrace){
      debugPrint('Error Get Data ${error.toString()}');
      emit(ErrorGetDataState());
    });
  }

  String valCodeCountry='33';
  void changeValCodeCountry(val){
    valCodeCountry=val;
    emit(AnyUserState());
  }

  void logout(){
    SharedPreferencesServices.removeData(key: ConstantData.kToken);
    SharedPreferencesServices.removeData(key: ConstantData.kLogin);
    SharedPreferencesServices.removeData(key: ConstantData.kRefresh);
    emit(AnyUserState());
    checkIsLogin(val: false);
  }

  void forgetMail({required String phone}){
    emit(LoadingForgetMailState());
    Map<String , dynamic> body={
      'phone':'+$valCodeCountry $phone',
    };
    UserRepository.forgetMail(body: body).then((value){
      if((value['status']??'') == 'success'){
        debugPrint('Success Forget Mail');
        emit(SuccessForgetMailState(msg: value['data']??''));
      }else{
        debugPrint('Fail Forget Mail');
        emit(FailForgetMailState());
      }
    }).onError((error, stackTrace){
      debugPrint('Error Forget Mail ${error.toString()}');
      emit(ErrorForgetMailState());
    });
  }

  void resetPasswordLink({required String phone}){
    emit(LoadingForgetMailState());
    Map<String , dynamic> body={
      'phone':'+$valCodeCountry $phone',
    };
    UserRepository.forgetPassword(body: body).then((value){
      if((value['status']??'') == 'success'){
        debugPrint('Success Forget Password');
        emit(SuccessForgetMailState(msg: value['email']??''));
      }else{
        debugPrint('Fail Forget Password');
        emit(FailForgetMailState());
      }
    }).onError((error, stackTrace){
      debugPrint('Error Forget Password ${error.toString()}');
      emit(ErrorForgetMailState());
    });
  }

  void signUp({required String name,required String email , required String phone , required String password}){
    emit(LoadingSignUpState());
    Map<String , dynamic> body={
      'phone':'+$valCodeCountry $phone',
      'name':name,
      'email':email,
      'password': password,
    };
    UserRepository.signUp(body: body).then((value){
      if((value['status']??'') == 'success'){
        debugPrint('Success message');
        emit(SuccessSignUpState());
      }else{
        debugPrint('Fail Sign Up');
        emit(FailSignUpState(msg: value['message']??''));
      }
    }).onError((error, stackTrace){
      debugPrint('Error Sign Up ${error.toString()}');
      emit(ErrorSignUpState());
    });
  }

  List<SocialModel> listSocial=[];
  void getSocial(){
    if(listSocial.isEmpty){
      emit(LoadingSocialModelState());
      UserRepository.getSocialModel().then((value){
        debugPrint('Success Get Social');
        listSocial = value;
        emit(SuccessSocialModelState());
      }).onError((error, stackTrace){
        debugPrint('Error Get Social ${error.toString()}');
        emit(ErrorSocialModelState());
      });
    }
  }

  void deleteAccount(){
    emit(LoadingDeleteAccountState());
    UserRepository.deleteAccount().then((value){
      if((value['status']??'') == 'success'){
        debugPrint('Success Delete Account');
        emit(SuccessDeleteAccountState());
      }else{
        debugPrint('Error Delete Account');
        emit(ErrorDeleteAccountState());
      }
    }).onError((error, stackTrace){
      debugPrint('Error Delete Account ${error.toString()}');
      emit(ErrorDeleteAccountState());
    });
  }

  File ? fileImage;
  void selectFileImage(File file){
    fileImage= file;
    emit(AnyUserState());
  }

  void editProfile({required String name, required String phone,required String email}) async {
    emit(LoadingEditProfileState());
    String token = await SharedPreferencesServices.getData(key: ConstantData.kToken)??'';
    var request = http.MultipartRequest('PATCH', Uri.https(ConstantApi.nameDomain,'${ConstantApi.endPoint}users/update/',),);
    request.headers.addAll({
      'Accept':'application/json',
      'Content-Type':'application/json',
      'token':token
    });

    if(fileImage!=null){
      request.files.add(await http.MultipartFile.fromPath(
        'file',
        fileImage!.path,
      ));
    }

    request.fields['name'] = name;
    request.fields['phone'] = phone;
    request.fields['email'] = email;

    var res = await request.send();
    var response = await http.Response.fromStream(res);
    print(response.body);
    var resData = json.decode(response.body);

    debugPrint(request.fields.toString());
    debugPrint(response.body);

    debugPrint(resData.toString());
    if(response.statusCode == 200  || response.statusCode ==201){
      debugPrint('Success Edit Profile');
      emit(SuccessEditProfileState());
      getDataUser();
    }else {
      emit(ErrorEditProfileState());
      debugPrint('Error Edit Profile');
    }
  }

  void changePassword({required String oldPassword,required String newPassword ,}){
    emit(LoadingChangePasswordState());
    Map<String , dynamic> body={
      "oldPassword":oldPassword,
      "newPassword":newPassword,
      "reNewPassword":newPassword
    };
    UserRepository.changePassword(body: body).then((value){
      if((value['status']??'') == 'success'){
        debugPrint('Success Change Password');
        emit(SuccessChangePasswordState());
      }else{
        debugPrint('Fail Change Password');
        emit(FailChangePasswordState(msg: value['message']??''));
      }
    }).onError((error, stackTrace){
      debugPrint('Error Change Password ${error.toString()}');
      emit(ErrorChangePasswordState());
    });
  }

  List<PlacesModel> listPlaces=[];
  void getPlaces(){
      emit(LoadingGetPlacesState());
      listPlaces = [];
      UserRepository.getPlaces().then((value){
        debugPrint('Success Get Places');
        listPlaces = value;
        emit(SuccessGetPlacesState());
      }).onError((error, stackTrace){
        debugPrint('Error Get Places ${error.toString()}');
        emit(ErrorGetPlacesState());
      });
  }

  void changePlace({required String title,required String address,required String id}){
    emit(LoadingEditPlacesState());
    Map<String , dynamic> body={
      "title":title,
      "address":address
    };
    UserRepository.changePlaces(body: body,id: id).then((value){
      if((value['status']??'') == 'success'){
        debugPrint('Success Edit Places');
        emit(SuccessEditPlacesState());
      }else{
        debugPrint('Error Edit Places');
        emit(ErrorEditPlacesState());
      }
    }).onError((error, stackTrace){
      debugPrint('Error Edit Places ${error.toString()}');
      emit(ErrorEditPlacesState());
    });
  }

  void savePlace({required String title,required String address,}){
    emit(LoadingSavePlacesState());
    Map<String , dynamic> body={
      "title":title,
      "address":address
    };
    UserRepository.savePlaces(body: body).then((value){
      if((value['status']??'') == 'success'){
        debugPrint('Success Save Places');
        emit(SuccessSavePlacesState(msg: value['message']??''));
      }else{
        debugPrint('Error Save Places');
        emit(ErrorSavePlacesState());
      }
    }).onError((error, stackTrace){
      debugPrint('Error Save Places ${error.toString()}');
      emit(ErrorSavePlacesState());
    });
  }

  List<File> listSelectImages= [];

  void deleteImagesSelected() {
    listSelectImages = [];
    emit(AnyUserState());
  }
  void selectImages(List<XFile> files,){
    for (var element in files) {
      listSelectImages.add(File(element.path));
    }
    emit(AnyUserState());
  }
  void deleteOnlyImage(File file){
    listSelectImages.removeWhere((element) => element == file);
    emit(AnyUserState());
  }

  void sendMessage({required String message, required String subject,}) async {
    emit(LoadingSendMessageState());
    String token = await SharedPreferencesServices.getData(key: ConstantData.kToken)??'';
    var request = http.MultipartRequest('POST', Uri.https(ConstantApi.nameDomain,'${ConstantApi.endPoint}messages/',),);
    request.headers.addAll({
      'Accept':'application/json',
      'Content-Type':'application/json',
      'token': token
    });

    if(listSelectImages.isNotEmpty){
      for(int i =0 ;i<listSelectImages.length ;i++){
        request.files.add(http.MultipartFile('image',
            File(listSelectImages[0].path).readAsBytes().asStream(),
            File(listSelectImages[0].path).lengthSync(),
            filename: listSelectImages[0].path.split("/").last));
      }
    }

    request.fields['subject'] = subject;
    request.fields['message'] = message;


    var res = await request.send();
    var response = await http.Response.fromStream(res);
    var resData = json.decode(response.body);

    debugPrint(request.fields.toString());
    debugPrint(response.body);

    debugPrint(resData.toString());
    if(response.statusCode == 200  || response.statusCode ==201){
      emit(SuccessSendMessageState());
      debugPrint('Success Send Message');
    }else {
      emit(ErrorSendMessageState());
      debugPrint('Error Send Message');
    }
  }

  void sendReport({required String report,}) async {
    emit(LoadingSendReportState());
    String token = await SharedPreferencesServices.getData(key: ConstantData.kToken)??'';
    var request = http.MultipartRequest('POST', Uri.https(ConstantApi.nameDomain,'${ConstantApi.endPoint}reports/',),);
    request.headers.addAll({
      'Accept':'application/json',
      'Content-Type':'application/json',
      'token': token
    });

    if(listSelectImages.isNotEmpty){
      for(int i =0 ;i<listSelectImages.length ;i++){
        request.files.add(http.MultipartFile('image',
            File(listSelectImages[0].path).readAsBytes().asStream(),
            File(listSelectImages[0].path).lengthSync(),
            filename: listSelectImages[0].path.split("/").last));
      }
    }

    request.fields['report'] = report;

    var res = await request.send();
    var response = await http.Response.fromStream(res);
    var resData = json.decode(response.body);

    debugPrint(request.fields.toString());
    debugPrint(response.body);

    debugPrint(resData.toString());
    if(response.statusCode == 200  || response.statusCode ==201){
      emit(SuccessSendReportState());
      debugPrint('Success Send Report');
      getDataUser();
    }else {
      emit(ErrorSendReportState());
      debugPrint('Error Send Report');
    }
  }

  List<FaqModel> faqList=[];
  List<FaqModel> faqList2=[];
  void faqData(){
    emit(LoadingGetTermState());
    faqList= [];
    UserRepository.getFaq().then((value){
      faqList= value;
      faqList2= value;
      emit(SuccessGetTermState());
      debugPrint('Success Get Term');
    }).onError((error, stackTrace){
      debugPrint('Error Get Term ${error.toString()}');
      emit(ErrorGetTermState());
    });
  }

  void searchFaq({required String search}){
    faqList=[];
    for (var element in faqList2) {
      if(element.question?.toLowerCase().contains(search.toLowerCase())??false){
        faqList.add(element);
      }
    }
    emit(AnyUserState());
  }

}

