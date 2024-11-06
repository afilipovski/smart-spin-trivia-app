import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum GradientColor { pink, purple, blue, ocean, sunset, teal, other }

class ColoredCard extends StatelessWidget {
  const ColoredCard({
    super.key,
    required this.color,
    required this.isFinished,
    required this.categoryName,
    required this.onSelectTap,
  });
  final String categoryName;
  final GradientColor color;
  final bool isFinished;
  final VoidCallback onSelectTap;

  BoxDecoration _createBoxDecoration(GradientColor gradientColor) {
    return BoxDecoration(
      gradient: _getGradientForColor(gradientColor),
      borderRadius: BorderRadius.circular(35),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade400,
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }

  LinearGradient _getGradientForColor(GradientColor gradient) {
    switch (gradient) {
      case GradientColor.blue:
        return const LinearGradient(
          colors: [
            Color.fromARGB(192, 7, 0, 208),
            Color.fromARGB(225, 77, 87, 204),
            Color.fromARGB(255, 107, 145, 226),
            Color.fromARGB(234, 181, 220, 250),
          ],
        );
      case GradientColor.pink:
        return const LinearGradient(
          colors: [
            Color.fromRGBO(235, 69, 174, 0.808),
            Color.fromARGB(225, 230, 159, 79),
            Color.fromARGB(223, 250, 158, 101),
            Color.fromARGB(199, 238, 181, 100),
          ],
        );
      case GradientColor.purple:
        return const LinearGradient(
          colors: [
            Color.fromARGB(182, 113, 51, 146),
            Color.fromARGB(186, 208, 96, 169),
            Color.fromARGB(209, 240, 90, 185),
            Color.fromRGBO(221, 96, 232, 0.839),
          ],
        );
      case GradientColor.teal:
        return const LinearGradient(
          colors: [
            Color.fromARGB(255, 0, 150, 136),
            Color.fromARGB(255, 0, 188, 212),
            Color.fromARGB(255, 63, 81, 181),
            Color.fromARGB(255, 255, 87, 34),
          ],
        );
      case GradientColor.sunset:
        return const LinearGradient(
          colors: [
            Color.fromARGB(255, 255, 87, 34),
            Color.fromARGB(255, 255, 193, 7),
            Color.fromARGB(255, 255, 183, 77),
            Color.fromARGB(255, 255, 138, 101),
          ],
        );
      case GradientColor.ocean:
        return const LinearGradient(
          colors: [
            Color.fromARGB(255, 0, 172, 193),
            Color.fromARGB(255, 0, 150, 136),
            Color.fromARGB(255, 3, 169, 244),
            Color.fromARGB(255, 25, 118, 210),
          ],
        );
      case GradientColor.other:
        return const LinearGradient(
          colors: [
            Color.fromRGBO(235, 69, 174, 0.808),
            Color.fromARGB(225, 230, 159, 79),
            Color.fromARGB(223, 250, 158, 101),
            Color.fromARGB(199, 238, 181, 100),
          ],
        );
      default:
        return const LinearGradient(
          colors: [
            Color.fromRGBO(235, 69, 174, 0.808),
            Color.fromARGB(225, 230, 159, 79),
            Color.fromARGB(223, 250, 158, 101),
            Color.fromARGB(199, 238, 181, 100),
          ],
        );
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            height: 160,
            decoration: _createBoxDecoration(color),
            child: _CategoryCard(
              isFinished: isFinished,
              categoryName: categoryName,
              onCategorySelect: onSelectTap,
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard(
      {required this.isFinished,
      required this.categoryName,
      required this.onCategorySelect});
  final String categoryName;
  final bool isFinished;
  final VoidCallback onCategorySelect;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Column(
          children: [
            ClipRRect(
              clipBehavior: Clip.hardEdge,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: Colors.grey.withOpacity(0.1),
                  onTap: onCategorySelect,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(35),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      height: 120,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            left: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(22),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  isFinished == true
                                      ? Icons.check
                                      : Icons.play_arrow,
                                  size: 35,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            child: Text(
                              categoryName,
                              style: GoogleFonts.nunito(
                                textStyle: const TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 30,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
