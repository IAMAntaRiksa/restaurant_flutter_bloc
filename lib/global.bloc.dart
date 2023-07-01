import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/viewsmodel/restaurant/restaurant_bloc.dart';

class GlobalProviders {
  /// Register your provider here
  static Future<dynamic> register() async {
    return [
      // BlocProvider(create: (context) => LoginBloc()),
      // BlocProvider(create: (context) => RegisterBloc()),
      BlocProvider(create: (context) => RestaurantBloc()),
    ];
  }
}
