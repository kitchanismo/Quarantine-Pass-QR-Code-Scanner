import 'package:flutter/material.dart';
import 'package:qr_checker/common/my_button.dart';
import 'package:qr_checker/models/homeliner.dart';
import 'package:qr_checker/repositories/homeliner_repository.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final homeLiners = HomeLinerRepository().homeLiners;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
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
        padding: EdgeInsets.only(top: 50),
        child: Column(
          children: <Widget>[
            buildButtons(),
            buildMenus(),
            buildBody(homeLiners),
          ],
        ),
      ),
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
                'Recent Passers',
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
}

Widget buildBody(List<HomeLiner> homeLiners) {
  final borderRadius = BorderRadius.only(
      topLeft: Radius.circular(20), topRight: Radius.circular(20));

  Text title(String text) {
    return Text(text, style: TextStyle(fontSize: 25, color: Colors.teal));
  }

  return Expanded(
    child: Container(
        padding: EdgeInsets.only(top: 5),
        decoration:
            BoxDecoration(borderRadius: borderRadius, color: Colors.white),
        child: ListView.builder(
            itemCount: homeLiners.length,
            itemBuilder: (context, i) {
              return ListTile(
                  onTap: () {},
                  leading: Icon(Icons.verified_user,
                      color: Colors.pinkAccent, size: 35),
                  title: title(homeLiners[i].name),
                  subtitle: Text(homeLiners[i].code),
                  trailing: Icon(
                    Icons.remove_red_eye,
                    color: Colors.teal,
                    size: 35,
                  ));
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
            text: 'SCAN',
            onPressed: () {},
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: MyButton(
              text: 'ADD',
              onPressed: () {},
              isOutline: true,
              color: Colors.white),
        ),
      ],
    ),
  );
}
