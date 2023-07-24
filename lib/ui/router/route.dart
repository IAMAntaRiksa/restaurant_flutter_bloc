import 'package:flutter/material.dart';
import 'package:flutter_caffe_ku/core/utils/token/token_utils.dart';
import 'package:flutter_caffe_ku/ui/screens/auth/login/login_screen.dart';
import 'package:flutter_caffe_ku/ui/screens/auth/register/register_screen.dart';
import 'package:flutter_caffe_ku/ui/screens/restaurant/add_restaurant_screen.dart';
import 'package:flutter_caffe_ku/ui/screens/restaurant/my_restaurant_screen.dart';
import 'package:flutter_caffe_ku/ui/screens/restaurant/restaurant_detail_screen.dart';
import 'package:flutter_caffe_ku/ui/screens/restaurant/restaurant_screen.dart';
import 'package:go_router/go_router.dart';

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}

final route = GoRouter(
  initialLocation: RestaurantScreen.routeName,
  routes: [
    GoRoute(
      path: LoginScreen.routeName,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: RegisterScreen.routeName,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: AddRestaurantScreen.routeName,
      builder: (context, state) => const AddRestaurantScreen(),
    ),
    GoRoute(
      path: RestaurantScreen.routeName,
      builder: (context, state) => const RestaurantScreen(),
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          transitionDuration: const Duration(seconds: 1),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(curve: Curves.easeIn).animate(animation),
              child: child,
            );
          },
          child: const RestaurantScreen(),
        );
      },
    ),
    GoRoute(
      path: MyRestaurantScreen.routeName,
      builder: (context, state) => const MyRestaurantScreen(),
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          transitionDuration: const Duration(seconds: 1),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(curve: Curves.easeIn).animate(animation),
              child: child,
            );
          },
          child: const MyRestaurantScreen(),
        );
      },
      redirect: (context, state) async {
        final isLogin = await checkTokken.isLogin();
        if (isLogin) {
          return null;
        } else {
          return LoginScreen.routeName;
        }
      },
    ),
    GoRoute(
      path: "${RestaurantDetailScreen.routeName}/:restaurantId",
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          transitionDuration: const Duration(seconds: 1),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(curve: Curves.easeIn).animate(animation),
              child: child,
            );
          },
          child: RestaurantDetailScreen(
            id: int.parse(
              state.pathParameters['restaurantId']!,
            ),
          ),
        );
      },
      builder: (context, state) => RestaurantDetailScreen(
          id: int.parse(
        state.pathParameters['restaurantId']!,
      )),
    )
  ],
);
