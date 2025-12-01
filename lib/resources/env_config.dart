import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Configuration class to access environment variables
/// 
/// This class provides centralized access to all sensitive configuration
/// values that should not be hardcoded in the application.
class EnvConfig {
  // ========================================
  // Firebase Configuration
  // ========================================
  
  /// Firebase API Key for authentication
  static String get firebaseApiKey => dotenv.env['FIREBASE_API_KEY'] ?? '';
  
  /// Firebase Application ID
  static String get firebaseAppId => dotenv.env['FIREBASE_APP_ID'] ?? '';
  
  /// Firebase Messaging Sender ID
  static String get firebaseMessagingSenderId =>
      dotenv.env['FIREBASE_MESSAGING_SENDER_ID'] ?? '';
  
  /// Firebase Project ID
  static String get firebaseProjectId => dotenv.env['FIREBASE_PROJECT_ID'] ?? '';
  
  /// Firebase Auth Domain
  static String get firebaseAuthDomain =>
      dotenv.env['FIREBASE_AUTH_DOMAIN'] ?? '';
  
  /// Firebase Storage Bucket
  static String get firebaseStorageBucket =>
      dotenv.env['FIREBASE_STORAGE_BUCKET'] ?? '';

  // ========================================
  // Google Apps Script APIs
  // ========================================
  
  /// Main PREMI API endpoint (Google Apps Script)
  /// Used for: desplegables, dialogs, todos, nuevo, file_uploader
  static String get apiPremi => dotenv.env['API_PREMI'] ?? '';
  
  /// Login/Users API endpoint (Google Apps Script)
  /// Used for: login registration, user management
  static String get apiLogin => dotenv.env['API_LOGIN'] ?? '';
  
  /// Get PREMI API as Uri
  static Uri get apiPremiUri => Uri.parse(apiPremi);
  
  /// Get Login API as Uri
  static Uri get apiLoginUri => Uri.parse(apiLogin);
}

