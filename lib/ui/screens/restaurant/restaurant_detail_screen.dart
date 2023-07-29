import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_caffe_ku/core/models/restaurant/restaurant_model.dart';
import 'package:flutter_caffe_ku/core/viewmodels/detail_restaurant/detail_restaurant_bloc.dart';
import 'package:flutter_caffe_ku/core/viewmodels/location/location_bloc.dart';
import 'package:flutter_caffe_ku/gen/assets.gen.dart';
import 'package:flutter_caffe_ku/ui/constant/constant.dart';
import 'package:flutter_caffe_ku/ui/screens/direction_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RestaurantDetailScreen extends StatelessWidget {
  static const routeName = "/detail";
  const RestaurantDetailScreen({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocProvider<DetailRestaurantBloc>(
            create: (context) => DetailRestaurantBloc()
              ..add(
                DetailRestaurantEvent.getRestaurant(id),
              )),
        BlocProvider<LocationBloc>(
          create: (context) => LocationBloc()
            ..add(
              const LocationEvent.getCurrentLocation(),
            ),
        ),
      ],
      child: RestaurantInitDetailScreen(
        id: id,
      ),
    );
  }
}

class RestaurantInitDetailScreen extends StatelessWidget {
  const RestaurantInitDetailScreen({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Bloc [DetailRestaurantBloc]
      body: BlocBuilder<DetailRestaurantBloc, DetailRestaurantState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => const SizedBox(),
            loaded: (model) {
              return RestaurantDetailSliverBody(
                restaurant: model,
              );
            },
          );
        },
      ),
    );
  }
}

class RestaurantDetailSliverBody extends StatelessWidget {
  final RestaurantModel restaurant;
  const RestaurantDetailSliverBody({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            elevation: 0,
            expandedHeight: deviceHeight * 0.4,
            floating: false,
            pinned: true,
            title: Text(
              restaurant.attributes!.name,
              style: styleTitle.copyWith(
                fontSize: setFontSize(50),
                color: Colors.white,
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: grayColor.withOpacity(0.4),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Material(
                  type: MaterialType.transparency,
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => context.pop(),
                    borderRadius: BorderRadius.circular(12),
                    child: Icon(
                      Icons.keyboard_arrow_left,
                      color: blackColor,
                    ),
                  ),
                ),
              ),
            ),
            flexibleSpace: _flexibleSpace(),
            backgroundColor: Colors.white,
          ),
        ];
      },
      body: RestaurantDetailContentBody(restaurant: restaurant),
    );
  }

  Widget _flexibleSpace() {
    return FlexibleSpaceBar(
      centerTitle: true,
      collapseMode: CollapseMode.pin,
      background: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Hero(
              tag: restaurant.id!,
              child: Image.network(
                restaurant.attributes!.photo,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: -3,
            left: 0,
            right: 0,
            child: Container(
              height: setHeight(80),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(50),
                ),
              ),
              child: Center(
                child: Container(
                  width: deviceWidth * 0.12,
                  height: setHeight(15),
                  decoration: BoxDecoration(
                    color: grayColor.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(42),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RestaurantDetailContentBody extends StatelessWidget {
  final RestaurantModel restaurant;
  const RestaurantDetailContentBody({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _RestaurantDetailInfoWidget(restaurant: restaurant),
          _RestaurantMapDetailWidget(restaurant: restaurant),
        ],
      ),
    );
  }
}

class _RestaurantDetailInfoWidget extends StatefulWidget {
  final RestaurantModel restaurant;
  const _RestaurantDetailInfoWidget({super.key, required this.restaurant});

  @override
  State<_RestaurantDetailInfoWidget> createState() =>
      _RestaurantDetailInfoWidgetState();
}

class _RestaurantDetailInfoWidgetState
    extends State<_RestaurantDetailInfoWidget> {
  bool viewMore = false;

  void toggleViewMore() {
    setState(() {
      viewMore = !viewMore;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: setWidth(40)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Description",
            style: styleTitle.copyWith(
              fontSize: setFontSize(55),
            ),
          ),
          SizedBox(
            height: setHeight(10),
          ),
          InkWell(
            onTap: () => toggleViewMore(),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: viewMore == true
                      ? widget.restaurant.attributes!.description
                      : "${widget.restaurant.attributes!.description.substring(0, widget.restaurant.attributes!.description.length ~/ 2)}...",
                  style: styleSubtitle.copyWith(
                    fontSize: setFontSize(38),
                    color: blackColor,
                  ),
                ),
                TextSpan(
                  text: viewMore == false ? "View More" : "",
                  style: styleTitle.copyWith(
                    fontSize: setFontSize(38),
                    color: primaryColor,
                  ),
                )
              ]),
            ),
          ),
          SizedBox(
            height: setHeight(5),
          ),
        ],
      ),
    );
  }
}

class _RestaurantMapDetailWidget extends StatefulWidget {
  final RestaurantModel restaurant;
  const _RestaurantMapDetailWidget({super.key, required this.restaurant});

  @override
  State<_RestaurantMapDetailWidget> createState() =>
      __RestaurantMapDetailWidgetState();
}

class __RestaurantMapDetailWidgetState
    extends State<_RestaurantMapDetailWidget> {
  @override
  void initState() {
    addCustomIcon();
    super.initState();
  }

  final Set<Marker> markers = {};
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(setWidth(20), setHeight(20))),
            Assets.markers.mappin.path)
        .then(
      (icon) {
        setState(() {
          markerIcon = icon;
        });
      },
    );
  }

  void createMarker(double lat, double lng, String address) {
    final marker = Marker(
      markerId: const MarkerId('currentPosition'),
      infoWindow: InfoWindow(title: address),
      position: LatLng(lat, lng),
      icon: markerIcon,
    );

    markers.add(marker);
  }

  LatLng? position;
  LatLng? positionDestination;

  @override
  Widget build(BuildContext context) {
    final lat = double.parse(widget.restaurant.attributes!.latitude);
    final lng = double.parse(widget.restaurant.attributes!.longitude);
    positionDestination = LatLng(lat, lng);
    position = LatLng(lat, lng);
    createMarker(lat, lng, widget.restaurant.attributes!.address);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: setWidth(40)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Map : ${widget.restaurant.attributes!.address}",
            style: styleSubtitle.copyWith(
              fontSize: setFontSize(40),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 230,
            child: GoogleMap(
              mapType: MapType.normal,
              markers: markers,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  lat,
                  lng,
                ),
                zoom: 15,
              ),
            ),
          ),
          const SizedBox(height: 20),
          BlocBuilder<LocationBloc, LocationState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                error: (error) {
                  return Text('error: $error');
                },
                loaded: (model) {
                  return ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return DirectionScreen(
                              origin: model.latLng!,
                              destination: positionDestination!,
                            );
                          },
                        ),
                      );
                    },
                    child: const Text('Derection'),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
