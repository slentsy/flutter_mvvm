part of 'pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeViewmodel homeViewmodel = HomeViewmodel();

  @override
  void initState() {
    // TODO: implement initState
    homeViewmodel.getProvinceList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Province Data"),
        centerTitle: true,
      ),

      // melakukan run dulu untuk nge state 
      body: ChangeNotifierProvider<HomeViewmodel>(
        create: (context) => homeViewmodel,
        child: Consumer<HomeViewmodel>(
          builder: (context, value, _) {
            switch (value.provinceList.status) {
              case Status.loading:
                return Align(
                  alignment: Alignment.center,
                  child: Text(value.provinceList.message.toString()),
                );
              case Status.error:
                return Align(
                  alignment: Alignment.center,
                  child: Text(value.provinceList.message.toString()),
                );
              case Status.complited:
                return ListView.builder(
                    itemCount: value.provinceList.data?.length,
                    itemBuilder: (context, index) {
                      return CardProvince(
                          value.provinceList.data!.elementAt(index));
                    });
              default:
            }
            return Container();
          },
        ),
      ),
    );
  }
}
