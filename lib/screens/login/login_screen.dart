import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:tg_abone_fapp/screens/abonelik/abone_tel.dart';

import '../home_screen.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();
  final SmsAutoFill _autoFill = SmsAutoFill();

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String verificationId;
  bool showLoading = false;
  String kodlunumber;
  int telnosecim;
  String telnoerror;
  int koderror;
  bool aboneMi = false;

  @override
  void initState() {
    telnosecim = 0;
    telnoerror = "";
    koderror = 0;
    super.initState();
  }

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });
    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        showLoading = false;
      });
      if (authCredential.user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      setState(() {
        showLoading = false;
        koderror = 1;
      });
    }
  }

  getMobileFormWidget(context) {
    return Column(
      children: [
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
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold),
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
                    primary: Color(0xFFf1faee),
                  ),
                  onPressed: () async {
                    if (_phoneNumberController.text.isEmpty ||
                        _phoneNumberController.text.length != 10) {
                      setState(() {
                        showLoading = false;
                        telnoerror =
                            "Telefon numaranızı başında sıfır olmadan ve boşluk bırakmadan  10 haneli olacak şekilde giriniz.";
                      });
                    } else {
                      setState(() {
                        showLoading = true;
                      });
                      FocusScope.of(context).requestFocus(FocusNode());
                      String editedPhoneNumber =
                          "+90" + _phoneNumberController.text;

                      CollectionReference aboneRef =
                          _firestore.collection('aboneler');
                      var response = await aboneRef.get();
                      var aboneListesi = response.docs;
                      aboneListesi.forEach((abone) {
                        if (abone.id == _phoneNumberController.text) {
                          aboneMi = true;
                        }
                      });

                      if (aboneMi == true) {
                        await _auth.verifyPhoneNumber(
                          phoneNumber: editedPhoneNumber,
                          verificationCompleted: (phoneAuthCredential) async {
                            setState(() {
                              showLoading = false;
                            });
                            //signInWithPhoneAuthCredential(phoneAuthCredential);
                          },
                          verificationFailed: (verificationFailed) async {
                            setState(() {
                              showLoading = false;
                              telnoerror =
                                  "Doğrulama kodunuzu defaatle yanlış girdiğiniz için numaranız bloke olmuştur. Daha sonra tekrar deneyiniz.";
                            });
                          },
                          codeSent: (verificationId, resendingToken) async {
                            setState(() {
                              showLoading = false;
                              currentState =
                                  MobileVerificationState.SHOW_OTP_FORM_STATE;
                              this.verificationId = verificationId;
                            });
                          },
                          codeAutoRetrievalTimeout: (verificationId) async {},
                        );
                      } else {
                        setState(() {
                          showLoading = false;
                          telnoerror =
                              "Bu numara ile abonelik bulunmamaktadır.";
                        });
                      }
                    }
                    CircularProgressIndicator();
                  },
                  child: Text(
                    'Kod Gönder',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        telnoerror != ""
            ? Container(
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
                      telnoerror,
                      style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'OpenSans',
                          letterSpacing: 1.5,
                          color: Colors.black),
                    ),
                  ],
                ),
              )
            : Container(),
        SizedBox(height: 20),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 10,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AboneTel()));
            },
            child: Text("Abonelik Formu"),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.amber),
              foregroundColor: MaterialStateProperty.all(Colors.black),
              elevation: MaterialStateProperty.all(10.0),
              textStyle: MaterialStateProperty.all(TextStyle(
                fontSize: 20,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
              )),
            ),
          ),
        ),
      ],
    );
  }

  getOtpFormWidget(context) {
    CountDownController _controller = CountDownController();
    return Column(
      children: [
        CircularCountDownTimer(
          width: MediaQuery.of(context).size.width / 2.5,
          height: MediaQuery.of(context).size.height / 2.5,
          duration: 180,
          fillColor: Color(0xFFe03543),
          ringColor: Colors.white,
          controller: _controller,
          backgroundColor: Colors.white54,
          strokeWidth: 10.0,
          strokeCap: StrokeCap.round,
          isTimerTextShown: true,
          isReverse: true,
          onComplete: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
            );
          },
          textStyle: TextStyle(fontSize: 50.0, color: Color(0xFFe03543)),
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
                        color: Colors.black54, fontSize: 20, letterSpacing: 2),
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
                    if (_smsController.text.length != 6) {
                      setState(() {
                        koderror = 1;
                      });
                    } else {
                      FocusScope.of(context).requestFocus(FocusNode());
                      PhoneAuthCredential phoneAuthCredential =
                          PhoneAuthProvider.credential(
                              verificationId: verificationId.toString(),
                              smsCode: _smsController.text);
                      signInWithPhoneAuthCredential(phoneAuthCredential);
                    }
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
        SizedBox(height: 20),
        koderror == 1
            ? Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.orange,
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
                child: Text(
                  "Yazdığınız kod hatalıdır. Mesajla gelen kodu lütfen kontrol ediniz.",
                  style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'Lucida',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      color: Colors.white),
                ),
              )
            : Container()
      ],
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        key: _scaffoldKey,
        body: Container(
          child: showLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      currentState ==
                              MobileVerificationState.SHOW_MOBILE_FORM_STATE
                          ? getMobileFormWidget(context)
                          : getOtpFormWidget(context),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
