/*
import 'package:flutter/cupertino.dart';

import 'GlobalData.dart';

class AuthUtil extends ChangeNotifier {
  bool _isLoading = true;
  bool _isLoggedIn = false;

  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;

  Future<void> initialize() async {

    _isLoading = true;
    notifyListeners();
    
    
    Future.delayed(Duration(seconds: ));
    final token = GlobalData.localDataStore.getAuthToken();
 
    _isLoggedIn = token != null && token.isNotEmpty;
    _isLoading = false;

    notifyListeners();
  }

  void login(String token) {
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}*/
