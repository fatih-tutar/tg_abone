import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CampaignPage extends StatefulWidget {
  CampaignPage({Key key, this.user}) : super(key: key);

  final User user;
  @override
  _CampaignPageState createState() => _CampaignPageState();
}

class _CampaignPageState extends State<CampaignPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kampanyalar"),
      ),
      body: Center(
        child: Text(widget.user.uid),
      ),
    );
  }
}
