import 'package:flutter/material.dart';

class Profil extends StatelessWidget {
  const Profil({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(color: Colors.white),
      child: Center(child: Text('Profil Sayfası')),
    );
  }
}
