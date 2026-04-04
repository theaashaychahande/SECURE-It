import 'package:flutter/material.dart';

class AppStateProvider extends ChangeNotifier {
  bool _isProtected = true;
  String _trustedContactName = '';
  String _trustedContactNumber = '';
  String _language = 'English';

  bool get isProtected => _isProtected;
  String get trustedContactName => _trustedContactName;
  String get trustedContactNumber => _trustedContactNumber;
  String get language => _language;

  bool get hasTrustedContact => _trustedContactName.isNotEmpty && _trustedContactNumber.isNotEmpty;

  void toggleProtection() {
    _isProtected = !_isProtected;
    notifyListeners();
  }

  void setTrustedContact(String name, String number) {
    _trustedContactName = name;
    _trustedContactNumber = number;
    notifyListeners();
  }

  void setLanguage(String lang) {
    _language = lang;
    notifyListeners();
  }
}
