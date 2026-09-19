import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'src/app.dart';
import 'src/core/logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize logger
  setupLogger();
  appLogger.i('Initializing application...');

  // Load environment variables
  await dotenv.load(fileName: ".env");

  // Initialize Supabase
  final supabaseUrl = dotenv.env['SUPABASE_URL'];
  final supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'];
  
  if (supabaseUrl != null && supabaseAnonKey != null && supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty) {
    try {
      await Supabase.initialize(
        url: supabaseUrl,
        anonKey: supabaseAnonKey,
      );
      appLogger.i('Supabase initialized successfully');
    } catch (e) {
      appLogger.e('Failed to initialize Supabase: $e');
    }
  } else {
    appLogger.w('Supabase credentials not found in .env');
  }

  runApp(const QuoteForgeApp());
}
