import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:public_app/Core/services/shared_pref_services.dart';
import 'package:public_app/Core/unit/constant_data.dart';
import 'package:public_app/Feather/BookTaxi/data/model/booking_model.dart';
import 'package:public_app/Feather/MyBooking/data/repository/my_booking_repository.dart';

part 'my_booking_state.dart';

class MyBookingCubit extends Cubit<MyBookingState> {
  MyBookingCubit() : super(MyBookingInitial());

  static MyBookingCubit get(context) => BlocProvider.of(context);

  // state less vars
  bool isFetching = false;
  String tempSort = '';
  int tempPageIndex = 0;
  bool myBookingLoaded = false;
  bool enableToSendNewGetMyBookingRequest = true;
  String tempOptionsDropButton = '';
  int currentPageInMyBooking = 1;
  int totalPageInMyBooking = 2;
  bool invoiceSanded = true;
  bool tempIsCompany = false;
  String tempCourtesyTitles = '';
  String tempCompanyName = '';
  String tempUsername = '';
  String tempAddress = '';
  String tempFirstName = '';
  String tempLastName = '';
  String tempComment = '';
  String tempCardholdersName = '';
  String tempNumber = '';
  String tempCvc = '';
  String tempMonth = '';
  String tempYear = '';
  bool tempAcceptedPrivacy = false;
  double tempRating = 1;
  bool ratingSanded = true;
  bool modificationRequestSanded = true;
  bool offerAcceptSanded = true;
  bool paymentDetailsSanded = true;

  // main vars
  List<BookingModel> myBookings = [];
  DateTime lastUpdate = DateTime(1900);
  bool isCompany = false;
  String courtesyTitles = '';
  String companyName = '';
  String username = '';
  String firstName = '';
  String lastName = '';
  String address = '';
  bool invoice = false;
  String cardType = '';
  String number = '';
  String cvc = '';
  String month = '';
  String year = '';


  void updateStateLessPageVar({required Function() change}){
    change();
    emit(UpdateStateLessPage());
    emit(AnyState());
  }
  void changeIsCompany({required bool value}){
    isCompany=value;
    emit(ChangeBookValue());
    emit(AnyState());
  }
  void changeCompanyName({required String value}){
    companyName=value;
    emit(ChangeBookValue());
    emit(AnyState());
  }
  void changeUserName({required String value}){
    username=value;
    emit(ChangeBookValue());
    emit(AnyState());
  }
  void changeCourtesyTitles({required String value}){
    courtesyTitles=value;
    emit(ChangeBookValue());
    emit(AnyState());
  }
  void changeFirstName({required String value}){
    firstName=value;
    emit(ChangeBookValue());
    emit(AnyState());
  }
  void changeLastName({required String value}){
    lastName=value;
    emit(ChangeBookValue());
    emit(AnyState());
  }
  void changeAddress({required String value}){
    address=value;
    emit(ChangeBookValue());
    emit(AnyState());
  }
  void changeInvoice({required bool value}){
    invoice=value;
    emit(ChangeBookValue());
    emit(AnyState());
  }
  void changeNumber({required String value}){
    number=value;
    emit(ChangeBookValue());
    emit(AnyState());
  }
  void changeCvc({required String value}){
    cvc=value;
    emit(ChangeBookValue());
    emit(AnyState());
  }
  void changeMonth({required String value}){
    month=value;
    emit(ChangeBookValue());
    emit(AnyState());
  }
  void changeYear({required String value}){
    year=value;
    emit(ChangeBookValue());
    emit(AnyState());
  }

  Future<void> getMyBookings({bool changeTab = false}) async {
    if (isFetching) {
      return;
    }

    isFetching = true;
    myBookings.clear();

    try {
      emit(LoadingMyBookingState());
      String token = SharedPreferencesServices.getData(key: ConstantData.kToken) ?? '';

      if (token.isNotEmpty) {
        if (changeTab) {
          myBookings.clear();
          currentPageInMyBooking = 1;
        }

        var response = await MyBookingRepository.getMyBooking(token: token, page: currentPageInMyBooking, pastBookings: tempPageIndex == 1);

        if (response['statusCode'] >= 200 && response['statusCode'] < 300) {
          lastUpdate = DateTime.now();
          List<BookingModel> bookingModels = response['data']
              .map<BookingModel>((item) => BookingModel.fromJson(item, timeState: tempPageIndex == 0 ? TimeState.upcoming : TimeState.past))
              .toList();
          myBookings.addAll(bookingModels);
          myBookingLoaded = true;
          emit(SuccessMyBookingState());
        } else {
          emit(FiledMyBookingState());
        }
      } else {
        myBookings = [];
        emit(SuccessMyBookingState());
      }
    } catch (error) {
      emit(ErrorMyBookingsState());
    } finally {
      isFetching = false;
    }
  }
  void rating({required String id}){
    emit(LoadingRatingState());
    String token = SharedPreferencesServices.getData(key: ConstantData.kToken)??'';

    MyBookingRepository.rating(id: id, token: token, body: {
      "review":{
        "rating": tempRating,
        "comment": tempComment
      },
    }).then((value){
      if(value['statusCode'] >= 200 && value['statusCode'] < 300){

        emit(SuccessRatingState());
        debugPrint('Success Rating');
      }else{
        emit(FiledRatingState());
        debugPrint('Filed Rating');
      }
    }).onError((error, stackTrace){
      debugPrint('Error Rating ${error.toString()}');
      emit(ErrorRatingState());
    });
    emit(AnyState());
  }
  void modificationRequest({required String id}){
    emit(LoadingModificationRequestState());
    String token = SharedPreferencesServices.getData(key: ConstantData.kToken)??'';

    MyBookingRepository.modificationRequest(id: id, token: token).then((value){
      if(value['statusCode'] >= 200 && value['statusCode'] < 300){

        emit(SuccessModificationRequestState());
        debugPrint('Success Modification Request');
      }else{
        emit(FiledModificationRequestState());
        debugPrint('Filed Modification Request');
      }
    }).onError((error, stackTrace){
      debugPrint('Error Modification Request ${error.toString()}');
      emit(ErrorModificationRequestState());
    });
    emit(AnyState());
  }
  void createInvoiceForCardOnBoardAndCash({required String id}){
    emit(LoadingCreateInvoiceState());
    String token = SharedPreferencesServices.getData(key: ConstantData.kToken)??'';

    MyBookingRepository.createInvoiceForCardOnBoardAndCash(id: id, token: token, body: {
      'isCompany': isCompany,
      if(isCompany)'companyName': companyName,
      if(isCompany)'username': username,
      if(isCompany)'courtesyTitles': courtesyTitles,
      'address': address,
      if(!isCompany)'firstName': firstName,
      if(!isCompany)'lastName': lastName,
    }).then((value){
      if(value['statusCode'] >= 200 && value['statusCode'] < 300){

        emit(SuccessCreateInvoiceState());
        debugPrint('Success Create Invoice');
      }else{
        emit(FiledCreateInvoiceState());
        debugPrint('Filed Create Invoice');
      }
    }).onError((error, stackTrace){
      debugPrint('Error Create Invoice ${error.toString()}');
      emit(ErrorCreateInvoiceState());
    });
    emit(AnyState());
  }
  void createInvoiceForCardOnline({required String id}){
    emit(LoadingCreateInvoiceState());
    String token = SharedPreferencesServices.getData(key: ConstantData.kToken)??'';

    MyBookingRepository.createInvoiceForCardOnline(id: id, token: token, body: {
      'isCompany': isCompany,
      if(isCompany)'companyName': companyName,
      if(isCompany)'username': username,
      if(isCompany)'courtesyTitles': courtesyTitles,
      'address': address,
      if(!isCompany)'firstName': firstName,
      if(!isCompany)'lastName': lastName,
    }).then((value){
      if(value['statusCode'] >= 200 && value['statusCode'] < 300){

        emit(SuccessCreateInvoiceState());
        debugPrint('Success Create Invoice');
      }else{
        emit(FiledCreateInvoiceState());
        debugPrint('Filed Create Invoice');
      }
    }).onError((error, stackTrace){
      debugPrint('Error Create Invoice ${error.toString()}');
      emit(ErrorCreateInvoiceState());
    });
    emit(AnyState());
  }
  void cardOnlinePayment({required String id}){
    emit(LoadingCreateInvoiceState());
    String token = SharedPreferencesServices.getData(key: ConstantData.kToken)??'';

    MyBookingRepository.cardOnlinePayment(id: id, token: token, body: {
      "number": number,
      "month": month,
      "year": year,
      "cvv": cvc
    }).then((value){
      if(value['statusCode'] >= 200 && value['statusCode'] < 300){

        emit(SuccessCardOnlinePaymentState());
        debugPrint('Success Card Online Payment');
      }else{
        emit(FiledCardOnlinePaymentState());
        debugPrint('Filed Card Online Payment');
      }
    }).onError((error, stackTrace){
      debugPrint('Error Card Online Payment ${error.toString()}');
      emit(ErrorCardOnlinePaymentState());
    });
    emit(AnyState());
  }
  void acceptOffer({required String id}){
    emit(SendingOfferAcceptState());
    String token = SharedPreferencesServices.getData(key: ConstantData.kToken)??'';

    MyBookingRepository.sendAcceptOffer(id: id, token: token).then((value){
      if(value['statusCode'] >= 200 && value['statusCode'] < 300){
        emit(SuccessOfferAcceptState());
        debugPrint('Success Offer Accept');
      }else{
        emit(FiledOfferAcceptState());
        debugPrint('Filed Offer Accept');
        debugPrint(value.toString());
      }
    }).onError((error, stackTrace){
      debugPrint('Error Offer Accept ${error.toString()}');
      emit(ErrorOfferAcceptState());
    });
    emit(AnyState());
  }
}
