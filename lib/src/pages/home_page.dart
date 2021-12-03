import 'package:flutter/material.dart';
import 'package:testapp/src/blocs/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('TestAPP'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
