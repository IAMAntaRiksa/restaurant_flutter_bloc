import 'package:flutter/material.dart';
import 'package:flutter_caffe_ku/core/models/restaurant/restaurant_model.dart';
import 'package:flutter_caffe_ku/ui/constant/constant.dart';

class RestaurantItem extends StatelessWidget {
  final VoidCallback onClick;
  final RestaurantModel restaurant;
  final bool userHero;
  const RestaurantItem({
    super.key,
    required this.restaurant,
    this.userHero = true,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onClick(),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: setHeight(20),
          horizontal: setWidth(40),
        ),
        child: Row(
          children: [
            userHero
                ? Hero(tag: restaurant.id!, child: _imageWidget(context))
                : _imageWidget(context),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(restaurant.attributes!.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: setFontSize(40),
                        color: blackColor,
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    restaurant.attributes!.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: setFontSize(40),
                      color: blackColor,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: primaryColor,
                        size: 15,
                      ),
                      SizedBox(
                        width: setWidth(5),
                      ),
                      Expanded(
                        child: Text(
                          restaurant.attributes!.latitude,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: styleSubtitle.copyWith(
                            fontSize: setFontSize(35),
                            color: blackColor,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imageWidget(BuildContext context) {
    return Container(
      width: setWidth(200),
      height: setHeight(
        isSmallPhoneHeight(context) ? 180 : 150,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(
          image: NetworkImage(
            restaurant.attributes!.photo,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
