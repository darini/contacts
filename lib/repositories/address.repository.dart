import 'package:contacts/models/geolocation.model.dart';
import 'package:contacts/services/dio-http.service.dart';
import 'package:contacts/services/ihttp.service.dart';
import 'package:contacts/settings.dart';
import 'package:dio/dio.dart';

class AddressRepository {
  final String url = 'https://maps.googleapis.com/maps/api/geocode/json?'
      'key=$MAPS_API_KEY&address=';

  final IHttpService httpService = DioHttp();

  Future<GeolocationModel> searchAddress(String address) async {
    Response response = await httpService.get(url + address, null);

    return GeolocationModel(
      longName: response.data['results'][0]['address_components'][0]
          ['long_name'],
      formattedAddress: response.data['results'][0]['formatted_address'],
      latitude: response.data['results'][0]['geometry']['location']['lat'],
      longitude: response.data['results'][0]['geometry']['location']['lng'],
    );
  }
}
