import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:purala/constants/color_constants.dart';
import 'package:purala/models/user_model.dart';
import 'package:purala/providers/merchant_provider.dart';
import 'package:purala/repositories/user_repository.dart';
import 'package:purala/user/user_form_screen.dart';
import 'package:purala/widgets/layouts/authenticated_layout.dart';
import 'package:purala/widgets/not_found_widget.dart';
import 'package:purala/widgets/scaffold_widget.dart';
import 'package:purala/widgets/tile_widget.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  static const String routeName = "/users";

  @override
  Widget build(BuildContext context) {
    return const UserWidget();
  }
}

class UserWidget extends StatefulWidget {
  const UserWidget({Key? key}) : super(key: key);

  @override
  State<UserWidget> createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  final userRepo = UserRepository();

  List<UserModel> users = [];
  bool isBusy = false;
  bool isLoading = false;
  int merchantId = 0;

  static const int numItems = 100;
  List<bool> selected = List<bool>.generate(numItems, (int index) => false);


  @override
  Widget build(BuildContext context) {
    merchantId = context.read<MerchantProvider>().merchant?.id ?? 0;

    return AuthenticatedLayout(
      child: ScaffoldWidget(
        title: "Users",
        appBarActions: [
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: IconButton(
                  icon: const Icon(Icons.add),
                  tooltip: 'Add users',
                  onPressed: _handleAdd,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  icon: const Icon(Icons.replay),
                  tooltip: 'Reload users',
                  onPressed: _loadData,
                ),
              ),
            ],
          )
        ],
        child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
                padding: const EdgeInsets.only(top: 25, bottom: 25),
                child: isLoading ?
                  LoadingAnimationWidget.fourRotatingDots(color: ColorConstants.secondary, size: 50) :
                Expanded(
                  child: SingleChildScrollView(
                    child: DataTable(
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text('Number'),
                      ),
                      DataColumn(
                        label: Text('aba'),
                      ),
                    ],
                    rows: List<DataRow>.generate(
                      numItems,
                      (int index) => DataRow(
                        // color: MaterialStateProperty.resolveWith<Color?>(
                        //     (Set<MaterialState> states) {
                        //   // All rows will have the same selected color.
                        //   if (states.contains(MaterialState.selected)) {
                        //     return Theme.of(context).colorScheme.primary.withOpacity(0.08);
                        //   }
                        //   // Even rows will have a grey color.
                        //   if (index.isEven) {
                        //     return Colors.grey.withOpacity(0.3);
                        //   }
                        //   return null; // Use default value for other states and odd rows.
                        // }),
                        cells: <DataCell>[
                          DataCell(Text('Row $index')),
                          DataCell(Text('Raw $index'))
                        ],
                        selected: selected[index],
                        onSelectChanged: (bool? value) {
                          setState(() {
                            selected[index] = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  )
                )
              
            
        ),
      )
      )
    );
  }

  void _loadData() async {
    if (isBusy) {
      return;
    }
    setState(() {
      isLoading = isBusy = true;
    });

    var res = await userRepo.getAll(merchantId);

    setState(() {
      users = res;
      isLoading = isBusy = false;
    });
  }

  void _handleBlock(UserModel user) async {
    if (isBusy) {
      return;
    }

    setState(() {
      isBusy = true;
    });

    final updatedUser = user.copyWith(blocked: !user.blocked);

    await userRepo.update(updatedUser);

    setState(() {
      isBusy = false;
      users[users.indexWhere((item) => item.id == user.id)] = updatedUser;
    });
  }

  void _handleAdd() async {
    final user = await Navigator.pushNamed(
      context,
      UserFormScreen.routeName,
      arguments: UserFormArgs(
        type: 'add',
      ),
    );
    if (user != null) {
      user as UserModel;

      setState(() {
        users.insert(0, user);
      });
    }
  }

  void _handleEdit(UserModel user) async {
    final editUser = await Navigator.pushNamed(
      context,
      UserFormScreen.routeName,
      arguments: UserFormArgs(
        type: 'edit',
        user: user,
      ),
    );
    
    if (editUser != null) {
      editUser as UserModel;

      setState(() {
        users[users.indexWhere((item) => item.id == editUser.id)] = editUser;
      });
    }
  }

  void _handleDelete(UserModel user) async {
    if (isBusy) {
      return;
    }

    setState(() {
      isBusy = true;
    });

    await userRepo.delete(user);

    setState(() {
      isBusy = false;
      users.remove(user);
    });
  }
}