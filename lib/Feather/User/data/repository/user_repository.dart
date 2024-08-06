
import 'package:public_app/Core/api/constant_api.dart';
import 'package:public_app/Core/api/http_services.dart';
import 'package:public_app/Core/services/shared_pref_services.dart';
import 'package:public_app/Core/unit/constant_data.dart';
import 'package:public_app/Feather/User/data/model/places_model.dart';
import 'package:public_app/Feather/User/data/model/social_model.dart';
import 'package:public_app/Feather/User/data/model/term_model.dart';
import 'package:public_app/Feather/User/data/model/user_model.dart';

class UserRepository{

  static Future login({required Map<String,dynamic> body}) async {
    final  uri = Uri.https(ConstantApi.nameDomain,'${ConstantApi.endPoint}users/login/',);
    Map<String, dynamic> data = await ApiService.post(uri: uri,
        body: body);
    return data;
  }

  static Future<UserModel> getDateUser() async {
    String token = SharedPreferencesServices.getData(key: ConstantData.kToken)??'';
    final  uri = Uri.https(ConstantApi.nameDomain,'${ConstantApi.endPoint}users/me/',);
    Map<String, dynamic> data = await ApiService.get(uri: uri,
        headers: {
          'Authorization': 'Bearer $token',
          'token':token
        });
    UserModel userModel = UserModel.jsonData(data);
    return userModel;
  }

  static Future forgetMail({required Map<String,dynamic> body}) async {
    final  uri = Uri.https(ConstantApi.nameDomain,'${ConstantApi.endPoint}users/retrieveEmail/',);
    Map<String, dynamic> data = await ApiService.post(uri: uri,
        body: body);
    return data;
  }

  static Future forgetPassword({required Map<String,dynamic> body}) async {
    final  uri = Uri.https(ConstantApi.nameDomain,'${ConstantApi.endPoint}users/resetPasswordLink/',);
    Map<String, dynamic> data = await ApiService.post(uri: uri,
        body: body);
    return data;
  }

  static Future signUp({required Map<String,dynamic> body}) async {
    final  uri = Uri.https(ConstantApi.nameDomain,'${ConstantApi.endPoint}users/',);
    Map<String, dynamic> data = await ApiService.post(uri: uri,
        body: body);
    return data;
  }

  static Future<List<SocialModel>> getSocialModel() async {
    final  uri = Uri.https(ConstantApi.nameDomain,'${ConstantApi.endPoint}socialPlatforms/',);
    Map<String, dynamic> data = await ApiService.get(uri: uri,);
    List<SocialModel> socialList = [];
    for (int i = 0; i < data['data'].length; i++) {
      socialList.add(SocialModel.jsonData(data['data'][i]));
    }
    return socialList;
  }

  static Future deleteAccount() async {
    String token = SharedPreferencesServices.getData(key: ConstantData.kToken)??'';
    final  uri = Uri.https(ConstantApi.nameDomain,'${ConstantApi.endPoint}users/me/delete',);
    Map<String, dynamic> data = await ApiService.delete(uri: uri,
        headers: {
          'Authorization': 'Bearer $token',
          'token':token
        });
    return data;
  }

  static Future changePassword({required Map<String, dynamic> body}) async {
    String token = SharedPreferencesServices.getData(key: ConstantData.kToken)??'';
    final  uri = Uri.https(ConstantApi.nameDomain,'${ConstantApi.endPoint}users/changePassword/',);
    Map<String, dynamic> data = await ApiService.patch(uri: uri,
        headers: {
          'token':token
        },
    body: body);
    return data;
  }

  static Future<List<PlacesModel>> getPlaces() async {
    String token = SharedPreferencesServices.getData(key: ConstantData.kToken)??'';
    final  uri = Uri.https(ConstantApi.nameDomain,'${ConstantApi.endPoint}savedPlaces/',);
    Map<String, dynamic> data = await ApiService.get(uri: uri,
        headers: {
          'token':token
        });
    List<PlacesModel> placesList = [];
    for (int i = 0; i < data['data'].length; i++) {
      placesList.add(PlacesModel.jsonData(data['data'][i]));
    }
    return placesList;
  }

  static Future changePlaces({required Map<String, dynamic> body , required String id}) async {
    String token = SharedPreferencesServices.getData(key: ConstantData.kToken)??'';
    final  uri = Uri.https(ConstantApi.nameDomain,'${ConstantApi.endPoint}savedPlaces/$id',);
    Map<String, dynamic> data = await ApiService.patch(uri: uri,
        headers: {
          'token':token
        },
        body: body);
    return data;
  }

  static Future savePlaces({required Map<String, dynamic> body }) async {
    String token = SharedPreferencesServices.getData(key: ConstantData.kToken)??'';
    final  uri = Uri.https(ConstantApi.nameDomain,'${ConstantApi.endPoint}savedPlaces/',);
    Map<String, dynamic> data = await ApiService.post(uri: uri,
        headers: {
          'token':token
        },
        body: body);
    return data;
  }

  static Future<List<FaqModel>> getFaq() async {
    final  uri = Uri.https(ConstantApi.nameDomain,'${ConstantApi.endPoint}faqs/',);
    dynamic data = await ApiService.get(uri: uri,);

    List<FaqModel> faqList = [];
    for (int i = 0; i < data['data'].length; i++) {
      faqList.add(FaqModel.jsonData(data['data'][i]));
    }
    return faqList;
  }




}