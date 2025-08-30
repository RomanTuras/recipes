import 'package:flutter/material.dart';
import 'package:recipes/features/favorites/favorites_screen.dart';

import '../../core/constants/common_const.dart';
import '../home/home_screen.dart';

class MainTabsScreen extends StatefulWidget {
  const MainTabsScreen({super.key});

  @override
  State<MainTabsScreen> createState() => _MainTabsScreenState();
}

class _MainTabsScreenState extends State<MainTabsScreen> {
  int _index = ScreenTabs.home.index;
  late List<Widget> _tabs;

  void _onTabSelected(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabs = [
      HomeScreen(),
      FavoritesScreen(),
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // final screenUtil = ScreenUtil(context: context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: IndexedStack(index: _index, children: _tabs),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsetsGeometry.only(bottom: 4),
        height: 60.0,
        color: Colors.transparent,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ConstrainedBox(
            // constraints: BoxConstraints(maxWidth: screenUtil.cardWidth),
            constraints: BoxConstraints(maxWidth: 250),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                color: Colors.black54,//bottomBarBgColor,
                // padding: EdgeInsets.symmetric(vertical: screenUtil.isTablet ? 10.0 : 10.0),
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildTab(icon: Icons.home, label: ScreenTabs.home.name, index: ScreenTabs.home.index),
                    _buildTab(icon: Icons.shopping_cart, label: ScreenTabs.favorite.name, index: ScreenTabs.favorite.index),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTab({
    required IconData icon,
    required String label,
    required int index,
    // required ScreenUtil? screenUtil,
  }) {
    final isSelected = _index == index;

    return GestureDetector(
      onTap: () {
        setState(() => _index = index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.ease,
            // Padding between border and age
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), // Outer radius
              // color: isSelected ? blue20Color : white20Color,
              color: isSelected ? Colors.blue : Colors.white70,
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.ease,
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7), // Inner (solid border) radius
                border: Border.all(
                  // color: isSelected ? blueColor : whiteColor,
                  color: isSelected ? Colors.blue : Colors.white70,
                  width: 1,
                ),
              ),
              child: TweenAnimationBuilder<Color?>(
                tween: ColorTween(
                  // begin: isSelected ? whiteColor : blueColor,
                  begin: isSelected ? Colors.white70 : Colors.blue,
                  // end: isSelected ? blueColor : whiteColor,
                  end: isSelected ? Colors.blue : Colors.white70,
                ),
                duration: const Duration(milliseconds: 200),
                builder: (BuildContext context, Color? value, Widget? child) {
                  return Icon(
                    icon,
                    color: value,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}