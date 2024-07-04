import 'package:flutter/material.dart';

import 'core/models/user.dart';

class AuthNotifier extends ChangeNotifier {
  bool _isAuthenticated = false;
  bool _isSeller = false;
  User? _user;

  bool get isAuthenticated => _isAuthenticated;
  bool get isSeller => _isSeller;
  User? get user => _user;

  void login({bool isSeller = false, required User? user}) {
    _isAuthenticated = true;
    _user = user;
    _isSeller = isSeller; // Устанавливаем роль пользователя
    notifyListeners();
  }

  void logout() {
    _user = null;
    _isAuthenticated = false;
    _isSeller = false; // Сбрасываем роль пользователя
    notifyListeners();
  }
}
