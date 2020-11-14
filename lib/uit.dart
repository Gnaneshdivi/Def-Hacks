import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:law/doc.dart';
import 'package:web3dart/web3dart.dart';

class Uit extends StatefulWidget {
  @override
  _UitState createState() => _UitState();
}

class _UitState extends State<Uit> {
  Client httpClint;
  var number = 8688733035;
  bool b = false;

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
    String contractadd = "0x62C07bB1bd75A4ce78651800Fcf3a5359c8cDAec";
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

  Future<void> get(String address, int number) async {
    setState(() {
      b = true;
    });
    //EthereumAddress aa = EthereumAddress.fromHex(address);
    List<dynamic> result = await query("Data", [BigInt.from(8688733035)]);

    print(mydata);
    setState(() {
      mydata = result;
      b = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return !b
        ? Scaffold(
            appBar: AppBar(
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
                Center(
                    child: Container(
                  height: 50,
                  width: 300,
                  child: TextField(
                    maxLength: 10,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        number = value as int;
                      });
                    },
                    onSubmitted: (value) {
                      get(myaddress, number);

                      print(value);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Doc(
                                  user: mydata[3],
                                  title: mydata[0],
                                )),
                      );
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: ' Enter Uit number',
                    ),
                  ),
                ))
              ],
            ),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
