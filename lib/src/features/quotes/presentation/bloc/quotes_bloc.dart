import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repo/quotes_repository.dart';
import 'quotes_event.dart';
import 'quotes_state.dart';
import '../../../../core/logger.dart';

class QuotesBloc extends Bloc<QuotesEvent, QuotesState> {
  final QuotesRepository quotesRepository;

  QuotesBloc({required this.quotesRepository}) : super(QuotesInitial()) {
    on<LoadQuotes>(_onLoadQuotes);
  }

  Future<void> _onLoadQuotes(LoadQuotes event, Emitter<QuotesState> emit) async {
    emit(QuotesLoading());
    try {
      appLogger.d('QuotesBloc: Loading quotes...');
      final quotes = await quotesRepository.fetchQuotes();
      emit(QuotesLoaded(quotes));
    } catch (e) {
      appLogger.e('QuotesBloc: Error loading quotes', error: e);
      emit(QuotesError(e.toString()));
    }
  }
}
