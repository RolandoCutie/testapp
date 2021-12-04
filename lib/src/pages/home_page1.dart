// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';

class HomePage1 extends StatelessWidget {
  const HomePage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TaskAPP'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Container(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
              Widget>[
            Column(children: <Widget>[
              RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: () { 
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  child: Text(
                    "Add Worker",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 22.0,
                textColor: Colors.white,
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: () {},
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  child: Text(
                    "Create Team",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 22.0,
                textColor: Colors.white,
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  Navigator.pushNamed(context, 'task_create_page');
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  child: Text(
                    "Create Task",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 22.0,
                textColor: Colors.white,
              ),
            ]),
          ]),
        ),
      ),
      //floatingActionButton: _crearBoton(context),
    );
  }
}
