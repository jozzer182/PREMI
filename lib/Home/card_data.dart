import 'package:flutter/material.dart';

class CardData extends StatelessWidget {
  const CardData({
    super.key,
    required this.elevationCard,
    required this.color,
    required this.icon1,
    required this.number1,
    required this.colorText,
    required this.title1,
    required this.number2,
    required this.title2,
    required this.onHover,
    required this.onTap,
    required this.onTapDown,
  });

  final double elevationCard;
  final Color color;
  final IconData icon1;
  final int? number1;
  final Color colorText;
  final String title1;
  final int? number2;
  final String title2;
  final void Function(bool) onHover;
  final void Function() onTap;
  final void Function(TapDownDetails) onTapDown;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      excludeFromSemantics: true,
      onHover: onHover,
      onTap: onTap,
      onTapDown: onTapDown,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Card(
        elevation: elevationCard,
        color: color,
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Hero(
                    tag: "${title1}Icon",
                    child: Material(
                      type: MaterialType.transparency,
                      child: Icon(icon1),
                    ),
                  ),
                  const SizedBox(width: 5),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (number1 == null) const CircularProgressIndicator(),
                  if (number1 != null)
                    Hero(
                      tag: "${title1}n1",
                      child: Material(
                        type: MaterialType.transparency,
                        child: Text(
                          "$number1",
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: colorText,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 65,
                                  ),
                        ),
                      ),
                    ),
                  Hero(
                    tag: title1,
                    transitionOnUserGestures: true,
                    child: Material(
                      type: MaterialType.transparency,
                      child: Text(
                        title1,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: colorText,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20,
                                ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (number2 == null) const CircularProgressIndicator(),
                  if (number2 != null)
                    Hero(
                      tag: "${title1}n2",
                      child: Material(
                        type: MaterialType.transparency,
                        child: Text(
                          "$number2",
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: colorText,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 65,
                                  ),
                        ),
                      ),
                    ),
                  Hero(
                    tag: '${title1}t1',
                    child: Material(
                      type: MaterialType.transparency,
                      child: Text(
                        title2,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: colorText,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20,
                                ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}