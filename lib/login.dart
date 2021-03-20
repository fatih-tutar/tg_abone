import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:tg_abone_fapp/campaign_page.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();
  String _verificationId;
  final SmsAutoFill _autoFill = SmsAutoFill();
  String kodlunumber;
  int loginScreen = 0;
  int telnosecim = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.all(16),
        child: loginScreen == 0
            ? Column(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Image.asset("img/icon.png", height: 100, fit: BoxFit.fill),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
                    decoration: BoxDecoration(
                      color: Color(0xFFbd1321),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color: Color(0xFFffffff),
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6.0,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          height: 60.0,
                          child: TextFormField(
                            controller: _phoneNumberController,
                            onTap: () async => {
                              if(telnosecim == 0){
                                kodlunumber = await _autoFill.hint,
                                if(kodlunumber != null){
                                  _phoneNumberController.text =
                                    kodlunumber.substring(3),
                                },                        
                                telnosecim = 1,                                    
                              }                                
                            },
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                                color: Color(0xFFbd1321),
                                fontFamily: 'OpenSans',
                                fontSize: 20,
                                letterSpacing: 5),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 14.0),
                              prefixIcon: Icon(
                                Icons.phone,
                                color: Color(0xFFbd1321),
                              ),
                              hintText: 'Telefon',
                              hintStyle: TextStyle(
                                  color: Color(0xFFbd1321),
                                  fontSize: 20,
                                  letterSpacing: 2),
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
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              primary: Colors.white,
                            ),
                            onPressed: () async {
                              FocusScope.of(context)
                                  .requestFocus(FocusNode());
                              verifyPhoneNumber();
                              setState(() {
                                loginScreen = 1;
                              });
                            },
                            child: Text(
                              'Giriş',
                              style: TextStyle(
                                color: Color(0xFFbd1321),
                                letterSpacing: 5,
                                fontSize: 23.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'OpenSans',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Column(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Image.asset("img/icon.png", height: 100, fit: BoxFit.fill),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Telefonunuza gelen altı haneli doğrulama kodunu giriniz.",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Lucida',
                              letterSpacing: 1.5),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
                    decoration: BoxDecoration(
                      color: Color(0xFFbd1321),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color: Color(0xFFffffff),
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6.0,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          height: 60.0,
                          child: TextFormField(
                            controller: _smsController,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                                color: Color(0xFFbd1321),
                                fontFamily: 'OpenSans',
                                fontSize: 20,
                                letterSpacing: 5),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 14.0),
                              prefixIcon: Icon(
                                Icons.phone,
                                color: Color(0xFFbd1321),
                              ),
                              hintText: 'Doğrulama Kodu',
                              hintStyle: TextStyle(
                                  color: Color(0xFFbd1321),
                                  fontSize: 20,
                                  letterSpacing: 2),
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
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              primary: Colors.white,
                            ),
                            onPressed: () async {
                              FocusScope.of(context)
                                  .requestFocus(FocusNode());
                              signInWithPhoneNumber();
                            },
                            child: Text(
                              'Giriş',
                              style: TextStyle(
                                color: Color(0xFFbd1321),
                                letterSpacing: 5,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'OpenSans',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  void verifyPhoneNumber() async {
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      await _auth.signInWithCredential(phoneAuthCredential);
      final User user =
          (await _auth.signInWithCredential(phoneAuthCredential)).user;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CampaignPage(
            user: user,
          ),
        ),
      );
      showSnackbar(
          "Telefon numarası otomatik olarak doğrulandı ve kullanıcı giriş yaptı : ${_auth.currentUser.uid}");
    };

    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      showSnackbar(
          'Telefon numarası doğrulaması yapılamadı: Code: ${authException.code}. Message: ${authException.message}');
    };

    PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      showSnackbar('Lütfen telefonunuza gönderilen sms kodunu kontrol ediniz.');
      _verificationId = verificationId;
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      showSnackbar("Doğrulama kodu : " + verificationId);
      _verificationId = verificationId;
    };
    String editedPhoneNumber = "+90" + _phoneNumberController.text;
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: editedPhoneNumber,
          timeout: const Duration(seconds: 5),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      showSnackbar(
          "Telefon numarası doğrulama işleme başarısızlıkla sonuçlandı: $e");
    }
  }

  Future<void> signInWithPhoneNumber() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: _smsController.text,
      );

      final User user = (await _auth.signInWithCredential(credential)).user;

      showSnackbar("Giriş işlemi yapıldı: ${user.uid}");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CampaignPage(
            user: user,
          ),
        ),
      );
    } catch (e) {
      showSnackbar("Giriş yapılamadı: " + e.toString());
    }
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
