import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'ayarlar.dart';
import 'campaign_screen.dart';
import 'login/login_screen.dart';
import '../models/network.dart';
import 'profil.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;

  //BOTTOM NAVIGATION BAR İÇİN
  int _page = 1;
  GlobalKey _bottomNavigationKey = GlobalKey();

  Future<dynamic> data;
  @override
  void initState() {
    super.initState();
    Network network = new Network('https://tgapi.ihlas.com.tr/json');
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
            onPressed: () async {
              await _auth.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFf5f5f5),
        ),
        child: _page == 1
            ? FutureBuilder(
                future: data,
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    return customList(context, snapshot.data);
                  } else if (snapshot.hasError) {
                    return Text(
                      "Hata var. " + snapshot.error.toString(),
                      style: TextStyle(fontSize: 30),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              )
            : _page == 2
                ? Ayarlar()
                : Profil(),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 1,
        height: 50.0,
        items: <Widget>[
          Icon(Icons.perm_identity, size: 30, color: Colors.white),
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.settings, size: 30, color: Colors.white),
        ],
        color: Color(0xFFe03543),
        buttonBackgroundColor: Color(0xFFe03543),
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOutQuint,
        animationDuration: Duration(milliseconds: 1000),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
    );
  }

  Widget customList(BuildContext context, List<dynamic> data) {
    return ListView.builder(
      itemCount: data == null ? 0 : data.length,
      itemBuilder: (context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  //KAMPANYA FOTOĞRAFI
                  Container(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                              "https://tgapi.ihlas.com.tr/${data[index]['image']}")),
                      padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 5.0)),
                  //KAMPANYA BAŞLIĞI
                  Container(
                    child: Text(
                      '${data[index]['title']}',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.red.shade500),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.fromLTRB(15.0, 10.0, 10.0, 5.0),
                  ),
                  //KAMPANYA KISA AÇIKLAMASI
                  Container(
                    child: ListTile(
                      title: Text(
                        '${data[index]['shortdescription']}',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          height: 1.2,
                          letterSpacing: 0.2,
                          fontFamily: 'Trajan Pro',
                        ),
                      ),
                      trailing: Container(
                        width: 42,
                        padding: EdgeInsets.fromLTRB(2, 3, 2, 3),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                            padding: MaterialStateProperty.all(
                              EdgeInsets.fromLTRB(12, 12, 12, 12),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            elevation: MaterialStateProperty.all(10.0),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CampaignScreen(
                                  campaignId: data[index]['id'],
                                ),
                              ),
                            );
                          },
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.red.shade500,
                            size: 15,
                          ),
                        ),
                      ),
                    ),
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 10.0),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
