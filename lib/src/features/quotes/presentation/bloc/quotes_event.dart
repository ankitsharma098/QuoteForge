import 'package:equatable/equatable.dart';

abstract class QuotesEvent extends Equatable {
  const QuotesEvent();

  @override
  List<Object> get props => [];
}

class LoadQuotes extends QuotesEvent {}
