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
    final gradient = _getGradientForColor(gradientColor);
    return BoxDecoration(
      gradient: gradient,
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          // ignore: deprecated_member_use
          color: gradient.colors.first.withOpacity(0.4),
          blurRadius: 12,
          spreadRadius: 2,
          offset: const Offset(0, 6),
        ),
      ],
    );
  }

  LinearGradient _getGradientForColor(GradientColor g) {
    switch (g) {
      case GradientColor.pink:
        return const LinearGradient(
          colors: [Color(0xFFF48FB1), Color(0xFFCE93D8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case GradientColor.purple:
        return const LinearGradient(
          colors: [Color(0xFF7E57C2), Color(0xFFB39DDB)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case GradientColor.blue:
        return const LinearGradient(
          colors: [Color(0xFF42A5F5), Color(0xFF90CAF9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case GradientColor.ocean:
        return const LinearGradient(
          colors: [Color(0xFF4FC3F7), Color(0xFF0288D1)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case GradientColor.sunset:
        return const LinearGradient(
          colors: [Color(0xFFFF8A65), Color(0xFFFFB74D)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        );
      case GradientColor.teal:
        return const LinearGradient(
          colors: [Color(0xFF26A69A), Color(0xFF80CBC4)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case GradientColor.other:
      return const LinearGradient(
          colors: [Color(0xFF90A4AE), Color(0xFFCFD8DC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        height: 160,
        decoration: _createBoxDecoration(color),
        child: _CategoryCard(
          isFinished: isFinished,
          categoryName: categoryName,
          onCategorySelect: onSelectTap,
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.isFinished,
    required this.categoryName,
    required this.onCategorySelect,
  });

  final String categoryName;
  final bool isFinished;
  final VoidCallback onCategorySelect;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: onCategorySelect,
        borderRadius: BorderRadius.circular(24),
        splashColor: Colors.white24,
        highlightColor: Colors.white10,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Stack(
            children: [
              // Check / Play icon
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white30,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    isFinished ? Icons.check_circle : Icons.play_circle_fill,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
              ),
              // Category name
              Center(
                child: Text(
                  categoryName,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      shadows: [
                        Shadow(
                          offset: Offset(2, 2),
                          blurRadius: 4,
                          color: Colors.black26,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
