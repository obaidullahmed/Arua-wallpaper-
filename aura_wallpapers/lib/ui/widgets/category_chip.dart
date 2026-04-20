import 'package:flutter/material.dart';
import '../../core/enums/wallpaper_category.dart';

class CategoryChip extends StatelessWidget {
  final WallpaperCategory category;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryChip({super.key, required this.category, required this.onTap, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
        decoration: BoxDecoration(
          color: isSelected ? Colors.purpleAccent : const Color(0xFF1F2A3B),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white12),
        ),
        child: Text(
          category.displayName,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white70,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
