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
  dynamic selectedService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 200,
        backgroundColor: const Color(0xF3DCEC),
        flexibleSpace: Container(
          child: Row(
            children: [
              SizedBox(
                  height: 112,
                  width: 97,
                  child: Image.asset('assets/images/ojek.png')),
              Column(
                children: [
                  Column(
                    children: [
                      Text("Hitung Estimasi Ongkir",
                          style: TextStyle(
                              color: const Color(0xAAAC0574),
                              fontWeight: FontWeight.bold,
                              fontSize: 15))
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
      body: ChangeNotifierProvider<HomeViewmodel>(
        create: (context) => homeViewModel,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              // FLEXIBLE AWAL PEMBUKA PROVINSI AWAL DAN KOTA AWAL
              Flexible(
                  flex: 1,
                  child: Card(
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
                                        homeViewModel.getCityList(
                                            selectedProvince.provinceId,
                                            isDestination: false);
                                        // selectedProvinceId = selectedDataProvince.provinceId;
                                      });
                                    });
                              default:
                            }
                            return Container();
                          }), //dropdown province list

                          Divider(
                            height: 32,
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
                                        // homeViewModel.getCityList(
                                        //     selectedCity.provinceId);
                                        // selectedProvinceId = selectedDataProvince.provinceId;
                                      });
                                    });
                              default:
                            }
                            return Container();
                          }),
// AKHIR KOTA AWAL

                          // DISINI UNTUK DESTINASI NYA
                          Divider(height: 16),
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
                                        homeViewModel.getCityList(
                                            selectedDestinationProvince
                                                .provinceId,
                                            isDestination: true);
                                        // selectedProvinceId = selectedDataProvince.provinceId;
                                      });
                                    });
                              default:
                            }
                            return Container();
                          }), //dropdown province list
                          Divider(height: 16),
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
                                        // homeViewModel.getCityList(
                                        //     selectedCity.provinceId);
                                        // selectedProvinceId = selectedDataProvince.provinceId;
                                      });
                                    });
                              default:
                            }
                            return Container();
                          }),
                          // AKHIR DESTINASI

// INI UNTUK BERATNYA

                          Divider(height: 32),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Berat (gr)",
                              style: TextStyle(
                                  color: Color(0xFFAC0574),
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16),
                            ),
                          ),
                          TextField(
                            decoration:
                                InputDecoration(border: OutlineInputBorder()),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              final parsedWeight = double.tryParse(value);
                              if (parsedWeight != null) {
                                context
                                    .read<HomeViewmodel>()
                                    .setWeight(parsedWeight);
                              }
                            },
                          ),
                          // AKHIR BERATNYA

                          // MEMILIH JASANYA
                          Divider(height: 32),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Pilih Jasanya",
                              style: TextStyle(
                                  color: Color(0xFFAC0574),
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16),
                            ),
                          ),
                          Consumer<HomeViewmodel>(
                            builder: (context, value, _) {
                              switch (value.serviceList.status) {
                                case Status.loading:
                                  return Center(
                                      child: CircularProgressIndicator());
                                case Status.error:
                                  return Text(
                                      value.serviceList.message.toString());
                                case Status.complited:
                                  return ListView.builder(
                                    itemCount:
                                        value.serviceList.data?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      final service =
                                          value.serviceList.data![index];
                                      return ExpansionTile(
                                        title: Text(service.name ?? ''),
                                        children: service.costs?.map((cost) {
                                              return ListTile(
                                                title: Text(cost.service ?? ''),
                                                subtitle: Text(
                                                    cost.description ?? ''),
                                                trailing: Text(
                                                    '${cost.cost?.first.value ?? 0} IDR'),
                                              );
                                            }).toList() ??
                                            [],
                                      );
                                    },
                                  );
                                default:
                                  return Container();
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  )),
              // Flexible(
              //     flex: 2,
              //     child: Container(
              //       color: Colors.brown.shade200,
              //     ))
            ],
          ),
        ),
      ),
    );
  }
}
