import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../constants/app_text_string.dart';
import '../../style/color/app_colors.dart';


class UIUtils {

  static void showEasyLoading({String? status}) {
    EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.ripple;
    EasyLoading.instance.indicatorSize = 45.0;
    EasyLoading.instance.loadingStyle = EasyLoadingStyle.custom;
    EasyLoading.instance.radius = 10.0;
    EasyLoading.instance.backgroundColor = AppColors.mainBase;
    EasyLoading.instance.indicatorColor = AppColors.whiteBase;
    EasyLoading.instance.textColor = AppColors.whiteBase;
    EasyLoading.instance.maskType = EasyLoadingMaskType.black;
    EasyLoading.show(status:status?? AppTextString.loading);
  }
  // static void showLoading(BuildContext context) => showDialog(
  //   context: context,
  //   barrierDismissible: false,
  //   builder: (_) => PopScope(
  //     canPop: false,
  //     child: AlertDialog(
  //       backgroundColor: Colors.transparent,
  //       content: SizedBox(
  //         height: MediaQuery.sizeOf(context).height * 0.2,
  //         child: const LoadingIndicator(),
  //       ),
  //     ),
  //   ),
  // );

  static void hideLoading(BuildContext context) => Navigator.of(context).pop();

  static void showMessage(
      String message, {
        required Color backGroundColor,
        required Color textColor,
      }) => Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    backgroundColor: backGroundColor,
    textColor: textColor,
  );
}
