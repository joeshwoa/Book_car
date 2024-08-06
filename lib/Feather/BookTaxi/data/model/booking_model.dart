import 'package:public_app/Core/unit/constant_data.dart';
import 'package:public_app/Feather/BookTaxi/data/model/offer_model.dart';

class BookingModel{
  String? id;
  int? small;
  int? medium;
  int? large;
  int? numberOfLuggages;
  int? cats;
  int? dogs;
  int? numberOfPets;
  int? golf;
  int? surfboard;
  int? ski;
  int? bicycle;
  int? numberOfSpecialLuggages;
  int? adult;
  int? children;
  int? enfants;
  int? numberOfPassengers;
  String? departureLocation;
  String? arrivalLocation;
  DateTime? departureDateTime;
  TaxiType? vehicleType;
  int? price;
  String? pricingMethod;
  Payment? payment;
  Status? status;
  bool? roundTrip;
  List<OfferModel>? bookingOffers;
  TimeState? timeState;


  BookingModel(
      {this.id,
        this.small,
        this.medium,
        this.large,
        this.numberOfLuggages,
        this.cats,
        this.dogs,
        this.numberOfPets,
        this.golf,
        this.surfboard,
        this.ski,
        this.bicycle,
        this.numberOfSpecialLuggages,
        this.adult,
        this.children,
        this.enfants,
        this.numberOfPassengers,
        this.departureLocation,
        this.arrivalLocation,
        this.departureDateTime,
        this.vehicleType,
        this.price,
        this.pricingMethod,
        this.payment,
        this.status,
        this.roundTrip,
        this.bookingOffers,
        this.timeState});

  factory BookingModel.fromJson(data, {TimeState? timeState}){
    return BookingModel(
      id: data['_id'],
      small: data['luggage']['small'],
      medium: data['luggage']['medium'],
      large: data['luggage']['large'],
      numberOfLuggages: data['luggage']['small'] + data['luggage']['medium'] + data['luggage']['large'],
      cats: data['pets']['cats'],
      dogs: data['pets']['dogs'],
      numberOfPets: data['pets']['cats'] + data['pets']['dogs'],
      golf: data['specialLuggage']['golf'],
      surfboard: data['specialLuggage']['surfboard'],
      ski: data['specialLuggage']['ski'],
      bicycle: data['specialLuggage']['bicycle'],
      numberOfSpecialLuggages: data['specialLuggage']['golf'] + data['specialLuggage']['surfboard'] + data['specialLuggage']['ski'] + data['specialLuggage']['bicycle'],
      adult: data['passengerCount']['adult'],
      children: data['passengerCount']['children'],
      enfants: data['passengerCount']['enfants'],
      numberOfPassengers: data['passengerCount']['adult'] + data['passengerCount']['children'] + data['passengerCount']['enfants'],
      departureLocation: data['departureLocation'],
      arrivalLocation: data['arrivalLocation'],
      departureDateTime: DateTime.parse(data['departureDateTime']),
      vehicleType: data['vehicleType'] == 'van' ? TaxiType.van : TaxiType.sedan,
      price: (data['price']*1.0 as double).toInt(),
      pricingMethod: data['pricingMethod'],
      payment: data['payment'] == 'cash' ? Payment.cash : data['payment'] == 'card_online' ? Payment.cardOnLine : Payment.cardOnBoard,
      status: (data['status'] as String).replaceFirst('pendingPayment', 'waitingConfirmation') == 'waitingConfirmation' ? Status.waitingConfirmation :
      (data['status'] as String).replaceFirst('pendingPayment', 'waitingConfirmation') == 'confirmed' ? Status.confirmed :
      (data['status'] as String).replaceFirst('pendingPayment', 'waitingConfirmation') == 'cancelled' ? Status.cancelled :
      (data['status'] as String).replaceFirst('pendingPayment', 'waitingConfirmation') == 'cancelledByClient' ? Status.cancelledByClient :
      (data['status'] as String).replaceFirst('pendingPayment', 'waitingConfirmation') == 'unCompleted' ? Status.uncompleted : Status.newOffer ,
      roundTrip: data['roundTrip'],
      bookingOffers: (data['bookingOffers'] as List<dynamic>).map((e) => OfferModel.fromJson(e),).toList(),
      timeState: timeState
    );
  }
}