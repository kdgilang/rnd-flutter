import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:purala/constants/color_constants.dart';
import 'package:purala/models/user_model.dart';
import 'package:purala/repositories/user_repository.dart';
import 'package:purala/widgets/layouts/authenticated_layout.dart';
import 'package:purala/widgets/scaffold_widget.dart';
import 'package:purala/widgets/tile_widget.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class User {
  final String? name;
  final String? avatar;
  User({this.name, this.avatar});
}

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  static const String routeName = "/users";
  

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('This is a snackbar')));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  icon: const Icon(Icons.replay),
                  tooltip: 'Reload users',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('This is a snackbar')));
                  },
                ),
              ),
            ],
          )
        ],
        child: const UserWidget(),
      )
    );
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: SearchableList<UserModel>(
                style: const TextStyle(fontSize: 25),
                onPaginate: () async {
                  await Future.delayed(const Duration(milliseconds: 1000));
                  setState(() {
                    // actors.addAll([
                    //   Actor(age: 22, name: 'Fathi', lastName: 'Hadawi'),
                    //   Actor(age: 22, name: 'Hichem', lastName: 'Rostom'),
                    //   Actor(age: 22, name: 'Kamel', lastName: 'Twati'),
                    // ]);
                  });
                },
                builder: (UserModel user) {
                  return Slidable(
                    // Specify a key if the Slidable is dismissible.
                    key: ValueKey(user.id),
                    // The start action pane is the one at the left or the top side.
                    startActionPane: ActionPane(
                      // A motion is a widget used to control how the pane animates.
                      motion: const ScrollMotion(),
                      // A pane can dismiss the Slidable.
                      dismissible: DismissiblePane(onDismissed: () {}),
                      // All actions are defined in the children parameter.
                      children: const [
                        // A SlidableAction can have an icon and/or a label.
                        SlidableAction(
                          onPressed: null,
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
                          onPressed: null,
                          backgroundColor: Colors.green,
                          foregroundColor: Theme.of(context).primaryColor,
                          icon: Icons.edit,
                          label: 'Edit',
                        ),
                        SlidableAction(
                          onPressed: null,
                          backgroundColor: ColorConstants.secondary,
                          foregroundColor: Theme.of(context).primaryColor,
                          icon: Icons.archive,
                          label: 'Archive',
                        ),
                      ],
                    ),

                    // The child of the Slidable is what the user sees when the
                    // component is not dragged.
                    child: TileWidget(title: user.name, subtitle: user.email),
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
                  return userRepo.getAll(1);
                },
                asyncListFilter: (q, list) {
                  return list
                      .where((element) => element.name.contains(q))
                      .toList();
                },
                emptyWidget: const EmptyView(),
                onRefresh: () async {},
                onItemSelected: (UserModel item) {},
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
    );
  }

  void addActor() {
    // users.add(UserModel(
    //   i
    //   name: 'ALi',
    // ));
    setState(() {});
  }
}

class EmptyView extends StatelessWidget {
  const EmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error,
        ),
        Text('No Items Found.'),
      ],
    );
  }
}