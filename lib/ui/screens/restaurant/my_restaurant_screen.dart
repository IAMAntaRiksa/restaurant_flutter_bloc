import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_caffe_ku/core/utils/token/token_utils.dart';
import 'package:flutter_caffe_ku/core/viewmodels/restaurant/restaurant_bloc.dart';
import 'package:flutter_caffe_ku/gen/assets.gen.dart';
import 'package:flutter_caffe_ku/ui/screens/auth/login/login_screen.dart';
import 'package:flutter_caffe_ku/ui/screens/restaurant/add_restaurant_screen.dart';
import 'package:flutter_caffe_ku/ui/screens/restaurant/restaurant_screen.dart';
import 'package:flutter_caffe_ku/ui/widgets/idle/idle_item.dart';
import 'package:flutter_caffe_ku/ui/widgets/restaurant/restaurant_list.dart';
import 'package:go_router/go_router.dart';

class MyRestaurantScreen extends StatelessWidget {
  static const routeName = "/myrestaurant";
  const MyRestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("My Restaurant"),
        actions: [
          IconButton(
              onPressed: () async {
                await checkTokken.removeToken();
                // ignore: use_build_context_synchronously
                context.go(LoginScreen.routeName);
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: const MyRestaurantBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(AddRestaurantScreen.routeName);
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 1,
        onTap: (value) {
          if (value == 0) {
            context.go(RestaurantScreen.routeName);
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.restaurant), label: 'All Restaurant'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'My Account'),
        ],
      ),
    );
  }
}

class MyRestaurantBody extends StatefulWidget {
  const MyRestaurantBody({super.key});

  @override
  State<MyRestaurantBody> createState() => _MyRestaurantBodyState();
}

class _MyRestaurantBodyState extends State<MyRestaurantBody> {
  @override
  void initState() {
    RestaurantBloc.instance(context).add(
      const RestaurantEvent.getRestaurantById(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantBloc, RestaurantState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => const Center(
              child: CircularProgressIndicator(
            color: Colors.red,
          )),
          loaded: (data) {
            if (data.isEmpty) {
              return IdleNoItemCenter(
                title: "My Restaurant not found",
                iconPathSVG: Assets.images.illustrationNotfound.path,
              );
            }
            return RestaurantListWidget(
              restaurants: data,
            );
          },
        );
      },
    );
  }
}
