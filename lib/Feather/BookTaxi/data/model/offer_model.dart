class OfferModel{
  String? id;
  String? bookingId;
  String? clientStatus;
  String? providerStatus;
  int? price;

  OfferModel(
      {this.id,
        this.bookingId,
        this.clientStatus,
        this.providerStatus,
        this.price,});

  factory OfferModel.fromJson(data){
    return OfferModel(
      id: data['_id'],
      bookingId: data['booking'],
      clientStatus: data['status']['clientStatus'],
      providerStatus: data['status']['providerStatus'],
      price: (data['price']*1.0 as double).toInt(),
    );
  }
}