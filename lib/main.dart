import 'package:contractor_app/providers/attributeProvider.dart';
import 'package:contractor_app/providers/home_provider.dart';
import 'package:contractor_app/providers/location_provider.dart';
import 'package:contractor_app/providers/login_provider.dart';
import 'package:contractor_app/providers/material_provider.dart';
import 'package:contractor_app/screens/login.dart';
import 'package:contractor_app/utils/constants/asset_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: ((context) => LoginProvider())),
      ChangeNotifierProvider(create: ((context) => HomeProvider())),
      ChangeNotifierProvider(create: ((context) => LocationProvider())),
      ChangeNotifierProvider(create: ((context) => MaterialProvider())),
      ChangeNotifierProvider(create: ((context) => AtributeProvider())),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AssetConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFF21899C),
        // textTheme: Theme.of(context).textTheme.apply(
        //       fontSizeFactor: 1.1,
        //       fontSizeDelta: 2.0,
        //     ),
      ),
      home: const LoginScreen(),
      builder: (context, child) {
        child = EasyLoading.init()(context, child);
        child = ResponsiveWrapper.builder(
            BouncingScrollWrapper.builder(context, child),
            maxWidth: 1200,
            minWidth: 450,
            defaultScale: true,
            breakpoints: [
              const ResponsiveBreakpoint.resize(450, name: MOBILE),
              const ResponsiveBreakpoint.autoScale(800, name: TABLET),
              const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
              const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
              const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
            ],
            background: Container(color: const Color(0xFFF5F5F5)));

        return child;
      },
    );
  }
}
