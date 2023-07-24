import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_caffe_ku/core/viewmodels/restaurant/restaurant_bloc.dart';
import 'package:flutter_caffe_ku/gen/assets.gen.dart';
import 'package:flutter_caffe_ku/ui/screens/restaurant/my_restaurant_screen.dart';
import 'package:flutter_caffe_ku/ui/widgets/idle/idle_item.dart';
import 'package:flutter_caffe_ku/ui/widgets/idle/loading/loading_listview.dart';
import 'package:flutter_caffe_ku/ui/widgets/restaurant/restaurant_list.dart';
import 'package:go_router/go_router.dart';

class RestaurantScreen extends StatelessWidget {
  static const routeName = "/restaurant";
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RestaurantBloc>(
      create: (context) => RestaurantBloc()
        ..add(
          const RestaurantEvent.getRestaurats(),
        ),
      child: const RestaurantBody(),
    );
  }
}

class RestaurantBody extends StatelessWidget {
  const RestaurantBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        onTap: (value) {
          if (value == 1) {
            context.push(MyRestaurantScreen.routeName);
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.restaurant), label: 'All Restaurant'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'My Account'),
        ],
      ),
      appBar: AppBar(
        title: const Text("Restaurants"),
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _RestaurantListWidget(),
          ],
        ),
      ),
    );
  }
}

class _RestaurantListWidget extends StatelessWidget {
  const _RestaurantListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantBloc, RestaurantState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => const LoadingListView(),
          loaded: (data) {
            if (data.isEmpty) {
              return IdleNoItemCenter(
                title: "Restaurant not found",
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
