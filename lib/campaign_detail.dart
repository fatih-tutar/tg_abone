import 'package:flutter/material.dart';

class CampaignDetail extends StatefulWidget {
  final int campaign_id;

  const CampaignDetail({Key key, this.campaign_id}) : super(key: key);

  @override
  _CampaignDetailState createState() => _CampaignDetailState();
}

class _CampaignDetailState extends State<CampaignDetail> {
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
        backgroundColor: Colors.red.shade500,
        title: Container(
          padding: EdgeInsets.fromLTRB(60, 0, 0, 0),
          child: Text(
            "Kampanya Detay",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      body: Container(
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
                        child: Image.asset(
                            "img/" + campaigns[widget.campaign_id]['image'])),
                    padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 5.0),
                  ),
                  Container(
                    child: Text(
                      '${campaigns[widget.campaign_id]['title']}',
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
                        '${campaigns[widget.campaign_id]['text']}',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          height: 1.2,
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
            )
          ],
        ),
      ),
    );
  }
}
