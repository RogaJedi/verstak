import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../navigation_cubit.dart';

class CustomBottomBar extends StatelessWidget {
  final List<String> activeIcons;
  final List<String> inactiveIcons;
  final Function(int) onTap;
  final Color selectedColor;
  final Color unselectedColor;
  final Color splashColor;
  final Color backgroundColor;

  const CustomBottomBar({
    Key? key,
    required this.activeIcons,
    required this.inactiveIcons,
    required this.onTap,
    this.selectedColor = Colors.white,
    this.unselectedColor = Colors.white,
    this.splashColor = Colors.white,
    this.backgroundColor = const Color(0xFF187A3F),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          activeIcons.length,
              (index) => _buildNavItem(context, activeIcons[index], inactiveIcons[index], index),
        ),
      ),
    );
  }

  Widget _buildNavItem(
      BuildContext context,
      String activeIcon,
      String inactiveIcon,
      int index,
      ) {
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<NavigationCubit, int>(
      builder: (context, currentIndex) {
        final bool isSelected = currentIndex == index;
        return Expanded(
          child: Material(
            color: backgroundColor,
            child: InkWell(
              borderRadius: BorderRadius.circular(40),
              splashColor: splashColor.withValues(alpha: 0.2),
              onTap: () => onTap(index),
              child: Container(
                height: 60,
                child: Center(
                  child: SvgPicture.asset(
                    isSelected ? activeIcon : inactiveIcon,
                    width: screenWidth * 0.06,
                    height: screenWidth * 0.06,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}