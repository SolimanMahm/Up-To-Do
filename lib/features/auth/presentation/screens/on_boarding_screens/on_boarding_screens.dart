import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:to_do_app/core/database/cache_helper.dart';
import 'package:to_do_app/core/utils/app_colors.dart';
import 'package:to_do_app/core/utils/app_strings.dart';
import 'package:to_do_app/core/widgets/custom_text_button.dart';
import 'package:to_do_app/features/task/presentation/screens/home_screen/home_screen.dart';

import '../../../../../core/commons/commons.dart';
import '../../../../../core/services/service_locator.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../data/model/on_boarding_model.dart';

class OnBoardingScreens extends StatelessWidget {
  OnBoardingScreens({super.key});

  PageController controller = new PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              // page viewport
              child: PageView.builder(
                controller: controller,
                itemCount: OnBoardingModel.onBoardingScreens.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SizedBox(height: 34),
                      // skip
                      (index != 2)
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: CustomTextButton(
                                text: AppStrings.skip,
                                onPressed: () => controller.jumpToPage(2),
                              ))
                          : Container(height: 49),
                      // image
                      SizedBox(height: 15),
                      Image.asset(
                          OnBoardingModel.onBoardingScreens[index].imgPath),
                      // dots
                      SizedBox(height: 16),
                      SmoothPageIndicator(
                        controller: controller,
                        count: 3,
                        effect: ColorTransitionEffect(
                          activeDotColor: AppColors.text.withOpacity(0.87),
                          dotColor: AppColors.smooth,
                          dotHeight: 4,
                          dotWidth: 26.28,
                          radius: 56,
                          spacing: 8,
                        ),
                      ),
                      // title
                      SizedBox(height: 50),
                      Text(
                        OnBoardingModel.onBoardingScreens[index].title,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      // subTitle
                      SizedBox(height: 42),
                      Text(
                        OnBoardingModel.onBoardingScreens[index].subTitle,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      // buttons
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // back
                          (index != 0)
                              ? CustomTextButton(
                                  text: AppStrings.back,
                                  onPressed: () {
                                    controller.previousPage(
                                      duration: Duration(milliseconds: 1000),
                                      curve: Curves.fastLinearToSlowEaseIn,
                                    );
                                  },
                                )
                              : Container(),
                          // next
                          (index != 2)
                              ? CustomButton(
                                  text: AppStrings.next,
                                  onPressed: () {
                                    controller.nextPage(
                                        duration: Duration(
                                          milliseconds: 1000,
                                        ),
                                        curve: Curves.fastLinearToSlowEaseIn);
                                  },
                                  size: Size(90, 48),
                                  redius: 4,
                                  color: AppColors.rectangleButton,
                                )
                              : CustomButton(
                                  text: AppStrings.getStarted,
                                  onPressed: () async {
                                    await sl<CacheHelper>()
                                        .saveData(
                                            key: AppStrings.onBoardingKey,
                                            value: true)
                                        .then(
                                          (value) => navigateReplacement(
                                            context: context,
                                            screen: HomeScreen(),
                                          ),
                                        )
                                        .catchError((e) => print(e.toString()));
                                  },
                                  size: Size(151, 48),
                                  redius: 4,
                                  color: AppColors.rectangleButton)
                        ],
                      ),
                    ],
                  );
                },
              ),
            )
            // skip button
          ],
        ),
      ),
    );
  }
}
