import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:purala/constants/color_constants.dart';
import 'package:purala/models/file_model.dart';
import 'package:purala/models/user_model.dart';
import 'package:purala/providers/merchant_provider.dart';
import 'package:purala/repositories/file_repository.dart';
import 'package:purala/repositories/storage_repository.dart';
import 'package:purala/repositories/user_repository.dart';
import 'package:purala/validations/email_validation.dart';
import 'package:purala/validations/password_validation.dart';
import 'package:purala/widgets/layouts/authenticated_layout.dart';
import 'package:purala/widgets/scaffold_widget.dart';

class UserFormScreen extends StatelessWidget {
  const UserFormScreen({super.key});

  static const String routeName = "/add-user";

  @override
  Widget build(BuildContext context) {
    return const AuthenticatedLayout(
      child: ScaffoldWidget(
        title: "Product Form",
        child: UserFormWidget(),
      )
    );
  }
}

class UserFormWidget extends StatefulWidget {
  const UserFormWidget({Key? key}) : super(key: key);

  @override
  State<UserFormWidget> createState() => _UserFormWidgetState();
}

class _UserFormWidgetState extends State<UserFormWidget> {
  final _userRepo = UserRepository();
  final _storageRepo = StorageRepository();
  final _fileRepo = FileRepository();
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
  String _imageUrl = "";
  PlatformFile _imageMeta = PlatformFile(name: "", size: 0);
  late UserModel _user;
  UserFormArgs _userFormArgs = UserFormArgs(type: '');

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _merchantId = context.read<MerchantProvider>().merchant?.id ?? 0;
    _userFormArgs = ModalRoute.of(context)!.settings.arguments as UserFormArgs;

    if (_userFormArgs.type == 'edit' && _userFormArgs.user != null) {
      setState(() {
        _user = _userFormArgs.user!;
        _isBlockedUser = _user.blocked;
        _isConfirmedUser = _user.confirmed;
        _emailControl.text = _user.email;
        _userNameControl.text = _user.name;
        _passwordControl.text = _user.password ?? "";
        _imageUrl = _user.image?.url ?? "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    
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
                child: (_image.path.isEmpty && _imageUrl.isEmpty) ? const Text(
                  "upload",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10),
                ) :
                 _image.path.isEmpty ?
                CircleAvatar(
                  radius: 44,
                  backgroundImage: NetworkImage(_imageUrl)
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
                  readOnly: _userFormArgs.type == 'edit',
                  controller: _emailControl,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: 'Email address',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, width: 1.0)
                    )
                  ),
                  validator: EmailValidation.validateEmail,
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  controller: _userNameControl,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: 'User Name',
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
                const SizedBox(height: 20,),
                Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Is confirmed user?"),
                    Switch(
                      value: _isConfirmedUser,
                      activeColor: ColorConstants.secondary,
                      onChanged: (bool value) {
                        setState(() {
                          _isConfirmedUser = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Is blocked user?"),
                    Switch(
                      value: _isBlockedUser,
                      activeColor: ColorConstants.secondary,
                      onChanged: (bool value) {
                        setState(() {
                          _isBlockedUser = value;
                        });
                      },
                    ),
                  ],
                ),
                Visibility(
                  visible: _userFormArgs.type != 'edit',
                  child: const SizedBox(height: 20,)
                ),
                Visibility(
                  visible: _userFormArgs.type != 'edit',
                  child: TextFormField(
                    controller: _passwordControl,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(),
                      labelText: 'Password',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, width: 1.0)
                      )
                    ),
                    validator: PasswordValidation.validateRegisterPassword,
                  ),
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

  Future<void> edit() async {
    final updatedUser = _user.copyWith(
      name: _userNameControl.text,
      blocked: _isBlockedUser,
      confirmed: _isConfirmedUser
    );

    await _userRepo.update(updatedUser);

    if (_image.path.isNotEmpty) {
      final storageRes = await _storageRepo.upload(_imageMeta.name, _image, UserModel.type);
      await _storageRepo.delete(_user.image!.name, UserModel.type);
      final imgProp = await decodeImageFromList(_image.readAsBytesSync());

      updatedUser.image = FileModel(
        name: storageRes.name,
        caption: _userNameControl.text,
        url: storageRes.url,
        size: _imageMeta.size,
        ext: _imageMeta.extension,
        alternativeText: _userNameControl.text,
        height: imgProp.height,
        width: imgProp.width
      );

      _fileRepo.update(updatedUser.image!, updatedUser.id!, UserModel.type);
    }

    if (mounted) {
      Navigator.pop(context, updatedUser);
    }
  }

  Future<void> add() async {
    final user = UserModel(
      name: _userNameControl.text,
      email: _emailControl.text,
      confirmed: _isConfirmedUser,
      blocked: _isBlockedUser,
      merchantId: _merchantId,
      password: _passwordControl.text
    );

    final userId = await _userRepo.add(user);

    if (_image.path.isNotEmpty) {
      final storageRes = await _storageRepo.upload(_imageMeta.name, _image, UserModel.type);
      final imgProp = await decodeImageFromList(_image.readAsBytesSync());

      user.image = FileModel(
        name: storageRes.name,
        caption: _userNameControl.text,
        url: storageRes.url,
        size: _imageMeta.size,
        ext: _imageMeta.extension,
        alternativeText: _userNameControl.text,
        height: imgProp.height,
        width: imgProp.width
      );

      _fileRepo.add(user.image!,
        userId,
        UserModel.type
      );
    }

    if (mounted) {
      Navigator.pop(context, user.copyWith(id: userId));
    }
  }

  void _handleSave() async {
    if (!_formKey.currentState!.validate() || isBusy) {
      return;
    }

    setState(() {
      isBusy = true;
    });

    try {
      if (_userFormArgs.type == 'edit') {
        await edit();
      } else {
        await add();
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

class UserFormArgs {
  final String type;
  final UserModel? user;

  UserFormArgs({
    required this.type,
    this.user
  });
}
