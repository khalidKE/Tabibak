// on_boarding_cubit.dart
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(const OnBoardingState());

  void changePage(int index) {
    emit(state.copyWith(currentPage: index));
  }

  void nextPage(int totalPages, void Function() goToLogin, PageController controller) {
    if (state.currentPage < totalPages - 1) {
      controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      goToLogin();
    }
  }

  void skip(void Function() goToLogin) {
    goToLogin();
  }
}
