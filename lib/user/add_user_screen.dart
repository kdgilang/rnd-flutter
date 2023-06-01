import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:purala/constants/color_constants.dart';
import 'package:purala/models/media_model.dart';
import 'package:purala/models/user_model.dart';
import 'package:purala/providers/merchant_provider.dart';
import 'package:purala/repositories/media_repository.dart';
import 'package:purala/repositories/storage_repository.dart';
import 'package:purala/repositories/user_repository.dart';
import 'package:purala/user/user_screen.dart';
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
        title: "Add user",
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
  final _emailControl = TextEditingController();
  final _userNameControl = TextEditingController();
  final _passwordControl = TextEditingController();

  bool isBusy = false;
  bool isLoading = false;
  int _merchantId = 0;
  bool _isBlockedUser = false;
  bool _isConfirmedUser = false;
  File _image = File("");
  PlatformFile _imageMeta = PlatformFile(name: "", size: 0);

  @override
  Widget build(BuildContext context) {
    _merchantId = context.read<MerchantProvider>().merchant?.id ?? 0;

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
                child: _image.path.isEmpty ? const Text(
                  "upload",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10),
                ) :
                CircleAvatar(
                  radius: 44,
                  backgroundImage: FileImage(_image)
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
                  controller: _emailControl,
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
                  controller: _userNameControl,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: 'User Name',
                    // floatingLabelStyle: TextStyle(color: Colors.white),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, width: 1.0)
                    )
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "User Name is required";
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
                      value: _isConfirmedUser,
                      activeColor: ColorConstants.secondary,
                      onChanged: (bool value) {
                        // This is called when the user toggles the switch.
                        setState(() {
                          _isConfirmedUser = value;
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
                      value: _isBlockedUser,
                      activeColor: ColorConstants.secondary,
                      onChanged: (bool value) {
                        // This is called when the user toggles the switch.
                        setState(() {
                          _isBlockedUser = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  controller: _passwordControl,
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
                    backgroundColor: isBusy ? ColorConstants.grey : ColorConstants.secondary,
                    foregroundColor: ColorConstants.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 18),
                    minimumSize: const Size(250, 0),
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                    disabledBackgroundColor: ColorConstants.grey
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
    if (!_formKey.currentState!.validate() || isBusy) {
      return;
    }

    final storageRepo = StorageRepository();
    final mediaRepo = MediaRepository();

    setState(() {
      isBusy = true;
    });

    try {
      final user = UserModel(
        name: _userNameControl.text,
        email: _emailControl.text,
        confirmed: _isConfirmedUser,
        blocked: _isBlockedUser,
        merchantId: _merchantId,
        password: _passwordControl.text
      );

      final userId = await userRepo.add(user);
      final String imageName = "${DateTime.now().millisecondsSinceEpoch}_${_imageMeta.name}";
      final path = await storageRepo.upload(imageName, _image);
      final imageUrl = "${dotenv.env['SUPABASE_STORAGE_URL']}/$path";
      final imgProp = await decodeImageFromList(_image.readAsBytesSync());
      
      user.image = MediaModel(
        name: imageName,
        caption: _userNameControl.text,
        url: imageUrl,
        size: _imageMeta.size,
        ext: _imageMeta.extension,
        alternativeText: _userNameControl.text,
        height: imgProp.height,
        width: imgProp.width
      );

      mediaRepo.add(user.image!,
        userId,
        UserModel.type
      );

      if (mounted) {
        Navigator.pop(context, user);
      }
    } on Exception catch (err) {
      debugPrint('known error: $err');
    } catch(err) {
      debugPrint('unknown error: $err');
    } finally {
      setState(() {
        isBusy = false;
      });
    }
  }

  Future<void> _handleSelectImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image
    );

    if (result != null) {
      setState(() {
        _imageMeta = result.files.single;
        _image = File(result.files.single.path ?? "");
      });
    } else {
      // User canceled the picker
    }
  }
}
