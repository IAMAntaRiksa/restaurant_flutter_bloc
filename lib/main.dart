import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_caffe_ku/core/viewmodels/create_restaurant/create_restaurant_bloc.dart';
import 'package:flutter_caffe_ku/core/viewmodels/location/location_bloc.dart';
import 'package:flutter_caffe_ku/core/viewmodels/restaurant/restaurant_bloc.dart';
import 'package:flutter_caffe_ku/injector.dart';
import 'package:flutter_caffe_ku/ui/router/route.dart';
import 'package:flutter_caffe_ku/ui/screens/auth/login/login_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'ui/constant/constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Setup injector
  await setupLocator();

  /// Initialize screenutil
  await ScreenUtil.ensureScreenSize();

  runApp(const MyApp());
}

var pageScreen = const LoginScreen();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CreateRestaurantBloc>(
          create: (context) => CreateRestaurantBloc(),
        ),
        BlocProvider<RestaurantBloc>(
          create: (context) => RestaurantBloc(),
        ),
        BlocProvider<LocationBloc>(
          create: (context) => LocationBloc(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
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
        routerConfig: route,
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
