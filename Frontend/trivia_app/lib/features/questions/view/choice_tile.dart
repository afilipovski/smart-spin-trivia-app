import 'package:flutter/material.dart';
import 'package:trivia_app/features/questions/constants/app_colors.dart';

class ChoiceTile extends StatelessWidget {
  final String option;
  final bool isSelected;
  final VoidCallback onTap;
  const ChoiceTile({
    super.key,
    required this.option,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.purple.shade100 : Colors.white,
          border: Border.all(
              color: isSelected
                  ? AppColors.mainPurpleShade
                  : AppColors.greyTileBackground),
          borderRadius: BorderRadius.circular(
            8.0,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(
              8.0,
            ),
            overlayColor: WidgetStatePropertyAll(
              AppColors.mainPurpleShade.withValues(
                alpha: 0.1,
              ),
            ),
            onTap: onTap,
            child: ListTile(
              title: Text(option),
              trailing: isSelected
                  ? const Icon(
                      Icons.check_circle,
                      color: AppColors.mainPurpleShade,
                    )
                  : Icon(
                      Icons.circle_outlined,
                      color: AppColors.greyTileBackground,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
