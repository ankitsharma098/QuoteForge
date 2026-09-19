import 'package:equatable/equatable.dart';

abstract class QuotesState extends Equatable {
  const QuotesState();
  
  @override
  List<Object> get props => [];
}

class QuotesInitial extends QuotesState {}

class QuotesLoading extends QuotesState {}

class QuotesLoaded extends QuotesState {
  final List<String> quotes;

  const QuotesLoaded(this.quotes);

  @override
  List<Object> get props => [quotes];
}

class QuotesError extends QuotesState {
  final String message;

  const QuotesError(this.message);

  @override
  List<Object> get props => [message];
}
