import 'package:flutter/material.dart';
import 'package:to_do_app/core/commons/commons.dart';
import 'package:to_do_app/core/utils/app_assets.dart';
import 'package:to_do_app/core/utils/app_strings.dart';
import 'package:to_do_app/features/auth/presentation/screens/on_boarding_screens/on_boarding_screens.dart';
import 'package:to_do_app/features/task/presentation/screens/home_screen/home_screen.dart';

import '../../../../../core/database/cache_helper.dart';
import '../../../../../core/services/service_locator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Navigate();
  }

  void Navigate() {
    bool isVisited =
        sl<CacheHelper>().getData(key: AppStrings.onBoardingKey) ?? false;
    Future.delayed(Duration(seconds: 3), () {
      navigateReplacement(
          context: context,
          screen: (isVisited) ? HomeScreen() : OnBoardingScreens());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppAssets.logo),
            SizedBox(height: 19),
            Text(
              AppStrings.appName,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontSize: 40,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
