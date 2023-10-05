import 'package:flutter/material.dart';
import 'package:regular_rectangle_packer/src/regular_rectangle_packer.dart';

class AnimatedRegularRectanglePacker extends StatefulWidget {
  AnimatedRegularRectanglePacker(
      {super.key, required this.initialItems, this.cellRatio = 1});

  final List<Widget> initialItems;
  final double cellRatio;

  @override
  State<AnimatedRegularRectanglePacker> createState() =>
      AnimatedRegularRectanglePackerState();
}

class AnimatedRegularRectanglePackerState
    extends State<AnimatedRegularRectanglePacker> {
  late List<Hero> items = List.generate(widget.initialItems.length, (index) {
    return Hero(tag: index, child: widget.initialItems[index]);
  });

  Widget Function(Animation, Widget) defaultExitAnimation = (anim, child) {
    return child;
  };

  void removeItem(int index) {
    final itemIndex = items.indexWhere((hero) => hero.tag == index);
    items.removeAt(itemIndex);

    navKey.currentState?.pushReplacement(_getRoute());
  }

  final navKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navKey,
      observers: [HeroController()],
      onGenerateRoute: (settings) {
        return _getRoute();
      },
    );
  }

  PageRoute _getRoute() {
    return PageRouteBuilder(pageBuilder: (_, __, ___) {
      return RegularRectanglePacker(items: items);
    });
  }
}
