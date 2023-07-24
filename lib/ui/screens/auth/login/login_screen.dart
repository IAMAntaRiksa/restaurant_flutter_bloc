import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_caffe_ku/core/models/auth/login_model.dart';
import 'package:flutter_caffe_ku/core/utils/token/token_utils.dart';
import 'package:flutter_caffe_ku/core/viewmodels/login/login_bloc.dart';
import 'package:flutter_caffe_ku/ui/constant/constant.dart';
import 'package:flutter_caffe_ku/ui/screens/auth/register/register_screen.dart';
import 'package:flutter_caffe_ku/ui/screens/restaurant/my_restaurant_screen.dart';
import 'package:flutter_caffe_ku/ui/widgets/button/button.dart';
import 'package:flutter_caffe_ku/ui/widgets/textfield/custom_textfield.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = "/login";
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: const LoginBody(),
    );
  }
}

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void sendLogin() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      LoginBloc.instance(context).add(LoginEvent.getLogin(LoginRequestModel(
        identifier: _emailController.text,
        password: _passwordController.text,
      )));

      _emailController.clear();
      _passwordController.clear();
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: setWidth(40)),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Wolcome",
                style: styleTitle.copyWith(fontSize: setFontSize(80)),
              ),
              Text(
                "Restaurant portal from Indonesia. Login to your account. E-mail and Password?",
                style: styleSubtitle.copyWith(
                  fontSize: setFontSize(35),
                ),
              ),
              QCustomeTextField(
                controller: _emailController,
                hint: "Your Email",
                label: "Email",
                onChanged: (value) {},
                suffixIcon: Icons.email,
              ),
              SizedBox(
                height: setHeight(20),
              ),
              QCustomeTextField(
                controller: _passwordController,
                label: "Password",
                hint: "Your Password",
                suffixIcon: Icons.password,
                obscure: true,
                onChanged: (value) {},
              ),
              BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                  state.maybeWhen(
                    orElse: () {},
                    error: (data) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: $data')));
                      print("Data INI Satu : $data");
                    },
                    loaded: (model) async {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text('Success Login: ${model.user?.username}')));
                      print("Data INI Dua : ${model.user!.username}");
                      await checkTokken.saveTokenUser(model);
                      // ignore: use_build_context_synchronously
                      context.push(MyRestaurantScreen.routeName);
                    },
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return QButtomWidget(
                        label: "Login",
                        color: Colors.green,
                        onPressed: () => sendLogin(),
                      );
                    },
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
              SizedBox(
                height: setHeight(20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "Dont't have an account?",
                    style: styleSubtitle.copyWith(
                      fontSize: setFontSize(40),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.go(
                        RegisterScreen.routeName,
                      );
                    },
                    child: Text(
                      'Register',
                      style: styleSubtitle.copyWith(
                        fontSize: setFontSize(40),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
