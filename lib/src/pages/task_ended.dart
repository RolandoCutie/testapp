import 'package:flutter/material.dart';

class TaskEndedPage extends StatelessWidget {
  const TaskEndedPage({Key? key}) : super(key: key);

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TaskAPP'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        child: Center(
          child: Text('TaskEnded'),
        ),
      ),
      //floatingActionButton: _crearBoton(context),
    );
  }
}
