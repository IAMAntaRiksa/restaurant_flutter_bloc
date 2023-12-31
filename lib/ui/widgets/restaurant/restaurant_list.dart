import 'package:flutter/material.dart';
import 'package:flutter_caffe_ku/core/models/restaurant/restaurant_model.dart';
import 'package:flutter_caffe_ku/ui/screens/restaurant/restaurant_detail_screen.dart';
import 'package:flutter_caffe_ku/ui/widgets/restaurant/restaurant_item.dart';
import 'package:go_router/go_router.dart';

class RestaurantListWidget extends StatelessWidget {
  final List<RestaurantModel> restaurants;
  final bool useHero;
  final bool useReplacement;
  const RestaurantListWidget({
    super.key,
    required this.restaurants,
    this.useHero = true,
    this.useReplacement = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: restaurants.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final RestaurantModel restaurant = restaurants[index];
        return RestaurantItem(
          restaurant: restaurant,
          userHero: useHero,
          onClick: () => useReplacement
              ? context
                  .push("${RestaurantDetailScreen.routeName}/${restaurant.id}")
              : context
                  .push("${RestaurantDetailScreen.routeName}/${restaurant.id}"),
        );
      },
    );
  }
}
