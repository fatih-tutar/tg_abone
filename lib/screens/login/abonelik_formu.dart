import 'package:flutter/material.dart';

class AbonelikFormu extends StatefulWidget {
  const AbonelikFormu({Key key}) : super(key: key);

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
            "Abonelik Formu",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.amber,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            child: Column(
              children: [
                TextField(
                  controller: adController,
                  decoration: InputDecoration(
                    labelText: 'Ad Soyad',
                    labelStyle: TextStyle(color: Colors.black),
                    hintText: 'Adınızı ve soyadınızı yazınız.',
                    prefixIcon: Icon(Icons.person, color: Colors.amber),
                    suffixIcon: adController.text.isEmpty
                        ? Container(
                            width: 0,
                          )
                        : IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () => adController.clear(),
                          ),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber),
                    ),
                    // input arkaplanı ile alakalı özellikler
                    //filled: true,
                    //fillColor: Colors.amber,
                  ),
                  keyboardType: TextInputType.name,
                  // bu özellik klavyede done ifadesinin çıkmasını sağlıyor sanırım inputlar arası geçiş için iyi olabilir
                  textInputAction: TextInputAction.done,
                  autofocus: true,
                ),
                SizedBox(height: 10),
                TextField(
                  controller: adController,
                  decoration: InputDecoration(
                    labelText: 'Ad Soyad',
                    labelStyle: TextStyle(color: Colors.black),
                    hintText: 'Adınızı ve soyadınızı yazınız.',
                    prefixIcon: Icon(Icons.person, color: Colors.amber),
                    suffixIcon: adController.text.isEmpty
                        ? Container(
                            width: 0,
                          )
                        : IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () => adController.clear(),
                          ),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber),
                    ),
                    // input arkaplanı ile alakalı özellikler
                    //filled: true,
                    //fillColor: Colors.amber,
                  ),
                  keyboardType: TextInputType.name,
                  // bu özellik klavyede done ifadesinin çıkmasını sağlıyor sanırım inputlar arası geçiş için iyi olabilir
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text("Gönder"),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.amber),
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
