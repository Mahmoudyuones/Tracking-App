import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../core/constants/app_asset.dart';
import '../../../../core/constants/app_text_string.dart';
import '../../../../core/style/color/app_colors.dart';
import '../../../../core/style/widget/shared_lottie_states_widget.dart';


class OnBoardingScreen extends StatefulWidget{
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}
class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: '1.0.0',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );
  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Padding(
          padding:  const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
            
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Lottie.asset(
                  AppAsset.deliveryAnimationPath,
                  width: screenSize.width * 0.4,
                  height: screenSize.height * 0.4,
                  fit: BoxFit.contain,
                  repeat: true,
                ),
                 SizedBox(
                     height: screenSize.height*0.02),
                Text(
                  AppTextString.onboarding,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black
                  ),
                ),
                Text(
                  AppTextString.onboarding2,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black
                  ),
                ),
                 SizedBox(
                     height: screenSize.height*0.01),
                ElevatedButton(
                  onPressed: (){},
                  style: ElevatedButton.styleFrom(
                      backgroundColor:AppColors.primary,
                      padding:  const EdgeInsets.symmetric(vertical:20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)
                      )
                  ), child:
                Center(

                  child: Text(
                    AppTextString.login,
                    style:  const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white
                    ),
                  ),
                ),
            
                ),
                 SizedBox(
                     height: screenSize.height*0.01),
                OutlinedButton(
                  onPressed: (){},
                  style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.black),
                      padding:  EdgeInsets.symmetric(vertical:20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)
                      )
                  ), child:
                Center(

                  child:  Text(
                    AppTextString.applyNow,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black
                    ),
                  ),
                ),
            
                ),
                 SizedBox(
                     height: screenSize.height*0.1
                 ),
                Center(
                  child: Text(
                    _packageInfo.version,
                    textAlign: TextAlign.center,
                    style:  TextStyle(
                        fontSize:14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black
                    ),
                  ),
                ),
            
              ],
            ),
          ),
        )
    );
  }
  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }
}