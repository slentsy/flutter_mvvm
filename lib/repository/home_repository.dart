import 'package:flutter_mvvm/data/network/network_api_services.dart';
import 'package:flutter_mvvm/model/city.dart';
import 'package:flutter_mvvm/model/model.dart';
import 'package:flutter_mvvm/model/service.dart';

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

  Future<List<Service>> fetchServiceList(dynamic params) async {
    try {
      print("Fetching services with params: $params");
      dynamic response =
          await _apiServices.postApiResponse('/starter/cost', params);
      print("API response: $response");
      List<Service> result = [];
      if (response['rajaongkir']['status']['code'] == 200) {
        result = (response['rajaongkir']['results'] as List)
            .map((e) => Service.fromJson(e))
            .toList();
      }
      return result;
    } catch (e) {
      print("Error in fetchServiceList: $e");
      throw e;
    }
  }
}
