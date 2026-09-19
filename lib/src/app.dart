import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'core/theme.dart';
import 'features/quotes/presentation/bloc/quotes_bloc.dart';
import 'features/quotes/presentation/ui/quotes_screen.dart';
import 'features/quotes/data/repo/quotes_repository.dart';

class QuoteForgeApp extends StatelessWidget {
  const QuoteForgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Provide the repository globally or locally as needed
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<QuotesRepository>(
          create: (context) => QuotesRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<QuotesBloc>(
            create: (context) => QuotesBloc(
              quotesRepository: context.read<QuotesRepository>(),
            ),
          ),
        ],
        child: MaterialApp.router(
          title: 'QuoteForge',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          routerConfig: _router,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const QuotesScreen(),
    ),
  ],
);
