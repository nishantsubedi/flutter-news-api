// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:api_test/models/phone_register.dart';

abstract class BaseAauth {
  Future<Phone> registerPhoneNumber(String phoneNo);
  Future<Phone> verifyPhoneNumber(String phoneNo);
}

class Auth implements BaseAauth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> _message = new Future<String>.value('');
  TextEditingController _smsCodeController = new TextEditingController();
  String verificationId;
  FirebaseUser user;
  String testSmsCode;
  String testPhoneNumber;
  bool success;

  Future<Phone> registerPhoneNumber(String phoneNumber) async {
    this.testPhoneNumber = phoneNumber;
    await _testVerifyPhoneNumber();

    return new Phone(_message, this.success);
  }

  Future<Phone> verifyPhoneNumber(String smsCode) async{
    this.testSmsCode = smsCode;
    return new Phone(_message, this.success);
    // return _testSignInWithPhoneNumber(smsCode);
  }

  Future<void> _testVerifyPhoneNumber() async {
    final PhoneVerificationCompleted verificationCompleted =
        (FirebaseUser user) {
      this.user = user;
      this.success = true;
      // setState(() {
      _message =
          Future<String>.value('Enter the Six digit code you have received');

      // });
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      // setState(() {
      this.success = false;

      _message = Future<String>.value('Failed Please Check your Phone number');
      // });
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
        phoneNumber: testPhoneNumber,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  Future<String> _testSignInWithPhoneNumber(String smsCode) async {
    final FirebaseUser user = await _auth.signInWithPhoneNumber(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    // _smsCodeController.text = '';
    this.success = true;
    this._message =
        Future<String>.value('signInWithPhoneNumber succeeded: $user');
  }
}
