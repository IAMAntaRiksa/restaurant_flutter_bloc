import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_caffe_ku/core/models/restaurant/create_restaurant.dart';
import 'package:flutter_caffe_ku/core/utils/token/token_utils.dart';
import 'package:flutter_caffe_ku/core/viewmodels/create_restaurant/create_restaurant_bloc.dart';
import 'package:flutter_caffe_ku/core/viewmodels/restaurant/restaurant_bloc.dart';
import 'package:flutter_caffe_ku/ui/constant/constant.dart';
import 'package:flutter_caffe_ku/ui/widgets/button/button.dart';
import 'package:flutter_caffe_ku/ui/widgets/textfield/custom_textfield.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class AddRestaurantScreen extends StatelessWidget {
  static const routeName = "/addRestaurant";
  const AddRestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Restaurant "),
      ),
      body: BlocProvider<CreateRestaurantBloc>(
        create: (context) => CreateRestaurantBloc(),
        child: const AddRestaurantBody(),
      ),
    );
  }
}

class AddRestaurantBody extends StatefulWidget {
  const AddRestaurantBody({super.key});

  @override
  State<AddRestaurantBody> createState() => _AddRestaurantBodyState();
}

class _AddRestaurantBodyState extends State<AddRestaurantBody> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _addressController = TextEditingController();

  LatLng? position;

  String imageXFile = '';

  List<dynamic> multiImageXFile = [];
  void onCamere(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? camera = await picker.pickImage(
      source: source,
      imageQuality: 50,
    );
    if (camera != null) {
      setState(() {
        imageXFile = camera.path;
      });
    }
  }

  void onGallery(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(
      source: source,
      imageQuality: 50,
    );
    if (photo != null) {
      setState(() {
        imageXFile = photo.path;
      });
    }
  }

  void getMultipleImage() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> photo = await picker.pickMultiImage();

    multiImageXFile = photo;

    setState(() {});
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Photo Library'),
                  onTap: () {
                    onGallery(ImageSource.gallery);
                    context.pop();
                  }),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  onCamere(ImageSource.camera);
                  context.pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void sendRestaurant() async {
    final userId = await checkTokken.getUserId();
    if (_nameController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _addressController.text.isNotEmpty) {
      var item = CreateRestaurantModel(
        data: CreateData(
          name: _nameController.text,
          description: _descriptionController.text,
          address: _addressController.text,
          latitude: "0",
          longitude: "0",
          photo: "https://picsum.photos/200/300",
          userId: userId,
        ),
      );
      context
          .read<CreateRestaurantBloc>()
          .add(CreateRestaurantEvent.createRestaurant(item, XFile(imageXFile)));

      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: setWidth(40)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                _showPicker(context);
                // getMultipleImage();
              },
              child: imageXFile.isNotEmpty
                  ? Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 14, 6, 6),
                          borderRadius: BorderRadius.circular(10)),
                      child: Image.file(
                        File(imageXFile),
                        width: deviceWidth * 1.3,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10)),
                      width: deviceWidth * 1.3,
                      height: 250,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.grey[800],
                      ),
                    ),
            ),
            const SizedBox(
              height: 24,
            ),
            QCustomeTextField(
              controller: _nameController,
              label: "Name",
              onChanged: (value) {},
            ),
            QCustomeTextField(
              controller: _descriptionController,
              label: "Description",
              onChanged: (value) {},
            ),
            QCustomeTextField(
              controller: _addressController,
              label: "Address",
              onChanged: (value) {},
            ),
            BlocConsumer<CreateRestaurantBloc, CreateRestaurantState>(
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () {},
                  error: (data) {
                    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Field createing restaurant : {$data}')));
                  },
                  loaded: (model) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Success Createing Restaurant')));

                    RestaurantBloc.instance(context)
                        .add(const RestaurantEvent.getRestaurantById());
                    context.pop();
                  },
                );
              },
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () {
                    return QButtomWidget(
                      label: "Add",
                      color: Colors.green,
                      onPressed: () => sendRestaurant(),
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
    );
  }
}
