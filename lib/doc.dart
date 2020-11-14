import 'package:flutter/material.dart';

class Doc extends StatefulWidget {
  final title;
  final user;

  const Doc({Key key, this.title, this.user}) : super(key: key);
  @override
  _DocState createState() => _DocState(title, user);
}

class _DocState extends State<Doc> {
  final user;
  final title;

  _DocState(this.title, this.user);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(221, 214, 243, 1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.cyan,
        title: Text(title),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
                color: Colors.cyan,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(60))),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              color: Colors.transparent,
              elevation: 5,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                height: MediaQuery.of(context).size.height * 0.9,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$title",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Text(
                          "date : ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Text(
                          "10/10/10",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Text(
                        "description",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Text(
                          "$user",
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
