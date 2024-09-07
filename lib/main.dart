import 'package:adelnewversion/business_logic/app_cubit/app_cubit.dart';
import 'package:adelnewversion/business_logic/phone_auth/phone_auth_cubit.dart';
import 'package:adelnewversion/constant/global_var.dart';
import 'package:adelnewversion/firebase_options.dart';
import 'package:adelnewversion/helpers/dio_helper.dart';
import 'package:adelnewversion/notification_service/local_notification_service.dart';
import 'package:adelnewversion/routes/routes_manager.dart';
import 'package:adelnewversion/screens/auth%20copy/auth.dart';
import 'package:adelnewversion/screens/intro_screen.dart';
import 'package:adelnewversion/screens/navigation_bar/nav_bar_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
 DioHelper.init();
  LocalNotificationService.initialize();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {} else if (settings.authorizationStatus == AuthorizationStatus.provisional) {} else {}
  FirebaseMessaging.instance.getInitialMessage().then((message) {
    if (message != null) {
      LocalNotificationService.createAndDisplayNotification(message);
    }
  },
  );
  FirebaseMessaging.onMessage.listen((message) {
    LocalNotificationService.createAndDisplayNotification(message);
  },
  );
  initDynamicLinks();
  prefs = await SharedPreferences.getInstance();
  print(prefs.getString('token'));
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('ar', 'EG')],
      path: 'assets/translations',
      saveLocale: true,
      child: const MyApp()
    ),
  );
}

FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

Future<void> initDynamicLinks() async {
  final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();
  final Uri? deepLink = data?.link;
  dynamicLinks.onLink.listen((dynamicLinkData) {
    prefs.setString('refer', dynamicLinkData.link.toString());
  }).onError((error) {});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PhoneAuthCubit(),
        ),
        BlocProvider(
          create: (context) => AppCubit(),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white
        ),
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.introRoute,
        home: isLogged?  const NavBarScreen() : LoginScreen(),
      ),
    );
  }
}
