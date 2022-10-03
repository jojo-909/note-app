import 'dart:convert';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  String? _userName;
  bool newUSer = true;
  

  bool get isAuth {
    return _token != null;
  }

  String? get username {
    return _userName;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String? get userId {
    return _userId;
  }

  Future<void> _authenticate(String email, String password, String urlSegment,
      {String? userName}) async {
    final url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyD1ypqBWJ6SDxfT0MDvF9LvzcIeNDLSz_s");
    try {
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        print(responseData['error']);
        throw Error();
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      final userUrl = Uri.parse(
          'https://note-app-326cf-default-rtdb.firebaseio.com/username/${_userId}.json?auth=$_token');
      if (userName != null) {
        final userNameResponse =
            await http.put(userUrl, body: json.encode(userName));
        _userName = userName;
        print(_userName);
      } else {
        newUSer = false;
      }

      final userNameResponse = await http.get(userUrl);
      _userName = json.decode(userNameResponse.body);
      print(_userName);

      notifyListeners();
    } catch (error) {
      print('Failed Signup/SignIn');
      print(error);
      throw error;
    }
  }

  Future<void> signUp(String userName, String email, String password) async {
    return _authenticate(email, password, "signUp", userName: userName);
  }

  Future<void> signIn(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    _userName = null;
    notifyListeners();
  }
}
