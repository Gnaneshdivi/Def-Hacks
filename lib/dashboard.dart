import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:law/doc.dart';
import 'package:law/uit.dart';
import 'package:web3dart/web3dart.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Client httpClint;

  Web3Client ethclint;
  var mydata;

  final myaddress = "0x52c8777570f8532A4482922DAAdb0B27e759ef02";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    httpClint = Client();
    ethclint = Web3Client(
        "https://rinkeby.infura.io/v3/ec4189838ae542b192fac6cad74e63a7",
        httpClint);
  }

  Future<DeployedContract> loadcontract() async {
    String abi = await rootBundle.loadString("assets/abi.json");
    String contractadd = "0x5FE45F8bC1f7103f3DaE958Db05c6fD12eAe232C";
    final contract = DeployedContract(
        ContractAbi.fromJson(abi, "nng"), EthereumAddress.fromHex(contractadd));
    return contract;
  }

  Future<List<dynamic>> query(String fname, List<dynamic> args) async {
    final contract = await loadcontract();
    final ethfunction = contract.function(fname);
    final result = await ethclint.call(
        contract: contract, function: ethfunction, params: args);
    return result;
  }

  Future<void> get(String address) async {
    //EthereumAddress aa = EthereumAddress.fromHex(address);
    List<dynamic> result = await query("Data", [BigInt.from(789561230)]);
    mydata = result;
    print(mydata);
    setState(() {});
  }

  List casename = ["xyz", "abc", "vvvvvvv"];
  List desc = [
    "Rhea Chakraborty, who has been questioned by the Central Bureau of Investigation (CBI) Special Investigation Team for 17 hours, deposed before the agency once again on Sunday along with her brother Showik in the Sushant Singh Rajput case.",
    "The CBI has used reconstruction as a tool in high-profile cases such as the Aarushi murder and the killings of Pune-based rationalist Narendra Dabholkar and senior journalist Gauri Lankesh in Karnataka.",
    "It is alleged that Singh brothers in connivance with the employees of Lakshmi Vilas Bank misappropriated two FDs of Rs 400 crore and Rs 350 crore made with the Lakshmi Vilas Bank by the complainant company."
  ];
  List city = ["hyderabad", "bangalore", "assam"];

  @override
  Widget build(BuildContext context) {
    return city.length != null
        ? Scaffold(
            appBar: AppBar(
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Uit()),
                      );
                    },
                    child: Text("Use UIT")),
              ],
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.cyan,
              automaticallyImplyLeading: false,
              title: Padding(
                padding: const EdgeInsets.all(10.0),
                child: const Text(
                  'Corl',
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange),
                ),
              ),
            ),
            body: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.cyan,
                      Color.fromRGBO(221, 214, 243, 300),
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  ),
                  height: MediaQuery.of(context).size.height,
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.15,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "Country",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "3",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "State",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("3",
                                          style: TextStyle(fontSize: 20)),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "City",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("0",
                                          style: TextStyle(fontSize: 20)),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: ListView.builder(
                          itemCount: city.length,
                          itemBuilder: (ctx, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Doc(
                                            user: desc[index],
                                            title: casename[index],
                                          )),
                                );
                              },
                              child: Card(
                                color: Colors.white,
                                elevation: 5,
                                margin: EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 5,
                                ),
                                child: ListTile(
                                  title: Text(
                                    casename[index].toString(),
                                  ),
                                  subtitle: Text(
                                    city[index].toString(),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
