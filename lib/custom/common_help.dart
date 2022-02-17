import 'dart:async';

import 'package:flutter/material.dart';
import 'package:unpuzzle_it_abhi/layout/layout.dart';
import 'package:unpuzzle_it_abhi/theme/theme.dart';
import 'package:unpuzzle_it_abhi/typography/typography.dart';

/// {@template helpinfo}
/// Displays a help screen for few seconds
/// {@endtemplate}
class HelpInfo extends StatefulWidget {
  /// {@macro helpinfo}
  const HelpInfo({
    Key? key,
    required this.text,
    required this.duration,
  }) : super(key: key);

  final String text;
  final int duration;

  @override
  State<HelpInfo> createState() => _SplashScreenInfo();
}

class _SplashScreenInfo extends State<HelpInfo> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void exitHelp(BuildContext context) {
    Timer(const Duration(milliseconds: 2000), () async {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    exitHelp(context);

    return ResponsiveLayoutBuilder(
        small: (_, child) => child!,
        medium: (_, child) => child!,
        large: (_, child) => child!,
        child: (currentSize) {
          final padding = currentSize == ResponsiveLayoutSize.large
              ? const EdgeInsets.fromLTRB(68, 73, 68, 73)
              : (currentSize == ResponsiveLayoutSize.medium
                  ? const EdgeInsets.fromLTRB(48, 54, 48, 53)
                  : const EdgeInsets.fromLTRB(20, 99, 20, 76));
          final textStyle = (currentSize == ResponsiveLayoutSize.large
                  ? PuzzleTextStyle.headline2
                  : PuzzleTextStyle.headline3)
              .copyWith(color: Colors.white);

          final textAlign = TextAlign.center;

          return Wrap(children: [
            LayoutBuilder(builder: (context, constraints) {
              return SizedBox(
                width: constraints.maxWidth,
                child: Padding(
                  padding: padding,
                  child: AnimatedDefaultTextStyle(
                    style: textStyle,
                    duration: PuzzleThemeAnimationDuration.textStyle,
                    child: Center(
                      child: Text(
                        widget.text,
                        textAlign: textAlign,
                      ),
                    ),
                  ),
                ),
              );
            })
          ]);
        });
  }
}
