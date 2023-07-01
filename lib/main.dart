import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_caffe_ku/global.bloc.dart';
import 'package:flutter_caffe_ku/injector.dart';

import 'package:flutter_caffe_ku/ui/screens/auth/register/register_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'ui/constant/constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Setup injector
  await setupLocator();

  /// Initialize screenutil
  await ScreenUtil.ensureScreenSize();

  /// Registering global providers
  var providers = await GlobalProviders.register();
  runApp(MyApp(
    providers: providers,
  ));
}

var pageScreen = const RegisterScreen();

class MyApp extends StatelessWidget {
  final List<BlocProvider> providers;

  const MyApp({super.key, required this.providers});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: pageScreen,
        builder: (ctx, child) {
          setupScreenUtil(ctx);
          return MediaQuery(
            data: MediaQuery.of(ctx).copyWith(textScaleFactor: 1.0),
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: child!,
            ),
          );
        },
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
