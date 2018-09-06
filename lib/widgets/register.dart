import 'dart:async';

import 'package:flutter/material.dart';
import 'package:api_test/services/authenticationService.dart';
import 'package:api_test/models/phone_register.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterSection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RegisterSectionState();
  }
}

class RegisterSectionState extends State<RegisterSection> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> _message = new Future<String>.value('');
  TextEditingController _smsCodeController = new TextEditingController();
  TextEditingController _phoneNumberController = new TextEditingController();
  bool isLoggedIn;
  String verificationId;
  String testSmsCode;
  String testPhoneNumber;
  bool _load = false;

  void initState() {
    isLoggedIn = false;
    FirebaseAuth.instance.currentUser().then((user) => user != null
        ? setState(() {
            isLoggedIn = true;
          })
        : null);
    super.initState();
    setState(() {
      _phoneNumberController.text += '+977';
    });
  }

  Future<void> _testVerifyPhoneNumber() async {
    final PhoneVerificationCompleted verificationCompleted =
        (FirebaseUser user) {
      setState(() {
        _message =
            Future<String>.value('signInWithPhoneNumber auto succeeded: $user');
      });
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      setState(() {
        _message = Future<String>.value(
            'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
      });
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      this.verificationId = verificationId;
      _smsCodeController.text = testSmsCode;
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      this.verificationId = verificationId;
      _smsCodeController.text = testSmsCode;
    };

    await _auth.verifyPhoneNumber(
        phoneNumber: _phoneNumberController.text,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  Future<String> _testSignInWithPhoneNumber(String smsCode) async {
    setState(() {
      _smsCodeController.text = smsCode;
    });
    final FirebaseUser user = await _auth.signInWithPhoneNumber(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    _smsCodeController.text = '';
    return 'signInWithPhoneNumber succeeded: $user';
  }

  String _getUserInfo() {
    _auth.currentUser().then((user) {
      return user.phoneNumber.toString();
    });
  }

  Widget build(BuildContext context) {
    Widget loadingIndicator = _load
        ? new Container(
            // color: Colors.grey[300],
            width: 70.0,
            height: 70.0,
            child: new Padding(
                padding: const EdgeInsets.all(5.0),
                child: new Center(child: new CircularProgressIndicator())),
          )
        : new Container();

    if (!isLoggedIn) {
      return new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 16.0,
              right: 16.0,
            ),
            child: new TextField(
              controller: _phoneNumberController,
              decoration: const InputDecoration(
                hintText: 'Phone Number',
              ),
            ),
          ),
          new MaterialButton(
              child: const Text('Sign In'),
              onPressed: () {
                _testVerifyPhoneNumber();
                setState(() {
                  _load = true;
                });
              }),
          new Align(
            child: loadingIndicator,
            alignment: FractionalOffset.center,
          ),
          new Container(
            margin: const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 16.0,
              right: 16.0,
            ),
            child: new TextField(
              controller: _smsCodeController,
              decoration: const InputDecoration(
                hintText: 'SMS Code',
              ),
            ),
          ),
          new MaterialButton(
              child: const Text('verify code'),
              onPressed: () {
                if (_smsCodeController.text != null) {
                  setState(() {
                    _message =
                        _testSignInWithPhoneNumber(_smsCodeController.text);
                  });
                }
              }),
          new FutureBuilder<String>(
              future: _message,
              builder: (_, AsyncSnapshot<String> snapshot) {
                return new Text(snapshot.data ?? '',
                    style:
                        const TextStyle(color: Color.fromARGB(255, 0, 155, 0)));
              }),
        ],
      );
    } else {
      return new Column(
        children: <Widget>[
          new Text('logged In'),
          new RaisedButton(
            child: new Text('Log out'),
            onPressed: () {
              setState(() {
                _auth.signOut();
              });
            },
          )
        ],
      );
    }
  }
}
