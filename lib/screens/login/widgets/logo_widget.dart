import 'package:flutter/material.dart';

getLogoWidget(context) {
  return Column(
    children: [
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.1,
      ),
      Image.asset("img/icon.png", height: 125, fit: BoxFit.fill),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.1,
      ),
    ],
  );
}
