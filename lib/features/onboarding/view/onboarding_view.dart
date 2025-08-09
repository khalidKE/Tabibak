import 'package:flutter/material.dart';
import 'package:tabibak/core/utils/on_boarding_list.dart';
import 'package:tabibak/features/onboarding/view/widget/on_boarding_bottom_nav.dart';
import 'package:tabibak/features/onboarding/view/widget/on_boarding_pages.dart';
import 'package:tabibak/core/constant/string.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _goToLogin() {
    Navigator.pushReplacementNamed(context, Routes.login);
  }

  void _nextPage() {
    if (_currentPage < onBoadingList.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _goToLogin();
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: OnBoardingPages(
              controller: _pageController,
              pages: onBoadingList,
            ),
          ),
          OnBoardingBottomNav(
            currentIndexPage: _currentPage.toDouble(),
            pageCount: onBoadingList.length,
            onNext: _nextPage,
            onSkip: _goToLogin,
          ),
        ],
      ),
    );
  }
}
