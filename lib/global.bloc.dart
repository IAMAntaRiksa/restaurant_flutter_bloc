import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_caffe_ku/core/viewmodels/restaurant/restaurant_bloc.dart';

class GlobalProviders {
  /// Register your provider here
  static Future<dynamic> register() async => [
        BlocProvider(create: (context) => RestaurantBloc()),
      ];
}
