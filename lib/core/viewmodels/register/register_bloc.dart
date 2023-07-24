import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_caffe_ku/core/models/auth/login_model.dart';
import 'package:flutter_caffe_ku/core/models/auth/register_model.dart';
import 'package:flutter_caffe_ku/core/services/auth/auth_service.dart';
import 'package:flutter_caffe_ku/injector.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_event.dart';
part 'register_state.dart';
part 'register_bloc.freezed.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  /// Instance Bloc
  static RegisterBloc instance(BuildContext context) =>
      BlocProvider.of<RegisterBloc>(context, listen: false);

  /// Dependency Injection
  final authService = locator<AuthServices>();
  RegisterBloc() : super(const _Initial()) {
    on<_CreateRegister>((event, emit) async {
      emit(const _Loading());
      final result = await authService.register(event.model);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
