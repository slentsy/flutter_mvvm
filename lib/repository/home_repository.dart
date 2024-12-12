import 'package:flutter_mvvm/data/network/network_api_services.dart';
import 'package:flutter_mvvm/model/model.dart';
import 'package:flutter_mvvm/shared/shared.dart';

class HomeRepository {
  final _apiServices = NetworkApiServices();

  Future<List<Province>> fetchProvinceList() async {
    try {
      dynamic response = await _apiServices.getApiResponse('/starter/province');
      List<Province> result = [];
      // dilihat berdasarkan strukturnya
      if (response['rajaongkir']['status']['code'] == 200) {
        result = (response['rajaongkir']['results'] as List)
            .map((e) => Province.fromJson(e))
            .toList();
      }
      return result;
    } catch (e) {
      throw e;
    }
  }

  Future<List<City>> fetchCityList(var provId) async {
    try {
      dynamic response = await _apiServices.getApiResponse('/starter/city');
      List<City> result = [];
      // dilihat berdasarkan strukturnya
      if (response['rajaongkir']['status']['code'] == 200) {
        result = (response['rajaongkir']['results'] as List)
            .map((e) => City.fromJson(e))
            .toList();
      }

      // melakukan pengecekan
      List<City> selectedCities = [];
      for (var c in result) {
        if (c.provinceId == provId) {
          selectedCities.add(c);
        }
      }

      return selectedCities;
    } catch (e) {
      {
        throw e;
      }
    }
  }


Future<List<Costs>> serviceList(
  String originProvince, 
  String originCity,
  String destProvince, 
  String destCity, 
  int weight, 
  String courier,
) async {
  try {
    print("Request Payload: originCity=$originCity, destCity=$destCity, weight=$weight, courier=$courier");
    final response = await _apiServices.postApiResponse(
      'https://api.rajaongkir.com/starter/cost', 
      {
        "origin": originCity,
        "destination": destCity,
        "weight": weight.toString(),
        "courier": courier,
      },
      headers: {
        "key": Const.apiKey,
        "Content-Type": "application/x-www-form-urlencoded"
      },
    );
    
    print("Raw API Response: $response");

    if (response['rajaongkir']['status']['code'] == 200) {
      final results = response['rajaongkir']['results'] as List;
      final List<Costs> costList = results.expand((result) {
        return (result['costs'] as List)
            .map((cost) => Costs.fromJson(cost as Map<String, dynamic>));
      }).toList();
      return costList;
    } else {
      throw Exception('API returned error: ${response['rajaongkir']['status']}');
    }
  } catch (e) {
    print("Error in serviceList: $e");
    throw Exception('Failed to fetch services: $e');
  }
}

}
