import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tabibak/core/constant/colors.dart';

class OnBoardingBottomNav extends StatelessWidget {
  final double currentIndexPage;
  final int pageCount;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const OnBoardingBottomNav({
    super.key,
    required this.currentIndexPage,
    required this.pageCount,
    required this.onNext,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 32, bottom: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onSkip,
            child: Text(
              "Skip",
              style: GoogleFonts.montserrat(
                color: ColorsApp.kPrimaryColor,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          DotsIndicator(
            dotsCount: pageCount,
            position: currentIndexPage,
            decorator: DotsDecorator(
              color: Colors.grey,
              activeColor: ColorsApp.kPrimaryColor,
              size: const Size(8, 8),
              activeSize: const Size(10, 10),
            ),
          ),
          GestureDetector(
            onTap: onNext,
            child: Text(
              "Next",
              style: GoogleFonts.montserrat(
                color: ColorsApp.kPrimaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
