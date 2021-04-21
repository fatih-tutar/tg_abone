import 'package:flutter/material.dart';
import 'package:tg_abone_fapp/models/network.dart';

class CampaignDetail extends StatefulWidget {
  final int campaignId;

  const CampaignDetail({Key key, this.campaignId}) : super(key: key);

  @override
  _CampaignDetailState createState() => _CampaignDetailState();
}

class _CampaignDetailState extends State<CampaignDetail> {
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
        backgroundColor: Colors.red.shade500,
        title: Container(
          padding: EdgeInsets.fromLTRB(60, 0, 0, 0),
          child: Text(
            "Kampanya Detay",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      body: FutureBuilder(
        future: data,
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            for (var i = 0; i < snapshot.data.length; i++) {
              if (snapshot.data[i]['id'] == widget.campaignId) {
                return campaignDetailWidget(snapshot.data, i);
              } else {}
            }
            return null;
          } else if (snapshot.hasError) {
            return Text(
              "Hata var. " + snapshot.error.toString(),
              style: TextStyle(fontSize: 30),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget campaignDetailWidget(List<dynamic> data, int index) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Container(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                            "https://tgapi.ihlas.com.tr/${data[index]['image']}")),
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
                        '${data[index]['shortdescription']}',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          height: 2,
                          letterSpacing: 0.2,
                          fontFamily: 'Trajan Pro',
                        ),
                      ),
                    ),
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 10.0),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(15, 20, 20, 20),
              child: Text(
                "Kampanya Koşulları",
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Container(
                    child: ListTile(
                      title: Text(
                        '${data[index]['description']}',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          height: 2,
                          letterSpacing: 0.2,
                          fontFamily: 'Trajan Pro',
                        ),
                      ),
                    ),
                    padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
