import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tg_abone_fapp/campaign_detail.dart';
import 'package:tg_abone_fapp/login.dart';
import 'package:tg_abone_fapp/models/network.dart';

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
    Network network = new Network('https://sosyalisler.ihlas.com.tr/app.json');
    data = network.fetchData();
  }

  List campaigns = [
    {
      "id": 6,
      "title": "A101 Yüzde 10 İndirim Kampanyası",
      "text":
          "100 TL üzeri alışverişlerinizde geçerli yüzde 10 indirimi kaçırmayın.",
      "description":
          "17 Mart 2021 Çarşamba günü Türkiye Gazetesi abonelerine özel 100 TL üzeri alışverişlerde geçerli %10 indirim sizleri bekliyor. İndirim Türkiye'deki bütün A101 şubelerinde geçerlidir.",
      "image": "a101.jpg",
      "started_at": "2021-03-17T18:00:00.000000Z",
      "finished_at": "2021-03-18T18:00:00.000000Z",
      "status": "draft",
      "created_at": "2021-03-04T15:00:10.000000Z",
      "updated_at": "2021-03-05T12:38:23.000000Z"
    },
    {
      "id": 2,
      "title": "Şok'ta Perşembe İndirimi",
      "text":
          "100 TL üzeri alışverişlerinizde geçerli yüzde 10 indirimi kaçırmayın.",
      "description":
          "11 Mart 2021 Perşembe günü Türkiye Gazetesi abonelerine özel 100 TL üzeri alışverişlerde geçerli %10 indirim sizleri bekliyor. İndirim Türkiye'deki bütün ŞOK şubelerinde geçerlidir.",
      "image": "sok.jpg",
      "started_at": "2021-03-11T16:17:00.000000Z",
      "finished_at": "2021-03-12T16:17:00.000000Z",
      "status": "publish",
      "created_at": "2021-03-04T13:17:18.000000Z",
      "updated_at": "2021-03-05T13:14:48.000000Z"
    },
    {
      "id": 4,
      "title": "Petrol Ofisi'nde İndirim Günü",
      "text":
          "100 TL üzeri alışverişlerinizde geçerli yüzde 10 indirimi kaçırmayın.",
      "description":
          "10 Mart 2021 Çarşamba günü Türkiye Gazetesi abonelerine özel 100 TL üzeri akaryakıt alışverişlerinde geçerli %10 indirim sizleri bekliyor. İndirim Türkiye'deki bütün Petrol Ofisi şubelerinde geçerlidir.",
      "image": "po.png",
      "started_at": "2021-03-10T16:17:00.000000Z",
      "finished_at": "2021-03-11T16:17:00.000000Z",
      "status": "draft",
      "created_at": "2021-03-04T13:17:55.000000Z",
      "updated_at": "2021-03-05T12:49:31.000000Z"
    },
    {
      "id": 3,
      "title": "Bim'de Çarşamba İndirimi",
      "text":
          "100 TL üzeri alışverişlerinizde geçerli yüzde 10 indirimi kaçırmayın.",
      "description":
          "17 Mart 2021 Çarşamba günü Türkiye Gazetesi abonelerine özel 100 TL üzeri alışverişlerde geçerli %10 indirim sizleri bekliyor. İndirim Türkiye'deki bütün A101 şubelerinde geçerlidir.",
      "image": "bim.png",
      "started_at": "2021-03-11T16:17:00.000000Z",
      "finished_at": "2021-03-12T16:17:00.000000Z",
      "status": "passive",
      "created_at": "2021-03-04T13:17:36.000000Z",
      "updated_at": "2021-03-05T13:14:55.000000Z"
    }
  ];

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
        decoration: BoxDecoration(
          color: Color(0xFFf5f5f5),
        ),
        child: FutureBuilder(
          future: data,
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return customList(context, snapshot.data);
            } else if (snapshot.hasError) {
              //return customList(context, snapshot.data);
              return Text(
                "Hata var. " + snapshot.error.toString(),
                style: TextStyle(fontSize: 30),
              );
            } else {
              return Center(child: CircularProgressIndicator());
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
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  Container(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset("img/" + campaigns[index]['image'])),
                    padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 5.0),
                  ),
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
                  Container(
                    child: ListTile(
                      title: Text(
                        '${campaigns[index]['text']}',
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
                                builder: (context) => CampaignDetail(
                                  campaign_id: index,
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
