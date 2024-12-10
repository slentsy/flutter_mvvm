import 'package:flutter/material.dart';
import 'package:flutter_mvvm/data/response/api_response.dart';
import 'package:flutter_mvvm/model/city.dart';
import 'package:flutter_mvvm/model/model.dart';
import 'package:flutter_mvvm/model/service.dart';
import 'package:flutter_mvvm/repository/home_repository.dart';

// untuk get data pasti sama menggunakan seperti ini

class HomeViewmodel with ChangeNotifier {
  final _homeRepo = HomeRepository();
  ApiResponse<List<Province>> provinceList = ApiResponse.loading();
  ApiResponse<List<Province>> destinationProvinceList = ApiResponse.loading();

  setProvinceList(ApiResponse<List<Province>> response) {
    provinceList = response;
    notifyListeners();
  }

  Future<void> getProvinceList() async {
    setProvinceList(ApiResponse.loading());
    _homeRepo.fetchProvinceList().then((value) {
      setProvinceList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setProvinceList(ApiResponse.error(error.toString()));
    });
  }

  ApiResponse<List<City>> cityList = ApiResponse.loading();
  ApiResponse<List<City>> destinationCityList = ApiResponse.loading();

  setCityList(ApiResponse<List<City>> response) {
    cityList = response;
    notifyListeners();
  }

  Future<void> getCityList(var provId, {bool isDestination = false}) async {
    if (isDestination) {
      destinationCityList = ApiResponse.loading();
      notifyListeners();
      _homeRepo.fetchCityList(provId).then((value) {
        destinationCityList = ApiResponse.completed(value);
        notifyListeners();
      }).onError((error, stackTrace) {
        destinationCityList = ApiResponse.error(error.toString());
        notifyListeners();
      });
    } else {
      cityList = ApiResponse.loading();
      notifyListeners();
      _homeRepo.fetchCityList(provId).then((value) {
        cityList = ApiResponse.completed(value);
        notifyListeners();
      }).onError((error, stackTrace) {
        cityList = ApiResponse.error(error.toString());
        notifyListeners();
      });
    }
  }

  double? weight;

  void setWeight(double newWeight){
    weight = newWeight;
    notifyListeners();
  }

  ApiResponse<List<Service>> serviceList = ApiResponse.loading();

  setServiceList(ApiResponse<List<Service>> response) {
    serviceList = response;
    notifyListeners();
  }

  Future<void> getServiceList({
  required String origin,
  required String destination,
  required double weight,
  required String courier,
}) async {
  setServiceList(ApiResponse.loading());
  
  // Create the params object
  final params = {
    'origin': origin,
    'destination': destination,
    'weight': weight,
    'courier': courier,
  };

  // Pass the params to the repository method
  _homeRepo.fetchServiceList(params).then((value) {
    setServiceList(ApiResponse.completed(value));
  }).onError((error, stackTrace) {
    setServiceList(ApiResponse.error(error.toString()));
  });
}

  

}
