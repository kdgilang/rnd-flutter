import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:purala/constants/color_constants.dart';
import 'package:purala/providers/merchant_provider.dart';
import 'package:purala/repositories/storage_repository.dart';
import 'package:purala/repositories/user_repository.dart';
import 'package:purala/validations/email_validation.dart';
import 'package:purala/validations/password_validation.dart';
import 'package:purala/widgets/layouts/authenticated_layout.dart';
import 'package:purala/widgets/scaffold_widget.dart';

class AddUserScreen extends StatelessWidget {
  const AddUserScreen({super.key});

  static const String routeName = "/add-user";

  @override
  Widget build(BuildContext context) {
    return const AuthenticatedLayout(
      child: ScaffoldWidget(
        title: "Users",
        child: AddUserWidget(),
      )
    );
  }
}

class AddUserWidget extends StatefulWidget {
  const AddUserWidget({Key? key}) : super(key: key);

  @override
  State<AddUserWidget> createState() => _AddUserWidgetState();
}

class _AddUserWidgetState extends State<AddUserWidget> {
  final userRepo = UserRepository();
  final _formKey = GlobalKey<FormState>();
  final nameControl = TextEditingController();
  final passwordControl = TextEditingController();

  bool isBusy = false;
  bool isLoading = false;
  int merchantId = 0;
  File image = File("");

  @override
  Widget build(BuildContext context) {
    merchantId = context.read<MerchantProvider>().merchant?.id ?? 0;

    return Container(
      constraints: const BoxConstraints(maxWidth: 600),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: GestureDetector(
              onTap: _handleSelectImage,
              child: CircleAvatar(
                radius: 45,
                backgroundColor: ColorConstants.secondary,
                child: image.path.isEmpty ? const Text(
                  "upload",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10),
                ) :
                CircleAvatar(
                  radius: 44,
                  backgroundImage: FileImage(image)
                ),
              ) 
            ),
          ),
          const SizedBox(height: 10,),
          Visibility(
            visible: isBusy,
            maintainSize: true, 
            maintainAnimation: true,
            maintainState: true,
            child: Center(
              child: LoadingAnimationWidget.fourRotatingDots(color: ColorConstants.secondary, size: 20),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: null,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: 'Email address',
                    // floatingLabelStyle: TextStyle(color: Colors.white),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, width: 1.0)
                    )
                  ),
                  validator: EmailValidation.validateEmail,
                ),
                TextFormField(
                  controller: nameControl,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: 'Name',
                    // floatingLabelStyle: TextStyle(color: Colors.white),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, width: 1.0)
                    )
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Name is required";
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 10,),
                Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Is confirmed user?"),
                    Switch(
                      // This bool value toggles the switch.
                      value: true,
                      activeColor: ColorConstants.secondary,
                      onChanged: (bool value) {
                        // This is called when the user toggles the switch.
                        setState(() {
                          // light = value;
                        });
                      },
                    ),
                  ],
                ),
                Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Is blocked user?"),
                    Switch(
                      // This bool value toggles the switch.
                      value: true,
                      activeColor: ColorConstants.secondary,
                      onChanged: (bool value) {
                        // This is called when the user toggles the switch.
                        setState(() {
                          // light = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  controller: passwordControl,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: 'Password',
                    // floatingLabelStyle: TextStyle(color: Colors.white),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, width: 1.0)
                    )
                  ),
                  validator: PasswordValidation.validateRegisterPassword,
                ),
                const SizedBox(height: 20,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstants.secondary,
                    foregroundColor: ColorConstants.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 18),
                    minimumSize: const Size(250, 0),
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    )
                  ),
                  onPressed: _handleSave,
                  child: const Text('Save'),
                ),
              ],
            )
          ),
        ],
      )
    );
  }

  void _handleSave() async {

  }

  Future<void> _handleSelectImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image
    );

    if (result != null) {
      // final storageRepo = StorageRepository();
      File file = File(result.files.single.path ?? "");
      // String fileName = result.files.first.name;
      // final path = await storageRepo.upload(fileName, file);

      setState(() {
        image = file;
      });
    } else {
      // User canceled the picker
    }
  }
}
