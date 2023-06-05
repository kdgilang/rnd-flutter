import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:purala/constants/color_constants.dart';
import 'package:purala/models/product_model.dart';
import 'package:purala/products/product_form_screen.dart';
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
                  onPressed: _handleAddProduct,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  icon: const Icon(Icons.replay),
                  tooltip: 'Reload products',
                  onPressed: _loadProducts,
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
                      key: ValueKey(product.id),
                      startActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        dismissible: DismissiblePane(onDismissed: () {
                          _handleDeleteProduct(product);
                        }),
                        children: [
                          SlidableAction(
                            onPressed: (_) {
                              _handleDeleteProduct(product);
                            },
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),
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
                              _handleToggleEnabledProduct(product);
                            },
                            backgroundColor: ColorConstants.secondary,
                            foregroundColor: Theme.of(context).primaryColor,
                            icon: product.enabled ? Icons.disabled_by_default : Icons.check,
                            label: product.enabled ? 'Disable' : 'Enable',
                          ),
                        ],
                      ),
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

  void _loadProducts() async {
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

  void _handleToggleEnabledProduct(ProductModel product) async {
    if (isBusy) {
      return;
    }

    setState(() {
      isBusy = true;
    });

    final updatedProduct = product.copyWith(enabled: !product.enabled);

    await productRepo.update(updatedProduct);

    setState(() {
      isBusy = false;
      products[products.indexWhere((item) => item.id == product.id)] = updatedProduct;
    });
  }

  void _handleAddProduct() async {
    final product = await Navigator.pushNamed(
      context,
      ProductFormScreen.routeName,
      arguments: ProductFormArgs(
        type: 'add',
      ),
    );
    
    if (product != null) {
      product as ProductModel;

      setState(() {
        products.insert(0, product);
      });
    }
  }

  void _handleEditUser(ProductModel product) async {
    final editProduct = await Navigator.pushNamed(
      context,
      ProductFormScreen.routeName,
      arguments: ProductFormArgs(
        type: 'edit',
        product: product,
      ),
    );
    
    if (editProduct != null) {
      editProduct as ProductModel;

      setState(() {
        products[products.indexWhere((item) => item.id == editProduct.id)] = editProduct;
      });
    }
  }

  void _handleDeleteProduct(ProductModel product) async {
    if (isBusy) {
      return;
    }

    setState(() {
      isBusy = true;
    });

    await productRepo.delete(product);

    setState(() {
      isBusy = false;
      products.remove(product);
    });
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