import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_caffe_ku/core/viewsmodel/restaurant/restaurant_bloc.dart';
import 'package:flutter_caffe_ku/ui/widgets/restaurant/restaurant_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RestaurantBloc>(
      create: (context) => RestaurantBloc()
        ..add(
          const RestaurantEvent.getRestaurats(),
        ),
      child: const HomeBody(),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        return state.when(
          initial: () => const Center(
            child: CircularProgressIndicator(),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: () => const Text('error'),
          loaded: (data) {
            return RestaurantListWidget(
              restaurants: data,
            );
          },
        );
      },
    );
  }
}
