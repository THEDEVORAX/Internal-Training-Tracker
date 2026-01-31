import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  bool _isDarkMode = false;
  String _language = 'en';
  String? _authToken;
  String? _userId;

  // Getters
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isDarkMode => _isDarkMode;
  String get language => _language;
  String? get authToken => _authToken;
  String? get userId => _userId;
  bool get isAuthenticated => _authToken != null && _userId != null;

  // Methods
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setLanguage(String lang) {
    _language = lang;
    notifyListeners();
  }

  void setAuthToken(String? token, String? userId) {
    _authToken = token;
    _userId = userId;
    notifyListeners();
  }

  void logout() {
    _authToken = null;
    _userId = null;
    _errorMessage = null;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void reset() {
    _isLoading = false;
    _errorMessage = null;
    _isDarkMode = false;
    _language = 'en';
    _authToken = null;
    _userId = null;
    notifyListeners();
  }
}
