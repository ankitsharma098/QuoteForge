import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/quotes_bloc.dart';
import '../bloc/quotes_event.dart';
import '../bloc/quotes_state.dart';

class QuotesScreen extends StatefulWidget {
  const QuotesScreen({super.key});

  @override
  State<QuotesScreen> createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<QuotesBloc>().add(LoadQuotes());
  }

  @override
  Widget build(BuildContext context) {
    // Utilize theme and media queries properly
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('QuoteForge'),
        backgroundColor: theme.colorScheme.primaryContainer,
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: BlocBuilder<QuotesBloc, QuotesState>(
          builder: (context, state) {
            if (state is QuotesInitial || state is QuotesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is QuotesLoaded) {
              final quotes = state.quotes;
              if (quotes.isEmpty) {
                return const Center(child: Text('No quotes found.'));
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: quotes.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 12.0),
                    child: ListTile(
                      title: Text(
                        quotes[index],
                        style: theme.textTheme.titleMedium,
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        // TODO: Navigate to quote details
                      },
                    ),
                  );
                },
              );
            } else if (state is QuotesError) {
              return Center(
                child: Text(
                  'Error: ${state.message}',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.error,
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Refresh or create new quote
          context.read<QuotesBloc>().add(LoadQuotes());
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
