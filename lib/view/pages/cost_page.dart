part of 'pages.dart';

class CostPage extends StatefulWidget {
  const CostPage({super.key});

  @override
  State<CostPage> createState() => _CostPageState();
}

class _CostPageState extends State<CostPage> {
  HomeViewmodel homeViewModel = HomeViewmodel();

  @override
  void initState() {
    homeViewModel.getProvinceList();
    super.initState();
  }

  dynamic selectedProvince;
  dynamic selectedCity;
  dynamic selectedDestinationProvince;
  dynamic selectedDestinationCity;
  dynamic weight = TextEditingController();
  dynamic selectedCourier = 'jne';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xF3DCEC),
        title: Text("Cost Page"),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider<HomeViewmodel>(
          create: (context) => homeViewModel,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Card(
                    color: Colors.white,
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Label Asal",
                              style: TextStyle(
                                  color: Color(0xFFAC0574),
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16),
                            ),
                          ),
                          //dropdown province list
                          // AWAL KOTA AWALL
                          Consumer<HomeViewmodel>(builder: (context, value, _) {
                            switch (value.provinceList.status) {
                              case Status.loading:
                                return Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("Pilih Provinsi dulu"),
                                );
                              case Status.error:
                                return Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                      value.provinceList.message.toString()),
                                );
                              case Status.complited:
                                return DropdownButton(
                                    isExpanded: true,
                                    value: selectedProvince,
                                    icon: Icon(Icons.arrow_drop_down),
                                    iconSize: 30,
                                    elevation: 2,
                                    hint: Text('Pilih Provinsi dulu'),
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 49, 40, 171)),
                                    items: value.provinceList.data!
                                        .map<DropdownMenuItem<Province>>(
                                            (Province value) {
                                      return DropdownMenuItem(
                                          value: value,
                                          child:
                                              Text(value.province.toString()));
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedProvince = newValue;
                                        selectedCity = null;
                                        if (newValue != null) {
                                          value.setCityList(
                                              ApiResponse.loading());
                                          homeViewModel.getCityList(
                                              selectedProvince.provinceId,
                                              isDestination: false);
                                        }
                                        print('Provinsi Awal: $selectedCity');
                                      });
                                    });
                              default:
                                return Container();
                            }
                          }),

                          Divider(
                            height: 10,
                          ),
                          Consumer<HomeViewmodel>(builder: (context, value, _) {
                            switch (value.cityList.status) {
                              case Status.loading:
                                return Align(
                                  alignment: Alignment.center,
                                  child: CircularProgressIndicator(),
                                );
                              case Status.error:
                                return Align(
                                  alignment: Alignment.center,
                                  child:
                                      Text(value.cityList.message.toString()),
                                );
                              case Status.complited:
                                return DropdownButton(
                                    isExpanded: true,
                                    value: selectedCity,
                                    icon: Icon(Icons.arrow_drop_down),
                                    iconSize: 30,
                                    elevation: 2,
                                    hint: Text('Sekarang pilih kotanya'),
                                    // : Text(selectedDataProvince.province),
                                    style: TextStyle(color: Colors.black),
                                    items: value.cityList.data!
                                        .map<DropdownMenuItem<City>>(
                                            (City city) {
                                      return DropdownMenuItem(
                                          value: city,
                                          child:
                                              Text(city.cityName.toString()));
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedCity = newValue;
                                      });
                                      print('Kota Awal : $selectedCity');
                                    });
                              default:
                                return Container();
                            }
                          }),
                          // AKHIR KOTA AWAL

                          // DISINI UNTUK DESTINASI NYA
                          Divider(height: 10),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Label Tujuan",
                              style: TextStyle(
                                  color: Color(0xFFAC0574),
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16),
                            ),
                          ),
                          Consumer<HomeViewmodel>(builder: (context, value, _) {
                            switch (value.provinceList.status) {
                              case Status.loading:
                                return Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("Pilih Provinsi Tujuan"),
                                );
                              case Status.error:
                                return Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                      value.provinceList.message.toString()),
                                );
                              case Status.complited:
                                return DropdownButton(
                                    isExpanded: true,
                                    value: selectedDestinationProvince,
                                    icon: Icon(Icons.arrow_drop_down),
                                    iconSize: 30,
                                    elevation: 2,
                                    hint: Text('Pilih Provinsi tujuannya'),
                                    // : Text(selectedDataProvince.province),
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 49, 40, 171)),
                                    items: value.provinceList.data!
                                        .map<DropdownMenuItem<Province>>(
                                            (Province value) {
                                      return DropdownMenuItem(
                                          value: value,
                                          child:
                                              Text(value.province.toString()));
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedDestinationProvince = newValue;
                                        selectedDestinationCity = null;
                                      });
                                      if (newValue != null) {
                                        value.setDestinationCityList(
                                            ApiResponse.loading());
                                        homeViewModel.getDestinationCityList(
                                            selectedDestinationProvince
                                                .provinceId);
                                      }
                                    });
                              default:
                            }
                            return Container();
                          }), //dropdown province list
                          Divider(height: 10),
                          Consumer<HomeViewmodel>(builder: (context, value, _) {
                            switch (value.destinationCityList.status) {
                              case Status.loading:
                                return Align(
                                  alignment: Alignment.center,
                                  child: CircularProgressIndicator(),
                                );
                              case Status.error:
                                return Align(
                                  alignment: Alignment.center,
                                  child: Text(value.destinationCityList.message
                                      .toString()),
                                );
                              case Status.complited:
                                return DropdownButton(
                                    isExpanded: true,
                                    value: selectedDestinationCity,
                                    icon: Icon(Icons.arrow_drop_down),
                                    iconSize: 30,
                                    elevation: 2,
                                    hint: Text('Sekarang pilih kota tujuannya'),
                                    // : Text(selectedDataProvince.province),
                                    style: TextStyle(color: Colors.black),
                                    items: value.destinationCityList.data!
                                        .map<DropdownMenuItem<City>>(
                                            (City city) {
                                      return DropdownMenuItem(
                                          value: city,
                                          child:
                                              Text(city.cityName.toString()));
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedDestinationCity = newValue;
                                      });
                                      print(
                                          'Kota tujuan : $selectedDestinationCity');
                                    });
                              default:
                            }
                            return Container();
                          }),
                          // AKHIR DESTINASI
                          Divider(height: 10),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Pilih Kurir",
                              style: TextStyle(
                                color: Color(0xFFAC0574),
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          DropdownButton<String>(
                            value: selectedCourier,
                            items: ['jne', 'pos', 'tiki'].map((courier) {
                              return DropdownMenuItem(
                                value: courier,
                                child: Text(courier.toUpperCase()),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedCourier = value!;
                              });
                            },
                          ),

                          // beratnya diinput
                          Divider(height: 10),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Berat (gr)",
                              style: TextStyle(
                                color: Color(0xFFAC0574),
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          TextField(
                            decoration:
                                InputDecoration(border: OutlineInputBorder()),
                            controller: weight,
                            keyboardType: TextInputType.number,
                            onChanged: (newValue) {
                              print('Berat: ${weight.text}');
                            },
                          ),
                          Divider(height: 10),
                          ElevatedButton(
                            onPressed: () async {
                              if (selectedProvince == null ||
                                  selectedCity == null ||
                                  selectedDestinationProvince == null ||
                                  selectedDestinationCity == null ||
                                  weight.text.isEmpty ||
                                  selectedCourier.isEmpty) {
                                // salah input
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: Text("Input Error"),
                                    content: Text(
                                        "Please fill in all the required fields."),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(ctx).pop();
                                        },
                                        child: Text("OK"),
                                      ),
                                    ],
                                  ),
                                );
                                return;
                              }

                              if (selectedCity != null &&
                                  selectedDestinationCity != null) {
                                print(
                                    "Selected Origin City: ${selectedCity.cityId}");
                                print(
                                    "Selected Destination City: ${selectedDestinationCity.cityId}");
                                await homeViewModel.serviceList(
                                  originProvince: selectedProvince.provinceId,
                                  originCity: selectedCity.cityId,
                                  destProvince:
                                      selectedDestinationProvince.provinceId,
                                  destCity: selectedDestinationCity.cityId,
                                  weight: int.parse(weight.text),
                                  courier: selectedCourier,
                                );
                              } else {
                                print(
                                    "Please select both origin and destination cities.");
                              }
                            },
                            child: Text("Calculate Cost"),
                          ),

                          SizedBox(
                            height: 200,
                            child: Consumer<HomeViewmodel>(
                              builder: (context, value, _) {
                                switch (value.costServiceList.status) {
                                  case Status.loading:
                                    return Center(
                                        child: CircularProgressIndicator());
                                  case Status.error:
                                    return Center(
                                      child: Text(
                                        "Error: ${value.costServiceList.message}",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    );
                                  case Status.complited:
                                    // If completed, display the cost list
                                    if (value
                                            .costServiceList.data?.isNotEmpty ==
                                        true) {
                                      return ListView.builder(
                                        padding: EdgeInsets.all(8.0),
                                        itemCount:
                                            value.costServiceList.data!.length,
                                        itemBuilder: (context, index) {
                                          final Costs costItem = value
                                              .costServiceList.data![index];
                                          return Card(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 8.0,
                                                horizontal: 16.0),
                                            elevation: 4.0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(16),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    costItem.service ??
                                                        'Unknown Service',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                  SizedBox(height: 8.0),
                                                  Text(
                                                    'Description: ${costItem.description ?? 'N/A'}',
                                                    style: TextStyle(
                                                        fontSize: 14.0),
                                                  ),
                                                  SizedBox(height: 8.0),
                                                  ...costItem.cost?.map((cost) {
                                                        return Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Cost: ${cost.value?.toString() ?? 'N/A'}',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14.0),
                                                            ),
                                                            Text(
                                                              'ETD: ${cost.etd ?? 'N/A'}',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14.0),
                                                            ),
                                                            Text(
                                                              'Note: ${cost.note ?? 'N/A'}',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14.0,
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                            Divider(),
                                                          ],
                                                        );
                                                      }).toList() ??
                                                      [
                                                        Text(
                                                          'No cost data available.',
                                                          style: TextStyle(
                                                              fontSize: 14.0,
                                                              color:
                                                                  Colors.red),
                                                        ),
                                                      ],
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    } else {
                                      return Center(
                                          child:
                                              Text("No services available."));
                                    }
                                  default: // Handle null case or any other unexpected status
                                    return Center(
                                        child: Text(
                                            "Unexpected status or data is null."));
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
