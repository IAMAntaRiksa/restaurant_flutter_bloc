import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_caffe_ku/core/models/auth/login_model.dart';
import 'package:flutter_caffe_ku/core/services/auth/auth_service.dart';
import 'package:flutter_caffe_ku/injector.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  /// Instance Bloc
  static LoginBloc instance(BuildContext context) =>
      BlocProvider.of<LoginBloc>(context, listen: false);

  /// Dependency Injection
  final restauratService = locator<AuthServices>();

  LoginBloc() : super(const _Initial()) {
    on<_GetLogin>((event, emit) async {
      emit(const _Loading());
      final result = await restauratService.login(event.model);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
