import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:recipes/features/cook_it/cook_it_screen.dart';
import 'package:recipes/features/favorites/favorites_screen.dart';
import 'package:recipes/features/home/home_screen.dart';
import 'package:recipes/features/shopping_list/shopping_list_screen.dart';

import '../../core/constants/common_const.dart';
import 'center_docker_fab.dart';

class BottomMenu extends StatefulWidget {
  const BottomMenu({super.key});

  @override
  State<BottomMenu> createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  int _index = ScreenTabs.home.index;
  late List<Widget> _tabs;
  final _log = Logger();

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
      CookItScreen(),
      ShoppingListScreen(),
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
      floatingActionButton: Visibility(
        visible: _index == 0,
        child: CenterDockedFabMenu(
          onFirstTap: () {
            debugPrint("First FAB tapped");
          },
          onSecondTap: () {
            debugPrint("Second FAB tapped");
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: _index == 0 ? 10 : 0,
        // padding: EdgeInsetsGeometry.only(bottom: 4),
        height: 60.0,
        // color: Colors.transparent,
        color: Colors.black12,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildTab(
              icon: Icons.home,
              label: ScreenTabs.home.name,
              index: ScreenTabs.home.index,
            ),
            _buildTab(
              icon: Icons.favorite_border_outlined,
              label: ScreenTabs.favorite.name,
              index: ScreenTabs.favorite.index,
            ),
            ?_index == 0 ? SizedBox(width: 20) : null,
            _buildTab(
              icon: Icons.cookie_outlined,
              label: ScreenTabs.cookIt.name,
              index: ScreenTabs.cookIt.index,
            ),
            _buildTab(
              icon: Icons.library_add_check_outlined,
              label: ScreenTabs.shoppingList.name,
              index: ScreenTabs.shoppingList.index,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab({
    required IconData icon,
    required String label,
    required int index,
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
              color: isSelected ? Colors.white70 : Colors.black12,
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.ease,
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                // Inner (solid border) radius
                border: Border.all(
                  color: isSelected ? Colors.orange : Colors.white70,
                  width: 1,
                ),
              ),
              child: TweenAnimationBuilder<Color?>(
                tween: ColorTween(
                  begin: isSelected ? Colors.white70 : Colors.blue,
                  end: isSelected ? Colors.orange : Colors.white70,
                ),
                duration: const Duration(milliseconds: 200),
                builder: (BuildContext context, Color? value, Widget? child) {
                  return Icon(icon, color: value);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
