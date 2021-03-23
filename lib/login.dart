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
      body: loginScreen == 0
          ? Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Image.asset("img/icon.png", height: 125, fit: BoxFit.fill),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0xFFe03543),
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
                        child: TextFormField(
                          controller: _phoneNumberController,
                          onTap: () async => {
                            if (telnosecim == 0)
                              {
                                kodlunumber = await _autoFill.hint,
                                if (kodlunumber != null)
                                  {
                                    _phoneNumberController.text =
                                        kodlunumber.substring(3),
                                  },
                                telnosecim = 1,
                              }
                          },
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'OpenSans',
                              fontSize: 20,
                              letterSpacing: 5),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(top: 14.0),
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Colors.black,
                            ),
                            hintText: 'Telefon',
                            hintStyle: TextStyle(
                                color: Colors.black,
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
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            primary: Colors.white,
                          ),
                          onPressed: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            verifyPhoneNumber();
                            setState(() {
                              loginScreen = 1;
                            });
                            CircularProgressIndicator();
                          },
                          child: Text(
                            'Giriş',
                            style: TextStyle(
                              color: Colors.black,
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
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Telefonunuza gelen altı haneli doğrulama kodunu giriniz.",
                        style: TextStyle(
                            fontSize: 17,
                            fontFamily: 'Lucida',
                            letterSpacing: 1.5,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0xFFe03543),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Color(0xFFffffff),
                          borderRadius: BorderRadius.circular(0.0),
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
                              color: Colors.black,
                              fontFamily: 'OpenSans',
                              fontSize: 20,
                              letterSpacing: 5),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(top: 14.0),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.black,
                            ),
                            hintText: 'Doğrulama Kodu',
                            hintStyle: TextStyle(
                                color: Colors.black54,
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
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            primary: Colors.white,
                          ),
                          onPressed: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            signInWithPhoneNumber();
                          },
                          child: Text(
                            'Giriş',
                            style: TextStyle(
                              color: Colors.black,
                              letterSpacing: 5,
                              fontSize: 20.0,
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
      //showSnackbar(
      //  "Telefon numarası otomatik olarak doğrulandı ve kullanıcı giriş yaptı : ${_auth.currentUser.uid}");
    };

    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      //showSnackbar(
      //  'Telefon numarası doğrulaması yapılamadı: Code: ${authException.code}. Message: ${authException.message}');
    };

    PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      //showSnackbar('Lütfen telefonunuza gönderilen sms kodunu kontrol ediniz.');
      _verificationId = verificationId;
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      //showSnackbar("Doğrulama kodu : " + verificationId);
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
      //showSnackbar(
      //  "Telefon numarası doğrulama işleme başarısızlıkla sonuçlandı: $e");
    }
  }

  Future<void> signInWithPhoneNumber() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: _smsController.text,
      );

      final User user = (await _auth.signInWithCredential(credential)).user;

      //showSnackbar("Giriş işlemi yapıldı: ${user.uid}");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CampaignPage(
            user: user,
          ),
        ),
      );
    } catch (e) {
      //showSnackbar("Giriş yapılamadı: " + e.toString());
    }
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
