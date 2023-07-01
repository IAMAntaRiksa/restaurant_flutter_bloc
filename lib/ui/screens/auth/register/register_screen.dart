import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_caffe_ku/core/models/auth/register_model.dart';
import 'package:flutter_caffe_ku/core/viewsmodel/register/register_bloc.dart';
import 'package:flutter_caffe_ku/ui/constant/constant.dart';
import 'package:flutter_caffe_ku/ui/widgets/button/button.dart';
import 'package:flutter_caffe_ku/ui/widgets/textfield/custom_textfield.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(),
      child: const RegisterBody(),
    );
  }
}

class RegisterBody extends StatefulWidget {
  const RegisterBody({super.key});

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void sendRegister() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _nameController.text.isNotEmpty &&
        _usernameController.text.isNotEmpty) {
      RegisterBloc.instance(context).add(
        RegisterEvent.createRegister(RegisterModel(
          name: _nameController.text,
          username: _usernameController.text,
          email: _emailController.text,
          password: _passwordController.text,
        )),
      );
      _nameController.clear();
      _usernameController.clear();
      _emailController.clear();
      _passwordController.clear();
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _usernameController.dispose();
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
                "Register",
                style: styleTitle.copyWith(fontSize: setFontSize(80)),
              ),
              Text(
                "Restaurant portal from Indonesia. Login to your account. E-mail and Password?",
                style: styleSubtitle.copyWith(
                  fontSize: setFontSize(35),
                ),
              ),
              QCustomeTextField(
                controller: _nameController,
                hint: "Your Name",
                label: "Name",
                onChanged: (value) {},
                suffixIcon: Icons.email,
              ),
              QCustomeTextField(
                controller: _usernameController,
                hint: "Your Username",
                label: "username",
                onChanged: (value) {},
                suffixIcon: Icons.email,
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
              BlocConsumer<RegisterBloc, RegisterState>(
                listener: (context, state) {
                  state.maybeWhen(
                    orElse: () {},
                    error: (data) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error Register: $data')));
                      print("Data INI Satu : $data");
                    },
                    loaded: (model) async {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              'Success Register: ${model.user?.username}')));
                      print("Data INI Dua : ${model.user!.username}");
                    },
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return QButtomWidget(
                        label: "Register",
                        color: Colors.green,
                        onPressed: () => sendRegister(),
                      );
                    },
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
