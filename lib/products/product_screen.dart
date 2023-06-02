import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:purala/constants/color_constants.dart';
import 'package:purala/models/product_model.dart';
import 'package:purala/providers/merchant_provider.dart';
import 'package:purala/repositories/product_repository.dart';
import 'package:purala/widgets/layouts/authenticated_layout.dart';
import 'package:purala/widgets/scaffold_widget.dart';
import 'package:purala/widgets/tile_widget.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  static const String routeName = "/products";

  @override
  Widget build(BuildContext context) {
    return const ProductWidget();
  }
}

class ProductWidget extends StatefulWidget {
  const ProductWidget({Key? key}) : super(key: key);

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  final productRepo = ProductRepository();

  List<ProductModel> products = [];
  bool isBusy = false;
  bool isLoading = false;
  int merchantId = 0;

  @override
  Widget build(BuildContext context) {
    merchantId = context.read<MerchantProvider>().merchant?.id ?? 0;

    return AuthenticatedLayout(
      child: ScaffoldWidget(
        title: "Products",
        appBarActions: [
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: IconButton(
                  icon: const Icon(Icons.add),
                  tooltip: 'Add product',
                  onPressed: _handleAddUser,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  icon: const Icon(Icons.replay),
                  tooltip: 'Reload products',
                  onPressed: _loadUsers,
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
                  SearchableList<ProductModel>(
                  style: const TextStyle(fontSize: 25),
                  builder: (ProductModel product) {
                    return Slidable(
                      // Specify a key if the Slidable is dismissible.
                      key: ValueKey(product.id),
                      // The start action pane is the one at the left or the top side.
                      startActionPane: ActionPane(
                        // A motion is a widget used to control how the pane animates.
                        motion: const ScrollMotion(),
                        // A pane can dismiss the Slidable.
                        dismissible: DismissiblePane(onDismissed: () {
                          _handleDeleteUser(product);
                        }),
                        // All actions are defined in the children parameter.
                        children: [
                          // A SlidableAction can have an icon and/or a label.
                          SlidableAction(
                            onPressed: (_) {
                              _handleDeleteUser(product);
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
                              _handleEditUser(product);
                            },
                            backgroundColor: Colors.green,
                            foregroundColor: Theme.of(context).primaryColor,
                            icon: Icons.edit,
                            label: 'Edit',
                          ),
                          SlidableAction(
                            onPressed: (context) {
                              _handleBlockUser(product);
                            },
                            backgroundColor: ColorConstants.secondary,
                            foregroundColor: Theme.of(context).primaryColor,
                            icon: product.enabled ? Icons.block_flipped : Icons.block,
                            label: product.enabled ? 'Disabled' : 'Enabled',
                          ),
                        ],
                      ),

                      // The child of the Slidable is what the user sees when the
                      // component is not dragged.
                      child: TileWidget(
                        title: product.name,
                        subtitle: "${product.name} ${product.enabled ? "(enabled)" : "(disabled)"}",
                        imageUrl: product.image?.url,
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
                    products = await productRepo.getAllEnabled(merchantId);
                    return products;
                  },
                  asyncListFilter: (q, list) {
                    return list
                        .where((element) => element.name.contains(q))
                        .toList();
                  },
                  emptyWidget: const EmptyView(),
                  onRefresh: () async {},
                  onItemSelected: null,
                  inputDecoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Search products',
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

  void _loadUsers() async {
    if (isBusy) {
      return;
    }
    setState(() {
      isLoading = isBusy = true;
    });

    var res = await productRepo.getAllEnabled(merchantId);

    setState(() {
      products = res;
      isLoading = isBusy = false;
    });
  }

  void _handleBlockUser(ProductModel product) async {
    // if (isBusy) {
    //   return;
    // }

    // setState(() {
    //   isBusy = true;
    // });

    // final updatedProduct = product.copyWith(enabled: !product.blocked);

    // await productRepo.update(updatedProduct);

    // setState(() {
    //   isBusy = false;
    //   products[products.indexWhere((item) => item.id == product.id)] = updatedProduct;
    // });
  }

  void _handleAddUser() async {
    // final user = await Navigator.pushNamed(
    //   context,
    //   UserFormScreen.routeName,
    //   arguments: UserFormArgs(
    //     type: 'add',
    //   ),
    // );
    // if (user != null) {
    //   user as ProductModel;

    //   setState(() {
    //     users.insert(0, user);
    //   });
    // }
  }

  void _handleEditUser(ProductModel product) async {
    // final editUser = await Navigator.pushNamed(
    //   context,
    //   UserFormScreen.routeName,
    //   arguments: UserFormArgs(
    //     type: 'edit',
    //     user: user,
    //   ),
    // );
    
    // if (editUser != null) {
    //   editUser as ProductModel;

    //   setState(() {
    //     users[users.indexWhere((item) => item.id == editUser.id)] = editUser;
    //   });
    // }
  }

  void _handleDeleteUser(ProductModel product) async {
    // if (isBusy) {
    //   return;
    // }

    // setState(() {
    //   isBusy = true;
    // });

    // await productRepo.delete(user);

    // setState(() {
    //   isBusy = false;
    //   users.remove(user);
    // });
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