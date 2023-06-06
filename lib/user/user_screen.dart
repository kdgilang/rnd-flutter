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
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: isLoading ?
                  LoadingAnimationWidget.fourRotatingDots(color: ColorConstants.secondary, size: 50) :
                  SearchableList<UserModel>(
                  style: const TextStyle(fontSize: 25),
                  builder: (UserModel user) {
                    return Slidable(
                      // Specify a key if the Slidable is dismissible.
                      key: ValueKey(user.id),
                      // The start action pane is the one at the left or the top side.
                      startActionPane: ActionPane(
                        // A motion is a widget used to control how the pane animates.
                        motion: const ScrollMotion(),
                        // A pane can dismiss the Slidable.
                        dismissible: DismissiblePane(onDismissed: () {
                          _handleDelete(user);
                        }),
                        // All actions are defined in the children parameter.
                        children: [
                          // A SlidableAction can have an icon and/or a label.
                          SlidableAction(
                            onPressed: (_) {
                              _handleDelete(user);
                            },
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),

                      // The end action pane is the one at the right or the bottom side.
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              _handleEdit(user);
                            },
                            backgroundColor: Colors.green,
                            foregroundColor: Theme.of(context).primaryColor,
                            icon: Icons.edit,
                            label: 'Edit',
                          ),
                          SlidableAction(
                            onPressed: (context) {
                              _handleBlock(user);
                            },
                            backgroundColor: ColorConstants.secondary,
                            foregroundColor: Theme.of(context).primaryColor,
                            icon: user.blocked ? Icons.block_flipped : Icons.block,
                            label: user.blocked ? 'Unblock' : 'Block',
                          ),
                        ],
                      ),

                      // The child of the Slidable is what the user sees when the
                      // component is not dragged.
                      child: TileWidget(
                        title: user.name,
                        subtitle: "${user.email} ${user.blocked ? "(blocked)" : ""}",
                        imageUrl: user.image?.url,
                        isDisabled: true
                      ),
                    );
                  },
                  loadingWidget: LoadingAnimationWidget.fourRotatingDots(color: ColorConstants.secondary, size: 50),
                  errorWidget: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Error while fetching data.')
                    ],
                  ),
                  asyncListCallback: () async {
                    users = await userRepo.getAll(merchantId);
                    return users;
                  },
                  asyncListFilter: (q, list) {
                    return list
                        .where((element) => element.name.contains(q))
                        .toList();
                  },
                  emptyWidget: const NotFoundWidget(),
                  onRefresh: () async {},
                  onItemSelected: null,
                  inputDecoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Search users',
                    floatingLabelStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0)
                    )
                  ),
                ),
              ),
            ),
          ],
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