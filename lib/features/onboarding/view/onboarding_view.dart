// onboarding_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabibak/core/constant/colors.dart';
import 'package:tabibak/core/constant/string.dart';
import 'package:tabibak/core/utils/on_boarding_list.dart';
import 'package:tabibak/features/onboarding/view/widget/on_boarding_bottom_nav.dart';
import 'package:tabibak/features/onboarding/view_model/cubit/on_boarding_cubit.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  void _goToLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, Routes.login);
  }

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();

    return BlocProvider(
      create: (_) => OnBoardingCubit(),
      child: Scaffold(
        body: BlocBuilder<OnBoardingCubit, OnBoardingState>(
          builder: (context, state) {
            final cubit = context.read<OnBoardingCubit>();

            return Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: onBoadingList.length,
                    onPageChanged: (index) => cubit.changePage(index),
                    itemBuilder: (context, index) {
                      final page = onBoadingList[index];
                      return Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              page.image!,
                              height: 450,
                              width: 300,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(height: 40),
                            Text(
                              page.title!,
                              style: GoogleFonts.montserrat(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color:ColorsApp.kPrimaryColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                OnBoardingBottomNav(
                  currentIndexPage: state.currentPage.toDouble(),
                  pageCount: onBoadingList.length,
                  onNext: () => cubit.nextPage(
                    onBoadingList.length,
                    () => _goToLogin(context),
                    pageController,
                  ),
                  onSkip: () => cubit.skip(() => _goToLogin(context)),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
