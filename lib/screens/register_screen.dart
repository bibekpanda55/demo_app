import 'dart:io';

import 'package:demo_app/controller/auth_controller.dart';
import 'package:demo_app/model/login_response.dart';
import 'package:demo_app/widgets/text_widget.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../model/role.dart';
import '../routes.dart';
import '../util/media_utils.dart';
import '../widgets/button_widget.dart';
import '../widgets/media_source.dart';
import '../widgets/text_field.dart';
import '../widgets/toasts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  Data data = Data();
  final _usernameController = TextEditingController(),
      _nameController = TextEditingController(),
      _emailController = TextEditingController(),
      _ageController = TextEditingController(),
      _addressController = TextEditingController(),
      _phoneNumberController = TextEditingController(),
      _roleController = TextEditingController(),
      _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _imagePath;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final roleList = context.watch<List<Role>?>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            FontAwesomeIcons.circleArrowLeft,
            color: Colors.white,
            size: 30,
          ),
        ),
        centerTitle: false,
        title: const Text(
          "Registration",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: [
            ...[
              const Text(
                "Name",
              ),
              TextFieldWidget(
                controller: _nameController,
                hintText: "Enter Name",
                onSaved: (p0) => data.name = p0,
              ),
              const Text(
                "Username",
              ),
              TextFieldWidget(
                controller: _usernameController,
                hintText: "Enter Username",
                validator: (p0) => p0!.isEmpty
                    ? "Cannot be empty!"
                    : p0.length < 5 || p0.length > 30
                        ? "Username should be between 5 and 30 characters"
                        : null,
                onSaved: (p0) => data.userName = p0,
              ),
              const Text(
                "Password",
              ),
              TextFieldWidget(
                controller: _passwordController,
                hintText: "Password",
                validator: (p0) => p0!.isEmpty
                    ? "Cannot be empty!"
                    : p0.length < 6 || p0.length > 30
                        ? "Password should be atleast 6 characters"
                        : null,
                onSaved: (p0) => data.password = p0,
              ),
              const Text(
                "Email Id",
              ),
              TextFieldWidget(
                controller: _emailController,
                hintText: "Enter Email Id",
                isEmail: true,
                onSaved: (p0) => data.email = p0,
              ),
              const Text(
                "Address",
              ),
              TextFieldWidget(
                controller: _addressController,
                hintText: "Enter Address",
                onSaved: (p0) => data.address = p0,
                maxLines: 3,
              ),
              const Text(
                "Age",
              ),
              TextFieldWidget(
                controller: _ageController,
                textInputType: TextInputType.number,
                hintText: "Enter Age",
                onSaved: (p0) => data.age = int.tryParse(p0 ?? ""),
              ),
              const Text(
                "Phone No.",
              ),
              TextFieldWidget(
                controller: _phoneNumberController,
                isPhone: true,
                textInputType: TextInputType.number,
                onSaved: (p0) => data.phoneNumber = int.tryParse(p0 ?? ""),
                hintText: "Enter Phone No.",
              ),
              const Text(
                "Role Name",
              ),
              TextFieldWidget(
                controller: _roleController,
                onChanged: (str) => _roleController.text = str ?? "",
                dropdownItems: roleList?.map((e) => e.roleName).toList(),
                onSaved: (p0) => data.roleId = roleList
                    ?.firstWhere((element) => element.roleName == p0)
                    .roleId,
                hintText: "Select Role Name",
              ),
              const Text(
                "Upload Photo",
              ),
              DottedBorder(
                  color: Colors.blue,
                  child: GestureDetector(
                    onTap: () async {
                      final File? image = await selectImage(context);

                      if (image != null) {
                        String fileName = image.path.split('/').last;
                        final file = await MultipartFile.fromFile(image.path,
                            filename: fileName);
                        setState(() {
                          data.img = file;
                          _imagePath = fileName;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.blue[50],
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.folder_copy,
                            color: Colors.blue,
                            size: 30,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          _imagePath == null
                              ? const SubtitleTextWidget(
                                  text: "Choose files here...")
                              : const SubtitleTextWidget(
                                  text: "File uploaded!"),
                        ],
                      ),
                    ),
                  )),
              ButtonWidget(
                onPressed: () async {
                  if (_imagePath == null) {
                    showErrorToast("Please upload a picture");
                  } else {
                    final fState = _formKey.currentState!;
                    if (fState.validate()) {
                      fState.save();

                      await AuthController().registerUsers(data).then((value) {
                        if (value) {
                          Navigator.of(context).pop();
                        } else {
                          setState(() {
                            _imagePath = null;
                          });
                        }
                      });
                    }
                  }
                },
                loading: loading,
                text: "REGISTER",
              ),
            ]
                .map((e) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        e,
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ))
                .fold(
                    [],
                    (previousValue, element) =>
                        previousValue.toList()..add(element)),
            Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () => Navigator.of(context)
                        .pushNamed(RouteGenerator.loginPage),
                    child: const Text(
                      "Already have an account?Login!",
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ))),
          ],
        ),
      ),
    );
  }

  Future selectImage(BuildContext context) async {
    final MediaSource? imageSource = await (showModalBottomSheet(
      context: context,
      builder: (ctx) => MediaSourceWidget(ctx),
    )) as MediaSource?;
    if (imageSource == null) return;
    try {
      final temp = await MediaUtils.pickMedia(imageSource);
      if (temp == null) return;
      showSuccessToast("Image uploaded!");
      return File(temp.path);
    } catch (e) {
      showErrorToast("Image Uploading Failed");
    }
  }
}
