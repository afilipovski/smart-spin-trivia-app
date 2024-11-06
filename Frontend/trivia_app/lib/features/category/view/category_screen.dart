import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trivia_app/features/category/bloc/category_bloc.dart';
import 'package:trivia_app/features/category/bloc/category_event.dart';
import 'package:trivia_app/features/category/bloc/category_state.dart';
import 'package:trivia_app/features/category/view/colored_card.dart';
import 'package:trivia_app/features/category/view/categories_state_update_page.dart';
import 'package:trivia_app/features/questions/view/questions_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<CategoryBloc>(context).add(
      CategoryInitialLoad(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Random random = Random();
    return Scaffold(
      body: BlocConsumer<CategoryBloc, CategoriesState>(
        buildWhen: (previous, current) => previous is! CategoryLoadSuccess,
        builder: (BuildContext context, CategoriesState state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Let\'s play',
                            style: GoogleFonts.nunito(
                              textStyle: const TextStyle(
                                color: Color.fromARGB(255, 220, 63, 144),
                                fontSize: 38,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (state is CategoryLoadSuccess)
                      Column(
                        children: state.categories.map(
                          (category) {
                            final GradientColor color =
                                GradientColor.values[random.nextInt(
                              GradientColor.values.length,
                            )];
                            return ColoredCard(
                              isFinished: true,
                              categoryName: category.name,
                              color: GradientColor.values[
                                  random.nextInt(GradientColor.values.length)],
                              onSelectTap: () {
                                BlocProvider.of<CategoryBloc>(context).add(
                                  CategorySelected(category, color),
                                );
                              },
                            );
                          },
                        ).toList(),
                      )
                    else if (state is CategoiesLoadFailed)
                      const CategoriesStateUpdatePage(
                        emojiToBeDisplayed: '😭',
                        messageToBeDisplayed: 'Something went wrong!',
                      )
                    else if (state is CategoriesLoadInProgress)
                      const CategoriesStateUpdatePage(
                        emojiToBeDisplayed: '🛸',
                        messageToBeDisplayed: 'Loading Categories...',
                      ),
                  ],
                ),
              ),
            ),
          );
        },
        listener: (BuildContext context, CategoriesState state) {
          if (state is CategoriesCardSelected) {
            BlocProvider.of<CategoryBloc>(context).add(
              CategorySelected(state.category, state.color),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => QuestionsScreen(
                  category: state.category,
                  gradientColor: state.color,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
