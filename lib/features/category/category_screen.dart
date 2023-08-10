import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:purala/core/consts/color_constants.dart';
import 'package:purala/models/category_model.dart';
import 'package:purala/providers/merchant_provider.dart';
import 'package:purala/repositories/category_repository.dart';
import 'package:purala/core/components/layouts/authenticated_layout.dart';
import 'package:purala/core/components/not_found_widget.dart';
import 'package:purala/core/components/scaffold_widget.dart';
import 'package:purala/core/components/tile_widget.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  static const String routeName = "/categories";

  @override
  Widget build(BuildContext context) {
    return const CategoryWidget();
  }
}

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({Key? key}) : super(key: key);

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  final _categoryRepo = CategoryRepository();

  List<CategoryModel> categories = [];
  bool isBusy = false;
  bool isLoading = false;
  int merchantId = 0;

  @override
  Widget build(BuildContext context) {
    merchantId = context.read<MerchantProvider>().merchant?.id ?? 0;

    return AuthenticatedLayout(
      child: ScaffoldWidget(
        title: "Categories",
        appBarActions: [
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: IconButton(
                  icon: const Icon(Icons.add),
                  tooltip: 'Add category',
                  onPressed: _handleAdd,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  icon: const Icon(Icons.replay),
                  tooltip: 'Reload categories',
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
                  SearchableList<CategoryModel>(
                  style: const TextStyle(fontSize: 25),
                  builder: (CategoryModel category) {
                    return Slidable(
                      key: ValueKey(category.id),
                      startActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        dismissible: DismissiblePane(onDismissed: () {
                          _handleDelete(category);
                        }),
                        children: [
                          SlidableAction(
                            onPressed: (_) {
                              _handleDelete(category);
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
                              _handleEdit(category);
                            },
                            backgroundColor: Colors.green,
                            foregroundColor: Theme.of(context).primaryColor,
                            icon: Icons.edit,
                            label: 'Edit',
                          ),
                        ],
                      ),
                      child: TileWidget(
                        title: category.name,
                        subtitle: "${category.description}",
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
                    categories = await _categoryRepo.getAll(merchantId);
                    return categories;
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
                    hintText: 'Search categories',
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

    var res = await _categoryRepo.getAll(merchantId);

    setState(() {
      categories = res;
      isLoading = isBusy = false;
    });
  }

  void _handleAdd() async {
    // final stock = await Navigator.pushNamed(
    //   context,
    //   ProductFormScreen.routeName,
    //   arguments: StockFormArgs(
    //     type: 'add',
    //   ),
    // );
    
    // if (stock != null) {
    //   stock as CategoryModel;

    //   setState(() {
    //     categories.insert(0, category);
    //   });
    // }
  }

  void _handleEdit(CategoryModel category) async {
    // final editStock = await Navigator.pushNamed(
    //   context,
    //   ProductFormScreen.routeName,
    //   arguments: StockFormArgs(
    //     type: 'edit',
    //     stock: stock,
    //   ),
    // );
    
    // if (editStock != null) {
    //   editStock as CategoryModel;

    //   setState(() {
    //     categories[categories.indexWhere((item) => item.id == editcategory.id)] = editStock;
    //   });
    // }
  }

  void _handleDelete(CategoryModel category) async {
    if (isBusy) {
      return;
    }

    setState(() {
      isBusy = true;
    });

    await _categoryRepo.delete(category);

    setState(() {
      isBusy = false;
      categories.remove(category);
    });
  }
}