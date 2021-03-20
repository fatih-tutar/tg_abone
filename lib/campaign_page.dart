import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tg_abone_fapp/login.dart';

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
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Login(),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text(widget.user.uid),
      ),
    );
  }
}
