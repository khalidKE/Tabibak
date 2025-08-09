import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tabibak/core/utils/on_boarding_list.dart';
import 'package:tabibak/features/onboarding/data/models/on_boarding_model.dart';

class OnBoardingPages extends StatelessWidget {
  final PageController controller;
  final List<OnBoardingModel> pages;

  const OnBoardingPages({
    super.key,
    required this.controller,
    required this.pages,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      itemCount: pages.length,
      itemBuilder: (context, index) {
        final page = pages[index];
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
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
