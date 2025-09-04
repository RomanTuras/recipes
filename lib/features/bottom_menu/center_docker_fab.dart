import 'package:flutter/material.dart';

class CenterDockedFabMenu extends StatefulWidget {
  final VoidCallback onFirstTap;
  final VoidCallback onSecondTap;

  const CenterDockedFabMenu({
    super.key,
    required this.onFirstTap,
    required this.onSecondTap,
  });

  @override
  State<CenterDockedFabMenu> createState() => _CenterDockedFabMenuState();
}

class _CenterDockedFabMenuState extends State<CenterDockedFabMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<Offset> _firstFabOffset;
  late Animation<Offset> _secondFabOffset;

  bool _isOpen = false;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 300));

    _rotationAnimation = Tween<double>(begin: 0.0, end: 0.125) // 45°
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _firstFabOffset = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(1, -1.6),
    ).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.2, 1.0, curve: Curves.easeOutBack),),);

    _secondFabOffset = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(-1, -1.6),
    ).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),),);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    if (_isOpen) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        // Left side FAB
        SlideTransition(
          position: _secondFabOffset,
          child: FadeTransition(
            opacity: _controller,
            child: FloatingActionButton(
              shape: const CircleBorder(),
              heroTag: "fab2",
              // mini: true,
              onPressed: widget.onSecondTap,
              child: const Icon(Icons.list_outlined),
            ),
          ),
        ),

        // Right side FAB
        SlideTransition(
          position: _firstFabOffset,
          child: FadeTransition(
            opacity: _controller,
            child: FloatingActionButton(
              shape: const CircleBorder(),
              heroTag: "fab1",
              // mini: true,
              onPressed: widget.onFirstTap,
              child: const Icon(Icons.folder_open_outlined),
            ),
          ),
        ),

        // Main FAB
        RotationTransition(
          turns: _rotationAnimation,
          child: FloatingActionButton(
            shape: const CircleBorder(),
            heroTag: "mainFab",
            onPressed: _toggleMenu,
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}