import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondWindow extends StatefulWidget {
  const SecondWindow({super.key});

  @override
  State<SecondWindow> createState() => _SecondWindowState();
}

class _SecondWindowState extends State<SecondWindow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Window'),
      ),
    );
  }
}
