import 'package:flutter/material.dart';

class Accordion extends StatelessWidget {
  final Widget openWidget;
  final Widget closedWidget;
  final bool open;
  final VoidCallback onButtonTap;

  const Accordion({
    Key? key,
    required this.openWidget,
    required this.closedWidget,
    required this.open,
    required this.onButtonTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      crossFadeState: open ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 300),
      sizeCurve: Curves.easeInOutExpo,
      firstCurve: Curves.easeInOutExpo,
      secondCurve: Curves.easeInOutExpo,
      firstChild: Stack(
        children: [
          closedWidget,
          Positioned.fill(
            top: 4,
            right: 20,
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: onButtonTap,
                icon: const Icon(Icons.keyboard_arrow_down),
              ),
            ),
          )
        ],
      ),
      secondChild: Stack(
        children: [
          openWidget,
          Positioned.fill(
            top: 4,
            right: 20,
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: onButtonTap,
                icon: const Icon(Icons.keyboard_arrow_up),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
