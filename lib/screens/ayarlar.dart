import 'package:flutter/material.dart';

class Ayarlar extends StatelessWidget {
  const Ayarlar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(color: Colors.white),
      child: Center(child: Text('Ayarlar Sayfası')),
    );
  }
}
