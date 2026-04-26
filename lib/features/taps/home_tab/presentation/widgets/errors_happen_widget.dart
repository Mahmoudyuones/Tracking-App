import 'package:flutter/material.dart';
import '../../../../../core/style/widget/shared_lottie_states_widget.dart';

class ErrorsOrEmptyHappenWidget extends StatelessWidget {
  const ErrorsOrEmptyHappenWidget({
    super.key,
    required this.text,
    required this.lottie,
  });

  final String text;
  final String lottie;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [SharedLottieStatesWidget(lottie: lottie, text: text)],
    );
  }
}
