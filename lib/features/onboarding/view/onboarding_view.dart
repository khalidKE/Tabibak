
import 'package:flutter/material.dart';
import 'package:tabibak/core/constant/colors.dart';
import 'package:tabibak/core/utils/on_boarding_list.dart';
import 'package:tabibak/features/onboarding/view/widget/on_boarding_bottom_nav.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tabibak/features/auth/view/login_view.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _goToLogin() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginView()),
      (route) => false,
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _onNext() {
    if (_currentPage < onBoadingList.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _goToLogin();
    }
  }

  void _onSkip() {
    _goToLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: onBoadingList.length,
              onPageChanged: _onPageChanged,
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
                          color: ColorsApp.kPrimaryColor,
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
            currentIndexPage: _currentPage.toDouble(),
            pageCount: onBoadingList.length,
            onNext: _onNext,
            onSkip: _onSkip,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
