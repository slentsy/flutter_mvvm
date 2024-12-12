import 'package:flutter/material.dart';
import 'package:flutter_mvvm/data/response/api_response.dart';
import 'package:flutter_mvvm/model/model.dart';
import 'package:flutter_mvvm/repository/home_repository.dart';

// untuk get data pasti sama menggunakan seperti ini

class HomeViewmodel with ChangeNotifier {
  final _homeRepo = HomeRepository();

  // getter setter origin province and origin city 

  ApiResponse<List<Province>> provinceList = ApiResponse.loading();

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

  // done getter setter origin province and origin city

  ApiResponse<List<City>> destinationCityList = ApiResponse.loading();

  setDestinationCityList(ApiResponse<List<City>> response) {
    destinationCityList = response;
    notifyListeners();
  }

  Future<void> getDestinationCityList(provId) async {
    setDestinationCityList(ApiResponse.loading());
    _homeRepo.fetchCityList(provId).then((value) {
      setDestinationCityList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setDestinationCityList(ApiResponse.error(error.toString()));
    });
  }
  

  ApiResponse<List<Costs>> costServiceList = ApiResponse.loading();

  setServiceList(ApiResponse<List<Costs>> response) {
    costServiceList = response;
    notifyListeners();
  }
  
  Future<void> serviceList({
  required String originProvince,
  required String originCity,
  required String destProvince,
  required String destCity,
  required int weight,
  required String courier,
}) async {
  setServiceList(ApiResponse.loading());

  // Pass the params to the repository method
  _homeRepo.serviceList(originProvince, originCity, destProvince, destCity, weight, courier).then((value) {
    setServiceList(ApiResponse.completed(value));
  }).onError((error, stackTrace) {
    setServiceList(ApiResponse.error(error.toString()));
  });
}

}
