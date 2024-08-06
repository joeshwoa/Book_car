import 'package:public_app/Core/api/constant_api.dart';
import 'package:public_app/Core/api/http_services.dart';

class BookTaxiRepository {

  static Future getTaxiPrices({Map<String, dynamic>? queryParams}) async {
    final uri = Uri.https(
        ConstantApi.nameDomainForPriceService, ConstantApi.endPointForPriceService);
    Map<String, dynamic> data = await ApiService.get(uri: uri, queryParams: queryParams);
    return data;
  }

  static Future bookTaxiWithFixedPrice(
      {required Map<String, dynamic> body, required String token}) async {
    final uri = Uri.https(
      ConstantApi.nameDomain, '${ConstantApi.endPoint}bookings/',);
    Map<String, dynamic> data = await ApiService.post(uri: uri, body: body, headers: {
      'token':token,
    });
    return data;
  }

  static Future bookTaxiWithFlexiblePrice(
      {required Map<String, dynamic> body, required String token}) async {
    final uri = Uri.https(
      ConstantApi.nameDomain, '${ConstantApi.endPoint}bookings/flexible',);
    Map<String, dynamic> data = await ApiService.post(uri: uri, body: body, headers: {
      'token':token,
    });
    return data;
  }

  static Future saveUnCompleteBook(
      {required Map<String, dynamic> body, required String token}) async {
    final uri = Uri.https(
      ConstantApi.nameDomain, '${ConstantApi.endPoint}bookings/save',);
    Map<String, dynamic> data = await ApiService.post(uri: uri, body: body, headers: {
      'token':token,
    });
    return data;
  }

  static Future completeBook(
      {required Map<String, dynamic> body, required String token, required String id}) async {
    final uri = Uri.https(
      ConstantApi.nameDomain, '${ConstantApi.endPoint}bookings/$id/complete',);
    Map<String, dynamic> data = await ApiService.post(uri: uri, body: body, headers: {
      'token':token,
    });
    return data;
  }

  static Future createBookOfferForFlexiblePrice(
      {required Map<String, dynamic> body, required String token}) async {
    final uri = Uri.https(
      ConstantApi.nameDomain, '${ConstantApi.endPoint}bookings/offer/',);
    Map<String, dynamic> data = await ApiService.post(uri: uri, body: body, headers: {
      'token':token,
    });
    return data;
  }

  static Future getOfferDetailsByOfferID(
      {required String id, required String token}) async {
    final uri = Uri.https(
      ConstantApi.nameDomain, '${ConstantApi.endPoint}bookings/offer/$id');
    Map<String, dynamic> data = await ApiService.get(uri: uri, headers: {
      'token':token,
    });
    return data;
  }

  static Future getOffersByBookingID(
      {required String id, required String token}) async {
    final uri = Uri.https(
      ConstantApi.nameDomain, '${ConstantApi.endPoint}bookings/details/$id/offer',);
    Map<String, dynamic> data = await ApiService.get(uri: uri, headers: {
      'token':token,
    });
    return data;
  }

  static Future getBookingDetails(
      {required String id, required String token}) async {
    final uri = Uri.https(
      ConstantApi.nameDomain, '${ConstantApi.endPoint}bookings/details/$id',);
    Map<String, dynamic> data = await ApiService.get(uri: uri, headers: {
      'token':token,
    });
    return data;
  }

  static Future sendAcceptOffer({required String id, required String token, String? promoCode}) async {
    final uri = Uri.https(
      ConstantApi.nameDomain, '${ConstantApi.endPoint}bookings/offer/$id',);
    Map<String, dynamic> data = await ApiService.post(uri: uri, body: {
      if(promoCode != null )'promoCode': promoCode,
      "status": {
        "clientStatus": "accepted"
      }
    }, headers: {
      'token':token,
    });
    return data;
  }

  static Future sendRejectOffer({required String id, required String token}) async {
    final uri = Uri.https(
      ConstantApi.nameDomain, '${ConstantApi.endPoint}bookings/offer/$id',);
    Map<String, dynamic> data = await ApiService.post(uri: uri, body: {
      "status": {
        "clientStatus": "rejected"
      }
    }, headers: {
      'token':token,
    });
    return data;
  }

  static Future getTicketDetails(
      {required String id, required String token}) async {
    final uri = Uri.https(
      ConstantApi.nameDomain, '${ConstantApi.endPoint}bookings/ticket/$id',);
    Map<String, dynamic> data = await ApiService.get(uri: uri, headers: {
      'token':token,
    });
    return data;
  }

  static Future cancelRequest(
      {required String id, required String token, required String reason}) async {
    final uri = Uri.https(
      ConstantApi.nameDomain, '${ConstantApi.endPoint}booking/$id/request/cancel');
    Map<String, dynamic> data = await ApiService.post(uri: uri, body: {
      "reason": reason
    }, headers: {
      'token':token,
    });
    return data;
  }

  static Future createInvoiceForCardOnBoardAndCash(
      {required String id, required String token, required body}) async {
    final uri = Uri.https(
        ConstantApi.nameDomain, '${ConstantApi.endPoint}invoice/requests/', {
      'bookingId': id
    });
    Map<String, dynamic> data = await ApiService.post(uri: uri, body: body, headers: {
      'token':token,
    });
    return data;
  }

  static Future rebook({required String token, required String id, required DateTime newDate}) async {
    final  uri = Uri.https(
        ConstantApi.nameDomain, '${ConstantApi.endPoint}bookings/$id');
    Map<String, dynamic> data = await ApiService.post(uri: uri, headers:{
      'token':token,
    }, body: {
      'newBookingDate': newDate.toString()
    });
    return data;
  }
}