import '../../../core/logger.dart';

class QuotesRepository {
  QuotesRepository();

  Future<List<String>> fetchQuotes() async {
    try {
      appLogger.i('Fetching quotes from repository...');
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      
      final mockQuotes = ['Quote 1: Paint Job', 'Quote 2: Plumbing', 'Quote 3: Electrical Repair'];
      appLogger.i('Successfully fetched ${mockQuotes.length} quotes.');
      
      return mockQuotes;
    } catch (e, stackTrace) {
      appLogger.e('Error fetching quotes', error: e, stackTrace: stackTrace);
      throw Exception('Failed to fetch quotes');
    }
  }
}
