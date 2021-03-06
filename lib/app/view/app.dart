// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

// ignore_for_file: public_member_api_docs, avoid_print

import 'dart:async' as async;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:unpuzzle_it_abhi/custom/custom.dart';
import 'package:unpuzzle_it_abhi/helpers/helpers.dart';
import 'package:unpuzzle_it_abhi/puzzle/puzzle.dart';

class App extends StatefulWidget {
  App(this.themeIndex,
      {Key? key, ValueGetter<PlatformHelper>? platformHelperFactory})
      : _platformHelperFactory = platformHelperFactory ?? getPlatformHelper,
        super(key: key);

  final ValueGetter<PlatformHelper> _platformHelperFactory;
  int themeIndex;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  /// The path to local assets folder.
  static const localAssetsPrefix = 'assets/';

  static final audioControlAssets = [
    'assets/images/audio_control/simple_on.png',
    'assets/images/audio_control/simple_off.png',
    'assets/images/audio_control/dashatar_on.png',
    'assets/images/audio_control/green_dashatar_off.png',
    'assets/images/audio_control/blue_dashatar_off.png',
    'assets/images/audio_control/yellow_dashatar_off.png',
  ];

  static final audioAssets = [
    'assets/audio/shuffle.mp3',
    'assets/audio/click.mp3',
    'assets/audio/blue.mp3',
    'assets/audio/path.mp3',
    'assets/audio/custom.mp3',
    'assets/audio/success.mp3',
    'assets/audio/tile_move.mp3',
    'assets/audio/back_medium.mp3',
    'assets/audio/back_custom.mp3',
    'assets/audio/back_path.mp3',
    'assets/audio/spinwheel_success.mp3',
    'assets/audio/spinwheel.mp3',
    'assets/audio/confetti.mp3',
  ];

  late final PlatformHelper _platformHelper;
  late final async.Timer _timer;
  late final SplashScreen splashScreen;

  @override
  void initState() {
    super.initState();
    splashScreen = const SplashScreen();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    _platformHelper = widget._platformHelperFactory();

    _timer = async.Timer(const Duration(milliseconds: 20), () {
      for (var i = 1; i <= 15; i++) {
        precacheImage(
          Image.asset('assets/images/parallax/bg.png').image,
          context,
        );
        precacheImage(
          Image.asset('assets/images/help.png').image,
          context,
        );
        precacheImage(
          Image.asset('assets/images/badge.png').image,
          context,
        );
        precacheImage(
          Image.asset('assets/images/parallax/mountain-far.png').image,
          context,
        );
        precacheImage(
          Image.asset('assets/images/parallax/foreground-trees.png').image,
          context,
        );
        precacheImage(
          Image.asset('assets/images/splash/roulette.png').image,
          context,
        );
        precacheImage(
          Image.asset('assets/images/splash/roulette-center.png').image,
          context,
        );
        // precacheImage(
        //   Image.asset('assets/images/splash/hello.gif').image,
        //   context,
        // );
        precacheImage(
          Image.asset('assets/images/splash/happy.gif').image,
          context,
        );
        precacheImage(
          Image.asset('assets/images/splash/angry.gif').image,
          context,
        );
        precacheImage(
          Image.asset('assets/images/splash/bored.gif').image,
          context,
        );
        // precacheImage(
        //   Image.asset('assets/images/dashatar/custom/$i.png').image,
        //   context,
        // );
        precacheImage(
          Image.asset('assets/images/dashatar/blue/$i.png').image,
          context,
        );
        precacheImage(
          Image.asset('assets/images/dashatar/path/$i.png').image,
          context,
        );
      }
      precacheImage(
        Image.asset('assets/images/dashatar/gallery/custom.png').image,
        context,
      );
      precacheImage(
        Image.asset('assets/images/dashatar/success/custom.png').image,
        context,
      );
      precacheImage(
        Image.asset('assets/images/dashatar/gallery/blue.png').image,
        context,
      );
      precacheImage(
        Image.asset('assets/images/dashatar/success/blue.png').image,
        context,
      );
      precacheImage(
        Image.asset('assets/images/dashatar/gallery/path.png').image,
        context,
      );
      precacheImage(
        Image.asset('assets/images/dashatar/success/path.png').image,
        context,
      );
      precacheImage(
        Image.asset('assets/images/logo_flutter_color.png').image,
        context,
      );
      precacheImage(
        Image.asset('assets/images/logo_flutter_white.png').image,
        context,
      );
      precacheImage(
        Image.asset('assets/images/timer_icon.png').image,
        context,
      );
      precacheImage(
        Image.asset('assets/images/twitter_icon.png').image,
        context,
      );
      precacheImage(
        Image.asset('assets/images/facebook_icon.png').image,
        context,
      );

      for (final audioControlAsset in audioControlAssets) {
        precacheImage(
          Image.asset(audioControlAsset).image,
          context,
        );
      }

      for (final audioAsset in audioAssets) {
        prefetchToMemory(audioAsset);
      }
    });
  }

  /// Prefetches the given [filePath] to memory.
  Future<void> prefetchToMemory(String filePath) async {
    if (_platformHelper.isWeb) {
      // We rely on browser caching here. Once the browser downloads the file,
      // the native implementation should be able to access it from cache.
      await http.get(Uri.parse('$localAssetsPrefix$filePath'));
      return;
    }
    // throw UnimplementedError(
    //   'The function `prefetchToMemory` is not implemented '
    //   'for platforms other than Web.',
    // );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void splashCallback(int themeindex) {
    setState(() {
      widget.themeIndex = themeindex;
    });
  }

  Future<bool> _onWillPop() async {
    return AllUtils.onWillPop(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Stack(
          children: [
            PuzzlePage(widget.themeIndex),
            // SplashScreen(
            //   callback: splashCallback,
            // )
          ],
        ),
      ),
    );
  }
}
