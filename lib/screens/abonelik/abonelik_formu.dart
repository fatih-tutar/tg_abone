import 'package:flutter/material.dart';

import 'abone_adres.dart';

class AbonelikFormu extends StatefulWidget {
  final String tel;
  const AbonelikFormu({Key key, this.tel}) : super(key: key);

  @override
  _AbonelikFormuState createState() => _AbonelikFormuState();
}

class _AbonelikFormuState extends State<AbonelikFormu> {
  TextEditingController adController = TextEditingController();

  @override
  void initState() {
    super.initState();
    adController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // inputların dışında bir yere dokunulduğunda focus node yapabilmek için gesture detector ile scaffolda sarmalandı.
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Abone Ol",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.amber,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Color(0xFFffffff),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6.0,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        height: 60.0,
                        child: TextField(
                          controller: adController,
                          keyboardType: TextInputType.name,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'OpenSans',
                              fontSize: 20,
                              letterSpacing: 1),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(top: 14.0),
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.amber,
                            ),
                            suffixIcon: adController.text.isEmpty
                                ? Text("")
                                : IconButton(
                                    icon: Icon(Icons.close),
                                    onPressed: () => adController.clear(),
                                  ),
                            hintText: 'Ad Soyad',
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 25.0),
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 10.0,
                            padding: EdgeInsets.all(15.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            primary: Color(0xFFc8b89b),
                          ),
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AboneAdres(
                                  tel: widget.tel,
                                  adsoyad: adController.text,
                                ),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(""),
                              Text(
                                'Devam Et',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontFamily: 'OpenSans',
                                ),
                              ),
                              Icon(Icons.arrow_forward),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
