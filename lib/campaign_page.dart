import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tg_abone_fapp/login.dart';
import 'package:tg_abone_fapp/network.dart';

class CampaignPage extends StatefulWidget {
  CampaignPage({Key key, this.user}) : super(key: key);

  final User user;
  @override
  _CampaignPageState createState() => _CampaignPageState();
}

class _CampaignPageState extends State<CampaignPage> {
  Future<dynamic> data;
  @override
  void initState() {
    super.initState();
    Network network = new Network('https://jsonplaceholder.typicode.com/posts');
    data = network.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Center(
            child: Image.asset("img/logo.png", height: 50, fit: BoxFit.fill)),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.red,
              size: 30,
            ),
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
      body: Container(
        child: FutureBuilder(
          future: data,
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return customList(context, snapshot.data);
            } else if (snapshot.hasError) {
              return Text("Hata var. " + snapshot.error.toString());
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Widget customList(BuildContext context, List<dynamic> data) {
    return ListView.builder(
      itemCount: data == null ? 0 : data.length,
      itemBuilder: (context, int index) {
        return Card(
          child: ListTile(
            title: Text('${data[index]['title']}'),
          ),
        );
      },
    );
  }
}
