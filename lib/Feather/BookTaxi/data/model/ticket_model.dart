import 'package:flutter/material.dart';

class TicketModel{
  DateTime? pickUpDate;
  DateTime? dropOffDate;
  TimeOfDay? pickUpTime;
  TimeOfDay? dropOffTime;
  String? bookingId;
  String? barCode;
  String? name;
  String? email;
  int? totalPrice;
  int? numberOfPassengers;
  int? numberOfLuggages;
  int? numberOfSpecialLuggages;
  int? numberOfPets;

  TicketModel(
      {this.pickUpDate,
        this.dropOffDate,
        this.pickUpTime,
        this.dropOffTime,
        this.bookingId,
        this.barCode,
        this.name,
        this.email,
        this.totalPrice,
        this.numberOfPassengers,
        this.numberOfLuggages,
        this.numberOfSpecialLuggages,
        this.numberOfPets,});

  factory TicketModel.fromJson(data){
    return TicketModel(
      pickUpDate: DateTime.parse(data['pickUpDate']),
      dropOffDate: DateTime.parse(data['dropOffDate']),
      pickUpTime: TimeOfDay.fromDateTime(DateTime.parse(data['pickUpTime'])),
      dropOffTime: TimeOfDay.fromDateTime(DateTime.parse(data['dropOffTime'])),
      bookingId: data['bookingId'],
      barCode: data['barCode'],
      name: data['name'],
      email: data['email'],
      totalPrice: (data['totalPrice']*1.0 as double).toInt(),
      numberOfPassengers: data['numberOfPassengers'],
      numberOfLuggages: data['numberOfLuggages'],
      numberOfSpecialLuggages: data['numberOfSpecialLuggages'],
      numberOfPets: data['numberOfPets'],
    );
  }
}