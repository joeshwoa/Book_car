import 'package:public_app/Core/api/constant_api.dart';
import 'package:public_app/Core/api/http_services.dart';

class MyBookingRepository{

  static Future getMyBooking({required String token, int page = 1, required bool pastBookings}) async {
    final  uri = Uri.https(
      ConstantApi.nameDomain, '${ConstantApi.endPoint}bookings',
        {
          'page': '$page',
          if(pastBookings)'past': '$pastBookings',
          if(!pastBookings)'upcoming': '${!pastBookings}'
        }
      );
    Map<String, dynamic> data = await ApiService.get(uri: uri,headers:{
      'token':token,
    });
    return data;
  }

  static Future rating({required String token, required String id, required body}) async {
    final  uri = Uri.https(
        ConstantApi.nameDomain, '${ConstantApi.endPoint}bookings/$id/review');
    Map<String, dynamic> data = await ApiService.patch(uri: uri, headers:{
      'token':token,
    }, body: body);
    print(data);
    return data;
  }

  static Future modificationRequest({required String token, required String id}) async {
    final  uri = Uri.https(
        ConstantApi.nameDomain, '${ConstantApi.endPoint}booking/$id/request/modify');
    Map<String, dynamic> data = await ApiService.post(uri: uri, headers:{
      'token':token,
    }, sentContentTypeHeader: false);
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

  static Future createInvoiceForCardOnline(
      {required String id, required String token, required body}) async {
    final uri = Uri.https(
        ConstantApi.nameDomain, '${ConstantApi.endPoint}bookings/invoice/', {
      'bookingId': id
    });
    Map<String, dynamic> data = await ApiService.post(uri: uri, body: body, headers: {
      'token':token,
    });
    return data;
  }

  static Future cardOnlinePayment(
      {required String id, required String token, required body}) async {
    final uri = Uri.https(
        ConstantApi.nameDomain, '${ConstantApi.endPoint}bookings/offer/$id/payment');
    Map<String, dynamic> data = await ApiService.post(uri: uri, body: body, headers: {
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
}