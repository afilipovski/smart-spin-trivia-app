import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_app/features/questions/bloc/question_bloc.dart';
import 'package:trivia_app/trivia_app_bloc_observer.dart';
import 'package:trivia_app/core/services/category_service.dart';
import 'package:trivia_app/features/category/bloc/category_bloc.dart';
import 'package:trivia_app/features/category/view/category_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const TriviaAppBlocObserver();

  runApp(
    RepositoryProvider(
      create: (context) => CategoryService(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CategoryBloc>(
            create: (BuildContext context) =>
                CategoryBloc(context.read<CategoryService>()),
          ),
          BlocProvider<QuestionBloc>(
            create: (BuildContext context) =>
                QuestionBloc(context.read<CategoryService>()),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trivia Applicaction',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
      home: const CategoryScreen(),
    );
  }
}
