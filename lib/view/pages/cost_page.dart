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
  // dynamic selectedDataProvince;

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
                                color: const Color(0xFFAC0574),
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
      // title: Text(
      //   "Hitung Estimasi Ongkir",
      //   style: TextStyle(
      //     color: const Color (0xFFAC0574),
      //     fontWeight: FontWeight.bold,
      //     fontSize: 15)),
      // centerTitle: true
      // )

      body: ChangeNotifierProvider<HomeViewmodel>(
        create: (context) => homeViewModel,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Flexible(
                  flex: 1,
                  child: Card(
                    color: Colors.white,
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          //dropdown province list
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
                                    // : Text(selectedDataProvince.province),
                                    style: TextStyle(
                                        color: const Color.fromARGB(255, 49, 40, 171)),
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
                                            selectedProvince.provinceId);
                                        // selectedProvinceId = selectedDataProvince.provinceId;
                                      });
                                    });
                              default:
                            }
                            return Container();
                          }), //dropdown province list

                          Divider(
                            height: 16,
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
                                            (City value) {
                                      return DropdownMenuItem(
                                          value: value,
                                          child:
                                              Text(value.cityName.toString()));
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
                          })
                          //dropdown province list
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
