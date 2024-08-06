import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:public_app/Core/services/shared_pref_services.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/constant_data.dart';
import 'package:public_app/Feather/BookTaxi/data/model/booking_model.dart';
import 'package:public_app/Feather/BookTaxi/data/model/offer_model.dart';
import 'package:public_app/Feather/BookTaxi/data/model/ticket_model.dart';
import 'package:public_app/Feather/BookTaxi/data/repository/book_taxi_repository.dart';

part 'book_taxi_state.dart';

class BookTaxiCubit extends Cubit<BookTaxiState> {

  BookTaxiCubit() : super(BookTaxiInitialState());

  static BookTaxiCubit get(context) => BlocProvider.of(context);

  // state less vars
  bool flexiblePriceError = false;
  bool flexiblePriceWarning = false;
  bool notLateTimeError = false;
  bool notLateTimeErrorRoundTrip = false;
  bool notLateNewTimeError = false;
  bool firstTimeNotBeforeRoundTripTimeError = false;
  bool pickUpAddressError = false;
  bool dropOffAddressError = false;
  bool priceLoaded = false;
  bool priceRoundTripLoaded = false;
  String cardType = '';
  String cancelReason = LocaleKeys.kPriceIsExpensive.tr();
  bool tempIsCompany = false;
  String tempCourtesyTitles = '';
  bool offerLoaded = false;
  bool ticketLoaded = false;
  bool offerAcceptSanded = true;
  bool offerRejectSanded = true;
  bool bookingRequestSanded = true;
  bool cancelingRequestSanded = true;
  bool rebookingSanded = true;
  String tempCompanyName = '';
  String tempUsername = '';
  String tempAddress = '';
  String tempFirstName = '';
  String tempLastName = '';
  String tempCardholdersName = '';
  String tempNumber = '';
  String tempCvc = '';
  String tempMonth = '';
  String tempYear = '';
  int tempAdult = 0;
  int tempChild = 0;
  int tempInfant = 0;
  int tempCats = 0;
  int tempDogs = 0;
  int tempBig = 0;
  int tempMedium = 0;
  int tempSmall = 0;
  int tempSurfboard = 0;
  int tempSkiBoard = 0;
  int tempGolf = 0;
  int tempBicycle = 0;
  int tempAdditionalPageIndex = 0;
  int tempAddDateTimePageIndex = 0;
  int tempAdultRoundTrip = 0;
  int tempChildRoundTrip = 0;
  int tempInfantRoundTrip = 0;
  int tempCatsRoundTrip = 0;
  int tempDogsRoundTrip = 0;
  int tempBigRoundTrip = 0;
  int tempMediumRoundTrip = 0;
  int tempSmallRoundTrip = 0;
  int tempSurfboardRoundTrip = 0;
  int tempSkiBoardRoundTrip = 0;
  int tempGolfRoundTrip = 0;
  int tempBicycleRoundTrip = 0;
  bool? validPassengers;
  bool? validPassengersRoundTrip;
  bool viewPricePressed = false;
  String tempPickUpAddress = '';
  String tempDropOffAddress = '';
  double tempPickUpAddressLat = 0;
  double tempPickUpAddressLng = 0;
  double tempDropOffAddressLat = 0;
  double tempDropOffAddressLng = 0;
  int selectedRecentPlacePickUpAddress = -1;
  int selectedRecentPlaceDropOffAddress = -1;
  DateTime tempFocusedDate = DateTime.now();
  DateTime tempFocusedDateRoundTrip = DateTime.now();
  DateTime tempSelectedDate = DateTime.now();
  DateTime tempSelectedDateRoundTrip = DateTime.now();
  TimeOfDay tempSelectedTime = TimeOfDay.now();
  TimeOfDay tempSelectedTimeRoundTrip = TimeOfDay.now();
  DateTime tempFocusedNewDate = DateTime.now();
  DateTime tempSelectedNewDate = DateTime.now();
  TimeOfDay tempSelectedNewTime = TimeOfDay.now();
  String bookingID = '';
  bool sendingInAddAddressViewYourLocation = false;
  bool sendingInAddAddressViewSaveLocation = false;
  int selectedPriceNumber = -1;
  int selectedPriceNumberRoundTrip = -1;

  // main vars
  String idUncompletedBook = '';
  String vehicleType = 'sedan';
  String vehicleTypeRoundTrip = 'sedan';
  String pickUpAddress = '';
  String dropOffAddress = '';
  String comments = '';
  String commentsRoundTrip = '';
  String flightNumber = '';
  String flightNumberRoundTrip = '';
  String pricingMethod = 'fixed';
  String payment = 'cash';
  String number = '';
  String cvc = '';
  String month = '';
  String year = '';
  String companyName = '';
  String username = '';
  String courtesyTitles = '';
  String address = '';
  String firstName = '';
  String lastName = '';
  bool roundTrip = false;
  bool invoice = false;
  bool lockInvoice = false;
  bool isCompany = false;
  double pickUpAddressLat = 0;
  double pickUpAddressLng = 0;
  double dropOffAddressLat = 0;
  double dropOffAddressLng = 0;
  int adult = 0;
  int adultRoundTrip = 0;
  int child = 0;
  int childRoundTrip = 0;
  int infant = 0;
  int infantRoundTrip = 0;
  int cats = 0;
  int catsRoundTrip = 0;
  int dogs = 0;
  int dogsRoundTrip = 0;
  int big = 0;
  int bigRoundTrip = 0;
  int medium = 0;
  int mediumRoundTrip = 0;
  int small = 0;
  int smallRoundTrip = 0;
  int surfboard = 0;
  int surfboardRoundTrip = 0;
  int skiBoard = 0;
  int skiBoardRoundTrip = 0;
  int golf = 0;
  int golfRoundTrip = 0;
  int bicycle = 0;
  int bicycleRoundTrip = 0;
  int price = 0;
  int priceRoundTrip = 0;
  DateTime date = DateTime.now();
  DateTime dateRoundTrip = DateTime.now();
  DateTime newDate = DateTime.now();
  TimeOfDay newTime = TimeOfDay.now();
  TimeOfDay time = TimeOfDay.now();
  TimeOfDay timeRoundTrip = TimeOfDay.now();
  bool dateTimeSelected = false;
  bool dateTimeSelectedRoundTrip = false;
  bool newDateTimeSelected = false;
  List<Map<String, dynamic>> prices = [];
  List<Map<String, dynamic>> pricesRoundTrip = [];
  OfferModel? offer;
  BookingModel? bookingDetails;
  List<OfferModel> offers = [];
  TicketModel? ticket;

  bool firstTripEqualSecondTrip() {
    if (vehicleType == vehicleTypeRoundTrip &&
        comments == commentsRoundTrip &&
        adult == adultRoundTrip &&
        child == childRoundTrip &&
        infant == infantRoundTrip &&
        cats == catsRoundTrip &&
        dogs == dogsRoundTrip &&
        big == bigRoundTrip &&
        medium == mediumRoundTrip &&
        small == smallRoundTrip &&
        surfboard == surfboardRoundTrip &&
        skiBoard == skiBoardRoundTrip &&
        golf == golfRoundTrip &&
        bicycle == bicycleRoundTrip) {
      return true;
    } else {
      return false;
    }
  }

  void updateStateLessPageVar({required Function() change}){
    change();
    emit(UpdateStateLessPage());
    emit(AnyState());
  }
  void resetVarToCompleteBooking({required BookingModel model}){
    idUncompletedBook = model.id??'';

    adult = model.adult??0;
    child = model.children??0;
    infant = model.enfants??0;

    big = model.large??0;
    medium = model.medium??0;
    small = model.small??0;

    surfboard = model.surfboard??0;
    skiBoard = model.ski??0;
    golf = model.golf??0;
    bicycle = model.bicycle??0;

    cats = model.cats??0;
    dogs = model.dogs??0;

    date = model.departureDateTime??DateTime.now();
    time = TimeOfDay(hour: date.hour, minute: date.minute);
    dateTimeSelected = true;

    vehicleType = model.vehicleType == TaxiType.sedan? 'sedan' : 'van';

    price = model.price??0;

    pricingMethod = model.pricingMethod??'';

    pickUpAddress = model.departureLocation??'';
    locationFromAddress(pickUpAddress).then((value) {
      Location pickUpLocation = value[0];
      pickUpAddressLat = double.parse(pickUpLocation.latitude.toStringAsFixed(6));
      pickUpAddressLng = double.parse(pickUpLocation.longitude.toStringAsFixed(6));
    },);

    dropOffAddress = model.arrivalLocation??'';
    locationFromAddress(dropOffAddress).then((value) {
      Location dropOffLocation = value[0];
      dropOffAddressLat = double.parse(dropOffLocation.latitude.toStringAsFixed(6));
      dropOffAddressLng = double.parse(dropOffLocation.longitude.toStringAsFixed(6));
    },);
    emit(UpdateStateLessPage());
    emit(AnyState());
  }
  void changeVehicleType({required String value}){
    if (firstTripEqualSecondTrip()) {
      vehicleType=value;
      vehicleTypeRoundTrip=value;
    } else {
      vehicleType=value;
    }
    emit(ChangeBookValue());
    emit(AnyState());
  }
  void changeVehicleTypeRoundTrip({required String value}){
    vehicleTypeRoundTrip=value;
    emit(ChangeBookValue());
    emit(AnyState());
  }
  void changePickUpAddress({required String value, required double lat, required double lng}){
    pickUpAddress=value;
    pickUpAddressLat=lat;
    pickUpAddressLng=lng;
    emit(ChangeBookValue());
    emit(AnyState());
  }
  void changeDropOffAddress({required String value, required double lat, required double lng}){
    dropOffAddress=value;
    dropOffAddressLat=lat;
    dropOffAddressLng=lng;
    emit(ChangeBookValue());
    emit(AnyState());
  }
  void changeComments({required String value}){
    comments=value;
    emit(ChangeBookValue());
    emit(AnyState());
  }
  void changeCommentsRoundTrip({required String value}){
    commentsRoundTrip=value;
    emit(ChangeBookValue());
    emit(AnyState());
  }
  void changeFlightNumber({required String value}){
    flightNumber=value;
    emit(ChangeBookValue());
    emit(AnyState());
  }
  void changeFlightNumberRoundTrip({required String value}){
    flightNumberRoundTrip=value;
    emit(ChangeBookValue());
    emit(AnyState());
  }
  void changePricingMethod({required String value}){
    pricingMethod=value;
    emit(ChangeBookValue());
    emit(AnyState());
  }
  void changePayment({required String value}){
    payment=value;
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
  void changeAddress({required String value}){
    address=value;
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
  void changeRoundTrip({required bool value}){
    roundTrip=value;
    emit(ChangeBookValue());
    emit(AnyState());
  }
  void changeInvoice({required bool value}){
    invoice=value;
    lockInvoice=value;
    emit(ChangeBookValue());
    emit(AnyState());
  }
  void changeIsCompany({required bool value}){
    isCompany=value;
    emit(ChangeBookValue());
    emit(AnyState());
  }

  void changeAdult({required int value}){
    int tempAdult = adult;
    if (firstTripEqualSecondTrip()) {
      adult=value;
      adultRoundTrip=value;
    } else {
      adult=value;
    }
    if (!checkCapacity()) {
      if (firstTripEqualSecondTrip()) {
        adult=tempAdult;
        adultRoundTrip=tempAdult;
      } else {
        adult=tempAdult;
      }
    }
  }
  void changeAdultRoundTrip({required int value}){
    int tempAdultRoundTrip= adultRoundTrip;
    adultRoundTrip=value;
    if (!checkCapacityRoundTrip()) {
      adultRoundTrip=tempAdultRoundTrip;
    }
  }
  void changeChild({required int value}){
    int tempChild = child;
    if (firstTripEqualSecondTrip()) {
      child=value;
      childRoundTrip=value;
    } else {
      child=value;
    }
    if (!checkCapacity()) {
      if (firstTripEqualSecondTrip()) {
        child=tempChild;
        childRoundTrip=tempChild;
      } else {
        child=tempChild;
      }
    }
  }
  void changeChildRoundTrip({required int value}){
    int tempChildRoundTrip = childRoundTrip;
    childRoundTrip=value;
    if (!checkCapacityRoundTrip()) {
      childRoundTrip=tempChildRoundTrip;
    }
  }
  void changeInfant({required int value}){
    int tempInfant = infant;
    if (firstTripEqualSecondTrip()) {
      infant=value;
      infantRoundTrip=value;
    } else {
      infant=value;
    }
    if (!checkCapacity()) {

      if (firstTripEqualSecondTrip()) {
        infant=tempInfant;
        infantRoundTrip=tempInfant;
      } else {
        infant=tempInfant;
      }
    }
  }
  void changeInfantRoundTrip({required int value}){
    int tempInfantRoundTrip = infantRoundTrip;
    infantRoundTrip=value;
    if (!checkCapacityRoundTrip()) {
      infantRoundTrip=tempInfantRoundTrip;
    }
  }
  void changeCats({required int value}){
    int tempCats = cats;
    if (firstTripEqualSecondTrip()) {
      cats=value;
      catsRoundTrip=value;
    } else {
      cats=value;
    }
    if (!checkCapacity()) {
      if (firstTripEqualSecondTrip()) {
        cats=tempCats;
        catsRoundTrip=tempCats;
      } else {
        cats=tempCats;
      }
    }
  }
  void changeCatsRoundTrip({required int value}){
    int tempCatsRoundTrip = catsRoundTrip;
    catsRoundTrip=value;
    if (!checkCapacityRoundTrip()) {
      catsRoundTrip=tempCatsRoundTrip;
    }
  }
  void changeDogs({required int value}){
    int tempDogs = dogs;
    if (firstTripEqualSecondTrip()) {
      dogs=value;
      dogsRoundTrip=value;
    } else {
      dogs=value;
    }
    if (!checkCapacity()) {
      if (firstTripEqualSecondTrip()) {
        dogs=tempDogs;
        dogsRoundTrip=tempDogs;
      } else {
        dogs=tempDogs;
      }
    }
  }
  void changeDogsRoundTrip({required int value}){
    int tempDogsRoundTrip = dogsRoundTrip;
    dogsRoundTrip=value;
    if (!checkCapacityRoundTrip()) {
      dogsRoundTrip=tempDogsRoundTrip;
    }
  }
  void changeBig({required int value}){
    int tempBig = big;
    if (firstTripEqualSecondTrip()) {
      big=value;
      bigRoundTrip=value;
    } else {
      big=value;
    }
    if (!checkCapacity()) {
      if (firstTripEqualSecondTrip()) {
        big=tempBig;
        bigRoundTrip=tempBig;
      } else {
        big=tempBig;
      }
    }
  }
  void changeBigRoundTrip({required int value}){
    int tempBigRoundTrip = bigRoundTrip;
    bigRoundTrip=value;
    if (!checkCapacityRoundTrip()) {
      bigRoundTrip=tempBigRoundTrip;
    }
  }
  void changeMedium({required int value}){
    int tempMedium = medium;
    if (firstTripEqualSecondTrip()) {
      medium=value;
      mediumRoundTrip=value;
    } else {
      medium=value;
    }
    if (!checkCapacity()) {
      if (firstTripEqualSecondTrip()) {
        medium=tempMedium;
        mediumRoundTrip=tempMedium;
      } else {
        medium=tempMedium;
      }
    }
  }
  void changeMediumRoundTrip({required int value}){
    int tempMediumRoundTrip = mediumRoundTrip;
    mediumRoundTrip=value;
    if (!checkCapacityRoundTrip()) {
      mediumRoundTrip=tempMediumRoundTrip;
    }
  }
  void changeSmall({required int value}){
    int tempSmall = small;
    if (firstTripEqualSecondTrip()) {
      small=value;
      smallRoundTrip=value;
    } else {
      small=value;
    }
    if (!checkCapacity()) {
      if (firstTripEqualSecondTrip()) {
        small=tempSmall;
        smallRoundTrip=tempSmall;
      } else {
        small=tempSmall;
      }
    }
  }
  void changeSmallRoundTrip({required int value}){
    int tempSmallRoundTrip = smallRoundTrip;
    smallRoundTrip=value;
    if (!checkCapacityRoundTrip()) {
      smallRoundTrip=tempSmallRoundTrip;
    }
  }
  void changeSurfboard({required int value}){
    int tempSurfboard = surfboard;
    if (firstTripEqualSecondTrip()) {
      surfboard=value;
      surfboardRoundTrip=value;
    } else {
      surfboard=value;
    }
    if (!checkCapacity()) {
      if (firstTripEqualSecondTrip()) {
        surfboard=tempSurfboard;
        surfboardRoundTrip=tempSurfboard;
      } else {
        surfboard=tempSurfboard;
      }
    }
  }
  void changeSurfboardRoundTrip({required int value}){
    int tempSurfboardRoundTrip = surfboardRoundTrip;
    surfboardRoundTrip=value;
    if (!checkCapacityRoundTrip()) {
      surfboardRoundTrip=tempSurfboardRoundTrip;
    }
  }
  void changeSkiBoard({required int value}){
    int tempSkiBoard = skiBoard;
    if (firstTripEqualSecondTrip()) {
      skiBoard=value;
      skiBoardRoundTrip=value;
    } else {
      skiBoard=value;
    }
    if (!checkCapacity()) {
      if (firstTripEqualSecondTrip()) {
        skiBoard=tempSkiBoard;
        skiBoardRoundTrip=tempSkiBoard;
      } else {
        skiBoard=tempSkiBoard;
      }
    }
  }
  void changeSkiBoardRoundTrip({required int value}){
    int tempSkiBoardRoundTrip = skiBoardRoundTrip;
    skiBoardRoundTrip=value;
    if (!checkCapacityRoundTrip()) {
      skiBoardRoundTrip=tempSkiBoardRoundTrip;
    }
  }
  void changeGolf({required int value}){
    int tempGolf = golf;
    if (firstTripEqualSecondTrip()) {
      golf=value;
      golfRoundTrip=value;
    } else {
      golf=value;
    }
    if (!checkCapacity()) {
      if (firstTripEqualSecondTrip()) {
        golf=tempGolf;
        golfRoundTrip=tempGolf;
      } else {
        golf=tempGolf;
      }
    }
  }
  void changeGolfRoundTrip({required int value}){
    int tempGolfRoundTrip = golfRoundTrip;
    golfRoundTrip=value;
    if (!checkCapacityRoundTrip()) {
      golfRoundTrip=tempGolfRoundTrip;
    }
  }
  void changeBicycle({required int value}){
    int tempBicycle = bicycle;
    if (firstTripEqualSecondTrip()) {
      bicycle=value;
      bicycleRoundTrip=value;
    } else {
      bicycle=value;
    }
    if (!checkCapacity()) {
      if (firstTripEqualSecondTrip()) {
        bicycle=tempBicycle;
        bicycleRoundTrip=tempBicycle;
      } else {
        bicycle=tempBicycle;
      }
    }
  }
  void changeBicycleRoundTrip({required int value}){
    int tempBicycleRoundTrip = bicycleRoundTrip;
    bicycleRoundTrip=value;
    if (!checkCapacityRoundTrip()) {
      bicycleRoundTrip=tempBicycleRoundTrip;
    }
  }

  void submitAdditionalDetails(){
    changeAdult(value: tempAdult);
    changeChild(value: tempChild);
    changeInfant(value: tempInfant);
    changeBig(value: tempBig);
    changeMedium(value: tempMedium);
    changeSmall(value: tempSmall);
    changeSurfboard(value: tempSurfboard);
    changeSkiBoard(value: tempSkiBoard);
    changeGolf(value: tempGolf);
    changeBicycle(value: tempBicycle);
    changeCats(value: tempCats);
    changeDogs(value: tempDogs);
    emit(ChangeBookValue());
    emit(AnyState());
  }
  void submitAdditionalDetailsRoundTrip(){
    changeAdultRoundTrip(value: tempAdultRoundTrip);
    changeChildRoundTrip(value: tempChildRoundTrip);
    changeInfantRoundTrip(value: tempInfantRoundTrip);
    changeBigRoundTrip(value: tempBigRoundTrip);
    changeMediumRoundTrip(value: tempMediumRoundTrip);
    changeSmallRoundTrip(value: tempSmallRoundTrip);
    changeSurfboardRoundTrip(value: tempSurfboardRoundTrip);
    changeSkiBoardRoundTrip(value: tempSkiBoardRoundTrip);
    changeGolfRoundTrip(value: tempGolfRoundTrip);
    changeBicycleRoundTrip(value: tempBicycleRoundTrip);
    changeCatsRoundTrip(value: tempCatsRoundTrip);
    changeDogsRoundTrip(value: tempDogsRoundTrip);
    emit(ChangeBookValue());
    emit(AnyState());
  }
  void changePrice({required int value}){
    price=value;
    emit(ChangeBookValue());
    emit(AnyState());
  }
  void changePriceRoundTrip({required int value}){
    priceRoundTrip=value;
    emit(ChangeBookValue());
    emit(AnyState());
  }
  void changeDate({required DateTime value}){
    date=value;

    emit(ChangeBookValue());
    emit(AnyState());
  }
  void changeDateRoundTrip({required DateTime value}){
    dateRoundTrip=value;
    emit(ChangeBookValue());
    emit(AnyState());
  }
  void changeNewDate({required DateTime value}){
    newDate=value;
    emit(ChangeRebookValue());
    emit(AnyState());
  }
  void changeNewTime({required TimeOfDay value}){
    newTime=value;
    checkIfNewTimeDateIsEnable();
    emit(ChangeRebookValue());
    emit(AnyState());
  }
  void changeTime({required TimeOfDay value}){
    time=value;
    checkIfTimeDateIsEnable(value, true);
    checkIfTimeDateRoundTripIsEnable();
    emit(ChangeBookValue());
    emit(AnyState());
  }
  void changeTimeRoundTrip({required TimeOfDay value}){
    timeRoundTrip=value;
    checkIfTimeDateIsEnable(value, false);
    checkIfTimeDateRoundTripIsEnable();
    emit(ChangeBookValue());
    emit(AnyState());
  }

  bool get checkIfBetween12and6Am{
    DateTime dateForCheck = DateTime(date.year,date.month,date.day,time.hour,time.minute);
    bool isTimeBetween1201AMAnd330AM = (date.hour == 12 && date.minute >= 1) ||
        (dateForCheck.hour == 2) ||
        (dateForCheck.hour == 3) ||
        (dateForCheck.hour == 4) ||
        (dateForCheck.hour == 5) ||
        (dateForCheck.hour == 6 && dateForCheck.minute <= 0);
    return isTimeBetween1201AMAnd330AM;
  }
  bool get checkMeIfBetween12and6Am{
    DateTime date = DateTime.now();
    bool isTimeBetween1201AMAnd330AM = (date.hour == 12 && date.minute >= 1) ||
        (date.hour == 2) ||
        (date.hour == 3) ||
        (date.hour == 4) ||
        (date.hour == 5) ||
        (date.hour == 6 && date.minute <= 0);
    return isTimeBetween1201AMAnd330AM;
  }
  bool isSchedule(){
    /*checkIfTimeDateIsEnableOrSwitch();*/
    DateTime dateForCheck = DateTime(date.year,date.month,date.day,time.hour,time.minute);
    var difference = dateForCheck.difference(DateTime.now()).inMinutes.abs();

    DateTime now = DateTime.now();

    bool isTodayOrTomorrow = dateForCheck.day == now.day || dateForCheck.day == now.add(const Duration(days: 1)).day;
    bool isTimeBetween1AMand330AM = (dateForCheck.hour == 1 && dateForCheck.minute >= 0) || (dateForCheck.hour == 2) || (dateForCheck.hour == 3 && dateForCheck.minute <= 30);

    if (difference <= 120 || ((dateForCheck.hour >= 20 || dateForCheck.hour < 8) && isTodayOrTomorrow) || isTimeBetween1AMand330AM) {
      return false;
    } else {
      return true;
    }
  }

  void checkTempCapacityOfSedan(){
    if(vehicleType == 'sedan') {
      int maxCapacityPassenger = 4;
      int maxCapacityBigLuggages = 3;
      int maxCapacityMediumLuggages = 1;

      int bigLuggages = 0;
      int midLuggages = 0;
      int smallLuggages = 0;

      bigLuggages += tempGolf;
      bigLuggages += tempBig;
      smallLuggages += tempSmall;
      midLuggages += tempMedium;

      if(smallLuggages % 2 == 0) {
        midLuggages += tempSmall ~/ 2;
        smallLuggages = 0;
      } else {
        midLuggages += tempSmall ~/ 2;
        smallLuggages = 1;
      }

      if(midLuggages % 2 == 0) {
        bigLuggages += midLuggages ~/ 2;
        midLuggages = 0;
      } else {
        bigLuggages += midLuggages ~/ 2;
        midLuggages = 1;
      }

      if (tempSkiBoard != 0 || tempSurfboard != 0 || tempBicycle != 0) {
        emit(SwitchToVanMandatoryForTempState());
        return;
      }
      if (tempAdult + tempChild + tempInfant + tempCats + tempDogs > maxCapacityPassenger) {
        emit(SwitchToVanMandatoryForTempState());
        return;
      }
      if (bigLuggages > maxCapacityBigLuggages) {
        emit(SwitchToVanMandatoryForTempState());
        return;
      }
      if (midLuggages > maxCapacityMediumLuggages) {
        emit(SwitchToVanMandatoryForTempState());
        return;
      }
      if (bigLuggages == maxCapacityBigLuggages && midLuggages == maxCapacityMediumLuggages && smallLuggages > 0) {
        emit(SwitchToVanMandatoryForTempState());
        return;
      }

      if (tempAdult + tempChild + tempInfant + tempCats + tempDogs == maxCapacityPassenger) {
        emit(SwitchToVanOptionalForTempState());
        return;
      }
    }
  }
  void checkTempCapacityOfSedanRoundTrip(){
    if(vehicleTypeRoundTrip == 'sedan') {
      int maxCapacityPassenger = 4;
      int maxCapacityBigLuggages = 3;
      int maxCapacityMediumLuggages = 1;

      int bigLuggages = 0;
      int midLuggages = 0;
      int smallLuggages = 0;

      bigLuggages += tempGolfRoundTrip;
      bigLuggages += tempBigRoundTrip;
      smallLuggages += tempSmallRoundTrip;
      midLuggages += tempMediumRoundTrip;

      if(smallLuggages % 2 == 0) {
        midLuggages += tempSmallRoundTrip ~/ 2;
        smallLuggages = 0;
      } else {
        midLuggages += tempSmallRoundTrip ~/ 2;
        smallLuggages = 1;
      }

      if(midLuggages % 2 == 0) {
        bigLuggages += midLuggages ~/ 2;
        midLuggages = 0;
      } else {
        bigLuggages += midLuggages ~/ 2;
        midLuggages = 1;
      }

      if (tempSkiBoardRoundTrip != 0 || tempSurfboardRoundTrip != 0 || tempBicycleRoundTrip != 0) {
        emit(SwitchToVanMandatoryForTempRoundTripState());
        return;
      }
      if (tempAdultRoundTrip + tempChildRoundTrip + tempInfantRoundTrip + tempCatsRoundTrip + tempDogsRoundTrip > maxCapacityPassenger) {
        emit(SwitchToVanMandatoryForTempRoundTripState());
        return;
      }
      if (bigLuggages > maxCapacityBigLuggages) {
        emit(SwitchToVanMandatoryForTempRoundTripState());
        return;
      }
      if (midLuggages > maxCapacityMediumLuggages) {
        emit(SwitchToVanMandatoryForTempRoundTripState());
        return;
      }
      if (bigLuggages == maxCapacityBigLuggages && midLuggages == maxCapacityMediumLuggages && smallLuggages > 0) {
        emit(SwitchToVanMandatoryForTempRoundTripState());
        return;
      }

      if (tempAdultRoundTrip + tempChildRoundTrip + tempInfantRoundTrip + tempCatsRoundTrip + tempDogsRoundTrip == maxCapacityPassenger) {
        emit(SwitchToVanOptionalForTempRoundTripState());
        return;
      }
    }
  }
  void checkCapacityOfSedan(){
    if(vehicleType == 'sedan') {
      int maxCapacityPassenger = 4;
      int maxCapacityBigLuggages = 3;
      int maxCapacityMediumLuggages = 1;

      int bigLuggages = 0;
      int midLuggages = 0;
      int smallLuggages = 0;

      bigLuggages += golf;
      bigLuggages += big;
      smallLuggages += small;
      midLuggages += medium;

      if(smallLuggages % 2 == 0) {
        midLuggages += small ~/ 2;
        smallLuggages = 0;
      } else {
        midLuggages += small ~/ 2;
        smallLuggages = 1;
      }

      if(midLuggages % 2 == 0) {
        bigLuggages += midLuggages ~/ 2;
        midLuggages = 0;
      } else {
        bigLuggages += midLuggages ~/ 2;
        midLuggages = 1;
      }

      if (skiBoard != 0 || surfboard != 0 || bicycle != 0) {
        emit(SwitchToVanMandatoryState());
        return;
      }
      if (adult + child + infant + cats + dogs > maxCapacityPassenger) {
        emit(SwitchToVanMandatoryState());
        return;
      }
      if (bigLuggages > maxCapacityBigLuggages) {
        emit(SwitchToVanMandatoryState());
        return;
      }
      if (midLuggages > maxCapacityMediumLuggages) {
        emit(SwitchToVanMandatoryState());
        return;
      }
      if (bigLuggages == maxCapacityBigLuggages && midLuggages == maxCapacityMediumLuggages && smallLuggages > 0) {
        emit(SwitchToVanMandatoryState());
        return;
      }

      if (adult + child + infant + cats + dogs == maxCapacityPassenger) {
        emit(SwitchToVanOptionalState());
        return;
      }
    }
  }
  void checkCapacityOfSedanRoundTrip(){
    if(vehicleTypeRoundTrip == 'sedan') {
      int maxCapacityPassenger = 4;
      int maxCapacityBigLuggages = 3;
      int maxCapacityMediumLuggages = 1;

      int bigLuggages = 0;
      int midLuggages = 0;
      int smallLuggages = 0;

      bigLuggages += golfRoundTrip;
      bigLuggages += bigRoundTrip;
      smallLuggages += smallRoundTrip;
      midLuggages += mediumRoundTrip;

      if(smallLuggages % 2 == 0) {
        midLuggages += smallRoundTrip ~/ 2;
        smallLuggages = 0;
      } else {
        midLuggages += smallRoundTrip ~/ 2;
        smallLuggages = 1;
      }

      if(midLuggages % 2 == 0) {
        bigLuggages += midLuggages ~/ 2;
        midLuggages = 0;
      } else {
        bigLuggages += midLuggages ~/ 2;
        midLuggages = 1;
      }

      if (skiBoardRoundTrip != 0 || surfboardRoundTrip != 0 || bicycleRoundTrip != 0) {
        emit(SwitchToVanMandatoryRoundTripState());
        return;
      }
      if (adultRoundTrip + childRoundTrip + infantRoundTrip + catsRoundTrip + dogsRoundTrip > maxCapacityPassenger) {
        emit(SwitchToVanMandatoryRoundTripState());
        return;
      }
      if (bigLuggages > maxCapacityBigLuggages) {
        emit(SwitchToVanMandatoryRoundTripState());
        return;
      }
      if (midLuggages > maxCapacityMediumLuggages) {
        emit(SwitchToVanMandatoryRoundTripState());
        return;
      }
      if (bigLuggages == maxCapacityBigLuggages && midLuggages == maxCapacityMediumLuggages && smallLuggages > 0) {
        emit(SwitchToVanMandatoryRoundTripState());
        return;
      }

      if (adultRoundTrip + childRoundTrip + infantRoundTrip + catsRoundTrip + dogsRoundTrip == maxCapacityPassenger) {
        emit(SwitchToVanOptionalRoundTripState());
        return;
      }
    }
  }

  bool checkCapacity(){
    int maxCapacityPassenger = 8;
    int maxCapacityBigLuggages = 8;
    int maxCapacityPets = 2;

    int bigLuggages = 0;
    int midLuggages = 0;
    int smallLuggages = 0;

    int pets = 0;

    int passengers = 0;

    pets += tempCats;
    pets += tempDogs;

    passengers += tempAdult;
    passengers += tempChild;
    passengers += tempInfant;
    passengers += pets;

    bigLuggages += tempGolf;
    bigLuggages += 4*tempBicycle;
    bigLuggages += 2*tempSkiBoard;
    bigLuggages += 2*tempSurfboard;

    bigLuggages += tempBig;
    smallLuggages += tempSmall;
    midLuggages += tempMedium;

    if(smallLuggages % 2 == 0) {
      midLuggages += tempSmall ~/ 2;
      smallLuggages = 0;
    } else {
      midLuggages += tempSmall ~/ 2;
      smallLuggages = 1;
    }

    if(midLuggages % 2 == 0) {
      bigLuggages += midLuggages ~/ 2;
      midLuggages = 0;
    } else {
      bigLuggages += midLuggages ~/ 2;
      midLuggages = 1;
    }

    if(midLuggages != 0 || smallLuggages != 0) {
      bigLuggages += 1;
      midLuggages = 0;
      smallLuggages = 0;
    }

    if (bigLuggages > maxCapacityBigLuggages) {
      return false;
    }

    if (pets > maxCapacityPets) {
      return false;
    }

    if (passengers > maxCapacityPassenger) {
      return false;
    }

    return true;
  }
  bool checkCapacityRoundTrip(){
    int maxCapacityPassenger = 8;
    int maxCapacityBigLuggages = 8;
    int maxCapacityPets = 2;

    int bigLuggages = 0;
    int midLuggages = 0;
    int smallLuggages = 0;

    int pets = 0;

    int passengers = 0;

    pets += tempCatsRoundTrip;
    pets += tempDogsRoundTrip;

    passengers += tempAdultRoundTrip;
    passengers += tempChildRoundTrip;
    passengers += tempInfantRoundTrip;
    passengers += pets;

    bigLuggages += tempGolfRoundTrip;
    bigLuggages += 4*tempBicycleRoundTrip;
    bigLuggages += 2*tempSkiBoardRoundTrip;
    bigLuggages += 2*tempSurfboardRoundTrip;

    bigLuggages += tempBigRoundTrip;
    smallLuggages += tempSmallRoundTrip;
    midLuggages += tempMediumRoundTrip;

    if(smallLuggages % 2 == 0) {
      midLuggages += tempSmallRoundTrip ~/ 2;
      smallLuggages = 0;
    } else {
      midLuggages += tempSmallRoundTrip ~/ 2;
      smallLuggages = 1;
    }

    if(midLuggages % 2 == 0) {
      bigLuggages += midLuggages ~/ 2;
      midLuggages = 0;
    } else {
      bigLuggages += midLuggages ~/ 2;
      midLuggages = 1;
    }

    if(midLuggages != 0 || smallLuggages != 0) {
      bigLuggages += 1;
      midLuggages = 0;
      smallLuggages = 0;
    }

    if (bigLuggages > maxCapacityBigLuggages) {
      return false;
    }

    if (pets > maxCapacityPets) {
      return false;
    }

    if (passengers > maxCapacityPassenger) {
      return false;
    }

    return true;
  }

  void checkIfTimeDateIsEnable(TimeOfDay time, bool firstTrip) {
    if (firstTrip) {
      if (!(DateTime(date.year,date.month,date.day,time.hour,time.minute).isAfter(DateTime.now().add(const Duration(minutes: 10))))) {
        updateStateLessPageVar(change: () {
          notLateTimeError = true;
        },);//changeTime(value: TimeOfDay(hour: DateTime.now().add(const Duration(minutes: 10)).hour, minute: DateTime.now().add(const Duration(minutes: 10)).minute));
      } else {
        updateStateLessPageVar(change: () {
          notLateTimeError = false;
        },);
      }
    } else {
      if (!(DateTime(dateRoundTrip.year,dateRoundTrip.month,dateRoundTrip.day,time.hour,time.minute).isAfter(DateTime.now().add(const Duration(minutes: 10))))) {
        updateStateLessPageVar(change: () {
          notLateTimeErrorRoundTrip = true;
        },);//changeTime(value: TimeOfDay(hour: DateTime.now().add(const Duration(minutes: 10)).hour, minute: DateTime.now().add(const Duration(minutes: 10)).minute));
      } else {
        updateStateLessPageVar(change: () {
          notLateTimeErrorRoundTrip = false;
        },);
      }
    }
  }
  void checkIfTimeDateRoundTripIsEnable() {
    if (roundTrip) {
      if (!(DateTime(dateRoundTrip.year,dateRoundTrip.month,dateRoundTrip.day,timeRoundTrip.hour,timeRoundTrip.minute).isAfter(DateTime(date.year,date.month,date.day,time.hour,time.minute)))) {
        updateStateLessPageVar(change: () {
          firstTimeNotBeforeRoundTripTimeError = true;
        },);
      } else {
        updateStateLessPageVar(change: () {
          firstTimeNotBeforeRoundTripTimeError = false;
        },);
      }
    } else {
      if (!(DateTime(dateRoundTrip.year,dateRoundTrip.month,dateRoundTrip.day,time.hour,time.minute).isAfter(DateTime.now().add(const Duration(minutes: 10))))) {
        updateStateLessPageVar(change: () {
          notLateTimeErrorRoundTrip = true;
        },);//changeTime(value: TimeOfDay(hour: DateTime.now().add(const Duration(minutes: 10)).hour, minute: DateTime.now().add(const Duration(minutes: 10)).minute));
      } else {
        updateStateLessPageVar(change: () {
          notLateTimeErrorRoundTrip = false;
        },);
      }
    }
  }
  void checkIfNewTimeDateIsEnable() {
    if (!(DateTime(newDate.year,newDate.month,newDate.day,newTime.hour,newTime.minute).isAfter(DateTime.now().add(const Duration(minutes: 10))))) {
      updateStateLessPageVar(change: () {
        notLateNewTimeError = true;
      },);//changeTime(value: TimeOfDay(hour: DateTime.now().add(const Duration(minutes: 10)).hour, minute: DateTime.now().add(const Duration(minutes: 10)).minute));
    } else {
      updateStateLessPageVar(change: () {
        notLateNewTimeError = false;
      },);
    }
  }

  void getTaxiPrices(){
    emit(LoadingBookPricesState());
    Map<String, dynamic> queryParams = {
      'cats_count': cats,
      'dogs_count': dogs,
      'surfboards_count': surfboard,
      'skis_count': skiBoard,
      'bikes_count': bicycle,
      'golfs_count': golf,
      'snowboards_count': 0,
      'passengers': adult + child + infant,
      'luggages': big + medium + small,
      'pickupLat': pickUpAddressLat.toStringAsFixed(6),
      'pickupLng': pickUpAddressLng.toStringAsFixed(6),
      'dropoffLat': dropOffAddressLat.toStringAsFixed(6),
      'dropoffLng': dropOffAddressLng.toStringAsFixed(6),
      'pickupTime': date.microsecondsSinceEpoch ~/ 1000,
    };
    print(queryParams);
    Map<String, String> stringQueryParams = queryParams.map((key, value) => MapEntry(key, value.toString()));
    BookTaxiRepository.getTaxiPrices(queryParams: stringQueryParams,).then((value){
      if(value['statusCode'] >= 200 && value['statusCode'] < 300){
        debugPrint('Success Get Prices');
        prices.clear();
        Map<String, dynamic> fareData = value['fare_data'];
        fareData.forEach((key, value) {
          String type = key.contains('van') ? 'van' : 'sedan';
          int passengers = type == 'van' ? int.parse(key.replaceAll(RegExp(r'[^0-9]'), '')) : 4;
          Map<String, dynamic> fareEntry = {
            'type': type,
            'passengers': passengers,
            'price': value
          };
          if(fareEntry['passengers'] >= adult + child + infant + cats + dogs) {
            if(!(fareEntry['type'] == 'sedan' && vehicleType == 'van')) {
              prices.add(fareEntry);
            }
          }
        });
        emit(SuccessBookPricesState());
        debugPrint('Success Get Prices');
      }else{
        emit(FiledBookPricesState());
        debugPrint('Filed Get Prices');
        debugPrint(value.toString());
      }
    }).onError((error, stackTrace){
      debugPrint('Error Get Prices ${error.toString()}');
      emit(ErrorBookPricesState());
    });
    emit(AnyState());
  }
  void getTaxiPricesRoundTrip(){
    emit(LoadingBookPricesRoundTripState());
    Map<String, dynamic> queryParams = {
      'cats_count': catsRoundTrip,
      'dogs_count': dogsRoundTrip,
      'surfboards_count': surfboardRoundTrip,
      'skis_count': skiBoardRoundTrip,
      'bikes_count': bicycleRoundTrip,
      'golfs_count': golfRoundTrip,
      'snowboards_count': 0,
      'passengers': adultRoundTrip + childRoundTrip + infantRoundTrip,
      'luggages': bigRoundTrip + mediumRoundTrip + smallRoundTrip,
      'pickupLat': pickUpAddressLat.toStringAsFixed(6),
      'pickupLng': pickUpAddressLng.toStringAsFixed(6),
      'dropoffLat': dropOffAddressLat.toStringAsFixed(6),
      'dropoffLng': dropOffAddressLng.toStringAsFixed(6),
      'pickupTime': dateRoundTrip.microsecondsSinceEpoch ~/ 1000,
    };
    Map<String, String> stringQueryParams = queryParams.map((key, value) => MapEntry(key, value.toString()));
    BookTaxiRepository.getTaxiPrices(queryParams: stringQueryParams,).then((value){
      if(value['statusCode'] >= 200 && value['statusCode'] < 300){
        pricesRoundTrip.clear();
        Map<String, dynamic> fareData = value['fare_data'];
        fareData.forEach((key, value) {
          String type = key.contains('van') ? 'van' : 'sedan';
          int passengers = type == 'van' ? int.parse(key.replaceAll(RegExp(r'[^0-9]'), '')) : 4;
          Map<String, dynamic> fareEntry = {
            'type': type,
            'passengers': passengers,
            'price': value
          };
          if(fareEntry['passengers'] >= adultRoundTrip + childRoundTrip + infantRoundTrip + catsRoundTrip + dogsRoundTrip) {
            if(!(fareEntry['type'] == 'sedan' && vehicleTypeRoundTrip == 'van')) {
              pricesRoundTrip.add(fareEntry);
            }
          }
        });
        emit(SuccessBookPricesRoundTripState());
        debugPrint('Success Get Prices');
      }else{
        emit(FiledBookPricesRoundTripState());
        debugPrint('Filed Get Prices');
        debugPrint(value.toString());
      }
    }).onError((error, stackTrace){
      debugPrint('Error Get Prices ${error.toString()}');
      emit(ErrorBookPricesRoundTripState());
    });
    emit(AnyState());
  }

  void bookTaxiWithFixedPrice(){
    emit(LoadingBookTaxiState());
    String token = SharedPreferencesServices.getData(key: ConstantData.kToken)??'';
    Map<String, dynamic> body = {
      'departureLocation': pickUpAddress,
      'arrivalLocation': dropOffAddress,
      'departureDateTime': date.copyWith(hour: time.hour, minute: time.minute, microsecond: 0, millisecond: 0, second: 0).toString(),
      'roundTrip':roundTrip,
      'vehicleType': vehicleType.toLowerCase(),
      'payment': payment,
      'passengerCount': {
        'adult': adult,
        'enfants': infant,
        'children': child,
      },
      'luggage': {
        'large': big,
        'medium': medium,
        'small': small
      },
      'pets': {
        'cats': cats,
        'dogs': dogs
      },
      'specialLuggage': {
        'surfboard': surfboard,
        'ski': skiBoard,
        'golf': golf,
        'bicycle': bicycle
      },
      'price': price,
      'pricingMethod': pricingMethod,
      'invoiceNeeded': invoice && isSchedule() && payment == 'card_online',
      if(payment == 'card_online')'number': number,
      if(payment == 'card_online')'month': month,
      if(payment == 'card_online')'year': year,
      if(payment == 'card_online')'cvc': cvc,
      if(roundTrip)'returnTripDetails': {
        'price': priceRoundTrip,
        'departureDateTime': dateRoundTrip.copyWith(hour: timeRoundTrip.hour, minute: timeRoundTrip.minute, microsecond: 0, millisecond: 0, second: 0).toString(),
        'vehicleType': vehicleTypeRoundTrip,
        'passengerCount': {
          'adult': adultRoundTrip,
          'enfants': infantRoundTrip,
          'children': childRoundTrip,
        },
        'luggage': {
          'large': bigRoundTrip,
          'medium': mediumRoundTrip,
          'small': smallRoundTrip
        },
        'pets': {
          'cats': catsRoundTrip,
          'dogs': dogsRoundTrip
        },
        'specialLuggage': {
          'surfboard': surfboardRoundTrip,
          'ski': skiBoardRoundTrip,
          'golf': golfRoundTrip,
          'bicycle': bicycleRoundTrip
        }
      },
      if(invoice && isSchedule() && payment == 'card_online')'invoiceDetails': {
        'isCompany': isCompany,
        if(isCompany)'companyName': companyName,
        if(isCompany)'username': username,
        if(isCompany)'courtesyTitles': '$courtesyTitles.',
        'address': address,
        if(!isCompany)'firstName': firstName,
        if(!isCompany)'lastName': lastName,
      }
    };
    BookTaxiRepository.bookTaxiWithFixedPrice(body: body, token: token).then((value){
      if(value['statusCode'] >= 200 && value['statusCode'] < 300){
        
        if (invoice) {
          createInvoiceForCardOnBoardAndCash(id: value['data']['_id']);
        }
        emit(SuccessBookTaxiState());
        debugPrint('Success Book Taxi');
      }else{
        if(value['message'].toString().contains('card') || value['message'].toString().contains('payment')) {
          emit(FiledPaymentBookTaxiState());
        } else if(value['message'].toString().contains('already exists')) {

          emit(AlreadyExistsBookErrorState(id: value['message'].toString().replaceAll('Booking already exists with id ', '')));
          debugPrint('Book already exists');
          return;
        } else {
          emit(FiledBookTaxiState());
          debugPrint('Filed Book Taxi');
        }
        debugPrint(value.toString());
      }
    }).onError((error, stackTrace){
      debugPrint('Error Book Taxi ${error.toString()}');
      emit(ErrorBookTaxiState());
    });
    emit(AnyState());
  }
  void bookTaxiWithFlexiblePrice(){
    emit(LoadingBookTaxiState());
    String token = SharedPreferencesServices.getData(key: ConstantData.kToken)??'';
    Map<String, dynamic> body = {
      'departureLocation': pickUpAddress,
      'arrivalLocation': dropOffAddress,
      'departureDateTime': date.copyWith(hour: time.hour, minute: time.minute, microsecond: 0, millisecond: 0, second: 0).toString(),
      'roundTrip':roundTrip,
      'vehicleType': vehicleType.toLowerCase(),
      'payment': payment,
      'passengerCount': {
        'adult': adult,
        'enfants': infant,
        'children': child,
      },
      'luggage': {
        'large': big,
        'medium': medium,
        'small': small
      },
      'pets': {
        'cats': cats,
        'dogs': dogs
      },
      'specialLuggage': {
        'surfboard': surfboard,
        'ski': skiBoard,
        'golf': golf,
        'bicycle': bicycle
      },
      'price': price,
      'pricingMethod': pricingMethod,
      'invoiceNeeded': false,
      if(roundTrip)'returnTripDetails': {
        'price': 0,
        'departureDateTime': dateRoundTrip.copyWith(hour: timeRoundTrip.hour, minute: timeRoundTrip.minute, microsecond: 0, millisecond: 0, second: 0).toString(),
        'vehicleType': vehicleTypeRoundTrip,
        'passengerCount': {
          'adult': adultRoundTrip,
          'enfants': infantRoundTrip,
          'children': childRoundTrip,
        },
        'luggage': {
          'large': bigRoundTrip,
          'medium': mediumRoundTrip,
          'small': smallRoundTrip
        },
        'pets': {
          'cats': catsRoundTrip,
          'dogs': dogsRoundTrip
        },
        'specialLuggage': {
          'surfboard': surfboardRoundTrip,
          'ski': skiBoardRoundTrip,
          'golf': golfRoundTrip,
          'bicycle': bicycleRoundTrip
        }
      },
    };
    BookTaxiRepository.bookTaxiWithFlexiblePrice(body: body, token: token).then((value){
      if(value['statusCode'] >= 200 && value['statusCode'] < 300){
        bookingID = value['data']['_id'];
        Map<String, dynamic> body = {
          'booking': value['data']['_id'],
          'price': price,
        };
        BookTaxiRepository.createBookOfferForFlexiblePrice(body: body, token: token).then((value){
          if(value['statusCode'] >= 200 && value['statusCode'] < 300){
            emit(SuccessBookTaxiState());
            debugPrint('Success Book Taxi');
          } else if(value['message'].toString().contains('already exists')) {
            emit(AlreadyExistsBookErrorState(id: value['message'].toString().replaceAll('Booking already exists with id ', '')));
            debugPrint('Book already exists');
            return;
          } else{
            emit(FiledBookTaxiState());
            debugPrint('Filed Book Taxi');
            debugPrint(value.toString());
          }
        }).onError((error, stackTrace){
          debugPrint('Error Book Taxi ${error.toString()}');
          emit(ErrorBookTaxiState());
        });
      }else{
        emit(FiledBookTaxiState());
        debugPrint('Filed Book Taxi');
        debugPrint(value.toString());
      }
    }).onError((error, stackTrace){
      debugPrint('Error Book Taxi ${error.toString()}');
      emit(ErrorBookTaxiState());
    });
    emit(AnyState());
  }
  void saveUnCompleteBook(){
    emit(LoadingBookTaxiState());
    String token = SharedPreferencesServices.getData(key: ConstantData.kToken)??'';
    Map<String, dynamic> body = {
      'departureLocation': pickUpAddress,
      'arrivalLocation': dropOffAddress,
      'departureDateTime': date.copyWith(hour: time.hour, minute: time.minute, microsecond: 0, millisecond: 0, second: 0).toString(),
      'vehicleType': vehicleType.toLowerCase(),
      'passengerCount': {
        'adult': adult,
        'enfants': infant,
        'children': child,
      },
      'luggage': {
        'large': big,
        'medium': medium,
        'small': small
      },
      'pets': {
        'cats': cats,
        'dogs': dogs
      },
      'specialLuggage': {
        'surfboard': surfboard,
        'ski': skiBoard,
        'golf': golf,
        'bicycle': bicycle
      },
      'price': price,
      'pricingMethod': pricingMethod,
      'payment': payment,
    };
    BookTaxiRepository.saveUnCompleteBook(body: body, token: token,).then((value){
      if(value['statusCode'] >= 200 && value['statusCode'] < 300){

        emit(SuccessSaveUnCompleteBookTaxiState());
        debugPrint('Success Save Un Complete Book Taxi');
      }else{
        emit(FiledSaveUnCompleteBookTaxiState());
        debugPrint('Filed Save Un Complete Book Taxi');
        debugPrint(value.toString());
      }
    }).onError((error, stackTrace){
      debugPrint('Error Save Un Complete Book Taxi ${error.toString()}');
      emit(ErrorSaveUnCompleteBookTaxiState());
    });
    emit(AnyState());
  }
  void completeBook(){
    emit(LoadingBookTaxiState());
    String token = SharedPreferencesServices.getData(key: ConstantData.kToken)??'';
    Map<String, dynamic> body = {
      'departureLocation': pickUpAddress,
      'arrivalLocation': dropOffAddress,
      'departureDateTime': date.copyWith(hour: time.hour, minute: time.minute, microsecond: 0, millisecond: 0, second: 0).toString(),
      'roundTrip':roundTrip,
      'vehicleType': vehicleType.toLowerCase(),
      'payment': payment,
      'passengerCount': {
        'adult': adult,
        'enfants': infant,
        'children': child,
      },
      'luggage': {
        'large': big,
        'medium': medium,
        'small': small
      },
      'pets': {
        'cats': cats,
        'dogs': dogs
      },
      'specialLuggage': {
        'surfboard': surfboard,
        'ski': skiBoard,
        'golf': golf,
        'bicycle': bicycle
      },
      'price': price,
      'pricingMethod': pricingMethod,
      'invoiceNeeded': invoice && isSchedule() && payment == 'card_online',
      if(payment == 'card_online')'number': number,
      if(payment == 'card_online')'month': month,
      if(payment == 'card_online')'year': year,
      if(payment == 'card_online')'cvc': cvc,
      if(roundTrip)'returnTripDetails': {
        'price': 0,
        'departureDateTime': dateRoundTrip.copyWith(hour: timeRoundTrip.hour, minute: timeRoundTrip.minute, microsecond: 0, millisecond: 0, second: 0).toString(),
        'vehicleType': vehicleTypeRoundTrip,
        'passengerCount': {
          'adult': adultRoundTrip,
          'enfants': infantRoundTrip,
          'children': childRoundTrip,
        },
        'luggage': {
          'large': bigRoundTrip,
          'medium': mediumRoundTrip,
          'small': smallRoundTrip
        },
        'pets': {
          'cats': catsRoundTrip,
          'dogs': dogsRoundTrip
        },
        'specialLuggage': {
          'surfboard': surfboardRoundTrip,
          'ski': skiBoardRoundTrip,
          'golf': golfRoundTrip,
          'bicycle': bicycleRoundTrip
        }
      },
      if(invoice && isSchedule() && payment == 'card_online')'invoiceDetails': {
        'isCompany': isCompany,
        if(isCompany)'companyName': companyName,
        if(isCompany)'username': username,
        if(isCompany)'courtesyTitles': '$courtesyTitles.',
        'address': address,
        if(!isCompany)'firstName': firstName,
        if(!isCompany)'lastName': lastName,
      }
    };
    BookTaxiRepository.completeBook(body: body, token: token, id: idUncompletedBook).then((value){
      if(value['statusCode'] >= 200 && value['statusCode'] < 300){

        if (invoice) {
          createInvoiceForCardOnBoardAndCash(id: value['data']['_id']);
        }

        emit(SuccessBookTaxiState());
        debugPrint('Success Book Taxi');
      }else{
        if(value['message'].toString().contains('already exists')) {
          emit(AlreadyExistsBookErrorState(id: value['message'].toString().replaceAll('Booking already exists with id ', '')));
          debugPrint('Book already exists');
        } else {
          emit(FiledBookTaxiState());
          debugPrint('Filed Book Taxi');
          debugPrint(value.toString());
        }
      }
    }).onError((error, stackTrace){
      debugPrint('Error Book Taxi ${error.toString()}');
      emit(ErrorBookTaxiState());
    });
    emit(AnyState());
  }
  void getOfferDetailsByOfferID({required String id}){
    emit(LoadingOfferState());
    String token = SharedPreferencesServices.getData(key: ConstantData.kToken)??'';
    BookTaxiRepository.getOfferDetailsByOfferID(id: id, token: token).then((value){
      if(value['statusCode'] >= 200 && value['statusCode'] < 300){
        offer = OfferModel.fromJson(value['data']);
        getBookingDetails(id: offer!.bookingId!);

        emit(SuccessOfferState());
        debugPrint('Success Get Offer Details');
      }else{
        emit(FiledOfferState());
        debugPrint('Filed Get Offer Details');
        debugPrint(value.toString());
      }
    }).onError((error, stackTrace){
      debugPrint('Error Get Offer Details ${error.toString()}');
      emit(ErrorOfferState());
    });
    emit(AnyState());
  }
  void getOffersByBookingID({required String id}){
    emit(LoadingOffersState());
    String token = SharedPreferencesServices.getData(key: ConstantData.kToken)??'';
    BookTaxiRepository.getOffersByBookingID(id: id, token: token).then((value){
      if(value['statusCode'] >= 200 && value['statusCode'] < 300){
        for(int i = 0; i < value['data'].length; i++){
          OfferModel offer = OfferModel.fromJson(value['data'][i]);
          offers.add(offer);
        }
        offer = OfferModel.fromJson(value);
        emit(SuccessOffersState());
        debugPrint('Success Get Offers');
      }else{
        emit(FiledOffersState());
        debugPrint('Filed Get Offers');
        debugPrint(value.toString());
      }
    }).onError((error, stackTrace){
      debugPrint('Error Get Offers ${error.toString()}');
      emit(ErrorOffersState());
    });
    emit(AnyState());
  }
  void getBookingDetails({required String id}){
    emit(LoadingBookingDetailsState());
    String token = SharedPreferencesServices.getData(key: ConstantData.kToken)??'';
    BookTaxiRepository.getBookingDetails(id: id, token: token).then((value){
      if(value['statusCode'] >= 200 && value['statusCode'] < 300){
        bookingDetails = BookingModel.fromJson(value['data']);

        emit(SuccessBookingDetailsState());
        debugPrint('Success Get Booking Details');
      }else{
        emit(FiledBookingDetailsState());
        debugPrint('Filed Get Booking Details');
        debugPrint(value.toString());
      }
    }).onError((error, stackTrace){
      debugPrint('Error Get Booking Details ${error.toString()}');
      emit(ErrorBookingDetailsState());
    });
    emit(AnyState());
  }
  void acceptOffer({required String id}){
    emit(SendingOfferAcceptState());
    String token = SharedPreferencesServices.getData(key: ConstantData.kToken)??'';
    BookTaxiRepository.sendAcceptOffer(id: id, token: token).then((value){
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
  void rejectOffer({required String id}){
    emit(SendingOfferAcceptState());
    String token = SharedPreferencesServices.getData(key: ConstantData.kToken)??'';
    BookTaxiRepository.sendRejectOffer(id: id, token: token).then((value){
      if(value['statusCode'] >= 200 && value['statusCode'] < 300){
        emit(SuccessOfferRejectState());
        debugPrint('Success Offer Reject');
      }else{
        emit(FiledOfferRejectState());
        debugPrint('Filed Offer Reject');
        debugPrint(value.toString());
      }
    }).onError((error, stackTrace){
      debugPrint('Error Offer Reject ${error.toString()}');
      emit(ErrorOfferRejectState());
    });
    emit(AnyState());
  }
  void getTicketDetails({required String id}){
    emit(LoadingTicketState());
    String token = SharedPreferencesServices.getData(key: ConstantData.kToken)??'';
    BookTaxiRepository.getTicketDetails(id: id, token: token).then((value){
      if(value['statusCode'] >= 200 && value['statusCode'] < 300){
        ticket = TicketModel.fromJson(value);
        emit(SuccessTicketState());
        debugPrint('Success Get Ticket Details');
      }else{
        emit(FiledTicketState());
        debugPrint('Filed Get Ticket Details');
        debugPrint(value.toString());
      }
    }).onError((error, stackTrace){
      debugPrint('Error Get Ticket Details ${error.toString()}');
      emit(ErrorTicketState());
    });
    emit(AnyState());
  }
  void cancelRequest({required String id}){
    emit(LoadingCancelRequestState());
    String token = SharedPreferencesServices.getData(key: ConstantData.kToken)??'';
    BookTaxiRepository.cancelRequest(id: id, token: token, reason: cancelReason).then((value){
      if(value['statusCode'] >= 200 && value['statusCode'] < 300){
        emit(SuccessCancelRequestState());
        debugPrint('Success Cancel Request Details');
      }else{
        emit(FiledCancelRequestState());
        debugPrint('Filed Cancel Request Details');
        debugPrint(value.toString());
      }
    }).onError((error, stackTrace){
      debugPrint('Error Cancel Request Details ${error.toString()}');
      emit(ErrorCancelRequestState());
    });
    emit(AnyState());
  }
  void createInvoiceForCardOnBoardAndCash({required String id}){
    emit(LoadingCreateInvoiceState());
    String token = SharedPreferencesServices.getData(key: ConstantData.kToken)??'';
    BookTaxiRepository.createInvoiceForCardOnBoardAndCash(id: id, token: token, body: {
      'isCompany': isCompany,
      if(isCompany)'companyName': companyName,
      if(isCompany)'username': username,
      if(isCompany)'courtesyTitles': '$courtesyTitles.',
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
  void rebook({required String id}){
    emit(LoadingRebookState());
    String token = SharedPreferencesServices.getData(key: ConstantData.kToken)??'';

    BookTaxiRepository.rebook(id: id, token: token, newDate: newDate.copyWith(hour: newTime.hour, minute: newTime.minute)).then((value){
      if(value['statusCode'] >= 200 && value['statusCode'] < 300){

        emit(SuccessRebookState());
        debugPrint('Success Rebook');
      }else{
        if(value['message'].toString().contains('already exists')) {
          emit(AlreadyExistsBookErrorState(id: value['message'].toString().replaceAll('Booking already exists with id ', '')));
          debugPrint('Book already exists');
        } else {
          emit(FiledRebookState());
          debugPrint('Filed Rebook');
        }
      }
    }).onError((error, stackTrace){
      debugPrint('Error Rebook ${error.toString()}');
      emit(ErrorRebookState());
    });
    emit(AnyState());
  }

  void reset(){
    flexiblePriceError = false;
    flexiblePriceWarning = false;
    notLateTimeError = false;
    notLateTimeErrorRoundTrip = false;
    firstTimeNotBeforeRoundTripTimeError = false;
    pickUpAddressError = false;
    dropOffAddressError = false;
    priceLoaded = false;
    priceRoundTripLoaded = false;
    cardType = '';
    cancelReason = LocaleKeys.kPriceIsExpensive.tr();
    tempIsCompany = false;
    tempCourtesyTitles = '';
    offerLoaded = false;
    ticketLoaded = false;
    offerAcceptSanded = true;
    offerRejectSanded = true;
    bookingRequestSanded = true;
    cancelingRequestSanded = true;
    tempCompanyName = '';
    tempUsername = '';
    tempAddress = '';
    tempFirstName = '';
    tempLastName = '';
    tempCardholdersName = '';
    tempNumber = '';
    tempCvc = '';
    tempMonth = '';
    tempYear = '';
    tempAdult = 0;
    tempChild = 0;
    tempInfant = 0;
    tempCats = 0;
    tempDogs = 0;
    tempBig = 0;
    tempMedium = 0;
    tempSmall = 0;
    tempSurfboard = 0;
    tempSkiBoard = 0;
    tempGolf = 0;
    tempBicycle = 0;
    tempAdditionalPageIndex = 0;
    tempAddDateTimePageIndex = 0;
    tempAdultRoundTrip = 0;
    tempChildRoundTrip = 0;
    tempInfantRoundTrip = 0;
    tempCatsRoundTrip = 0;
    tempDogsRoundTrip = 0;
    tempBigRoundTrip = 0;
    tempMediumRoundTrip = 0;
    tempSmallRoundTrip = 0;
    tempSurfboardRoundTrip = 0;
    tempSkiBoardRoundTrip = 0;
    tempGolfRoundTrip = 0;
    tempBicycleRoundTrip = 0;
    validPassengers = null;
    validPassengersRoundTrip = null;
    viewPricePressed = false;
    tempPickUpAddress = '';
    tempDropOffAddress = '';
    tempPickUpAddressLat = 0;
    tempPickUpAddressLng = 0;
    tempDropOffAddressLat = 0;
    tempDropOffAddressLng = 0;
    selectedRecentPlacePickUpAddress = -1;
    selectedRecentPlaceDropOffAddress = -1;
    tempFocusedDate = DateTime.now();
    tempFocusedDateRoundTrip = DateTime.now();
    tempSelectedDate = DateTime.now();
    tempSelectedDateRoundTrip = DateTime.now();
    tempSelectedTime = TimeOfDay.now();
    tempSelectedTimeRoundTrip = TimeOfDay.now();
    bookingID = '';
    sendingInAddAddressViewYourLocation = false;
    sendingInAddAddressViewSaveLocation = false;
    selectedPriceNumber = -1;
    selectedPriceNumberRoundTrip = -1;

    idUncompletedBook = '';
    vehicleType = 'sedan';
    vehicleTypeRoundTrip = 'sedan';
    pickUpAddress = '';
    dropOffAddress = '';
    comments = '';
    commentsRoundTrip = '';
    flightNumber = '';
    flightNumberRoundTrip = '';
    pricingMethod = 'fixed';
    payment = 'cash';
    number = '';
    cvc = '';
    month = '';
    year = '';
    companyName = '';
    username = '';
    courtesyTitles = '';
    address = '';
    firstName = '';
    lastName = '';
    roundTrip = false;
    invoice = false;
    lockInvoice = false;
    isCompany = false;
    pickUpAddressLat = 0;
    pickUpAddressLng = 0;
    dropOffAddressLat = 0;
    dropOffAddressLng = 0;
    adult = 0;
    adultRoundTrip = 0;
    child = 0;
    childRoundTrip = 0;
    infant = 0;
    infantRoundTrip = 0;
    cats = 0;
    catsRoundTrip = 0;
    dogs = 0;
    dogsRoundTrip = 0;
    big = 0;
    bigRoundTrip = 0;
    medium = 0;
    mediumRoundTrip = 0;
    small = 0;
    smallRoundTrip = 0;
    surfboard = 0;
    surfboardRoundTrip = 0;
    skiBoard = 0;
    skiBoardRoundTrip = 0;
    golf = 0;
    golfRoundTrip = 0;
    bicycle = 0;
    bicycleRoundTrip = 0;
    price = 0;
    priceRoundTrip = 0;
    date = DateTime.now();
    dateRoundTrip = DateTime.now();
    time = TimeOfDay.now();
    timeRoundTrip = TimeOfDay.now();
    dateTimeSelected = false;
    dateTimeSelectedRoundTrip = false;
    prices = [];
    pricesRoundTrip = [];
    offer = null;
    bookingDetails = null;
    offers = [];
    ticket = null;
    emit(ChangeBookValue());
    emit(AnyState());
  }
}