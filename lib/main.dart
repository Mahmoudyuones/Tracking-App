import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'config/bloc_observer/my_bloc_observer.dart';
import 'config/di/di.dart';
import 'config/integreations/firebase/fcm_services.dart';
import 'core/constants/app_asset.dart';
import 'core/constants/app_text_string.dart';
import 'core/routes/app_router_config.dart';
import 'core/style/theme/app_theme.dart';
import 'config/integreations/firebase/firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await FCMService.setupFlutterNotifications();
  FCMService.showFlutterNotification(message);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FCMService.setupFlutterNotifications();

  await configureDependencies();
  Bloc.observer = MyBlocObserver();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale(AppTextString.enLangKey),
        Locale(AppTextString.arLangKey),
      ],
      path: AppAsset.translationsPath,
      startLocale: null,
      fallbackLocale: const Locale(AppTextString.enLangKey),
      useOnlyLangCode: true,
      saveLocale: true,
      child: const TrackingApp(),
    ),
  );
}

class TrackingApp extends StatefulWidget {
  const TrackingApp({super.key});

  @override
  State<TrackingApp> createState() => _TrackingAppState();
}

class _TrackingAppState extends State<TrackingApp> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen(FCMService.showFlutterNotification);
    FCMService.setupInteractedMessage();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      builder: EasyLoading.init(),
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouterConfig.goRouter,
      // Localization
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      localeResolutionCallback: (locale, supportedLocales) {
        // Check if the current device locale is supported
        if (locale != null) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode) {
              return supportedLocale;
            }
          }
        }
        // Fallback to English if device locale is not supported
        return const Locale(AppTextString.enLangKey);
      },
    );
  }
}
