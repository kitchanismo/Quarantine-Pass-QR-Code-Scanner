import 'package:flutter/material.dart';
import 'package:qr_checker/common/my_button.dart';
import 'package:qr_checker/models/homeliner.dart';
import 'package:qr_checker/services/homeliner_service.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:qr/qr.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<HomeLiner> homeLiners;

  void initState() => homeLiners = HomeLinerService().homeLiners;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          'assets/covid.jpg',
          height: MediaQuery.of(context).size.height - 500,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Color.fromRGBO(0, 128, 128, 0.9),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Icon(
                  Icons.search,
                  size: 30,
                ),
              )
            ],
            title: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  'QUARANTINE CHECKER',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
            elevation: 0,
          ),
          body: Container(
            padding: EdgeInsets.only(top: 30),
            child: Column(
              children: <Widget>[
                buildButtons(),
                buildMenus(),
                buildList(),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/add');
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.pinkAccent,
          ),
        ),
      ],
    );
  }

  Widget buildMenus() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: FlatButton(
              onPressed: () {},
              child: Text(
                'Recent',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )),
        ),
        Expanded(
          child: FlatButton(
              onPressed: () {},
              child: Text(
                'Homeliners',
                style: TextStyle(color: Colors.grey[300], fontSize: 20),
              )),
        ),
      ],
    );
  }

  Widget buildList() {
    final borderRadius = BorderRadius.only(
        topLeft: Radius.circular(20), topRight: Radius.circular(20));

    Text title(String text) {
      return Text(text, style: TextStyle(fontSize: 25, color: Colors.teal));
    }

    return Expanded(
      child: Container(
          decoration:
              BoxDecoration(borderRadius: borderRadius, color: Colors.white),
          child: ListView.builder(
              itemCount: homeLiners.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: ListTile(
                      onTap: () {},
                      leading: Icon(Icons.verified_user,
                          color: Colors.pinkAccent, size: 35),
                      title: title(homeLiners[i].name),
                      subtitle: Text(homeLiners[i].address),
                      trailing: PrettyQr(
                          // image: AssetImage('images/twitter.png'),
                          typeNumber: 3,
                          size: 50,
                          data: homeLiners[i].code,
                          errorCorrectLevel: QrErrorCorrectLevel.M,
                          roundEdges: true)),
                );
              })),
    );
  }

  Widget buildButtons() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 30, 50, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: MyButton(
              child: Text('SCAN',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              onPressed: () {
                Navigator.pushNamed(context, '/scanner');
              },
            ),
          ),
        ],
      ),
    );
  }
}
