import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:purala/core/consts/color_constants.dart';
import 'package:purala/models/stock_model.dart';
import 'package:purala/providers/merchant_provider.dart';
import 'package:purala/repositories/stock_repository.dart';
import 'package:purala/core/components/layouts/authenticated_layout.dart';
import 'package:purala/core/components/not_found_widget.dart';
import 'package:purala/core/components/scaffold_widget.dart';
import 'package:purala/core/components/tile_widget.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class StockScreen extends StatelessWidget {
  const StockScreen({super.key});

  static const String routeName = "/stocks";

  @override
  Widget build(BuildContext context) {
    return const StockWidget();
  }
}

class StockWidget extends StatefulWidget {
  const StockWidget({Key? key}) : super(key: key);

  @override
  State<StockWidget> createState() => _StockWidgetState();
}

class _StockWidgetState extends State<StockWidget> {
  final _stockRepo = StockRepository();

  List<StockModel> stocks = [];
  bool isBusy = false;
  bool isLoading = false;
  int merchantId = 0;

  @override
  Widget build(BuildContext context) {
    merchantId = context.read<MerchantProvider>().merchant?.id ?? 0;

    return AuthenticatedLayout(
      child: ScaffoldWidget(
        title: "Stocks",
        appBarActions: [
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: IconButton(
                  icon: const Icon(Icons.add),
                  tooltip: 'Add stock',
                  onPressed: _handleAdd,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  icon: const Icon(Icons.replay),
                  tooltip: 'Reload stocks',
                  onPressed: _loadStocks,
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
                  SearchableList<StockModel>(
                  style: const TextStyle(fontSize: 25),
                  builder: (StockModel stock) {
                    return Slidable(
                      key: ValueKey(stock.id),
                      startActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        dismissible: DismissiblePane(onDismissed: () {
                          _handleDelete(stock);
                        }),
                        children: [
                          SlidableAction(
                            onPressed: (_) {
                              _handleDelete(stock);
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
                              _handleEdit(stock);
                            },
                            backgroundColor: Colors.green,
                            foregroundColor: Theme.of(context).primaryColor,
                            icon: Icons.edit,
                            label: 'Edit',
                          ),
                        ],
                      ),
                      child: TileWidget(
                        title: "${stock.supplierName} -> ${stock.productName}",
                        subtitle: "(Quantity: ${stock.quantity})",
                        // imageUrl: stock.image?.url,
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
                    stocks = await _stockRepo.getAll(merchantId);
                    return stocks;
                  },
                  asyncListFilter: (q, list) {
                    return list
                      .where((element) => element.productName!.contains(q) ||
                        element.supplierName!.contains(q))
                      .toList();
                  },
                  emptyWidget: const NotFoundWidget(),
                  onRefresh: () async {},
                  onItemSelected: null,
                  inputDecoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Search stocks',
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

  void _loadStocks() async {
    if (isBusy) {
      return;
    }
    setState(() {
      isLoading = isBusy = true;
    });

    var res = await _stockRepo.getAll(merchantId);

    setState(() {
      stocks = res;
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
    //   stock as StockModel;

    //   setState(() {
    //     stocks.insert(0, stock);
    //   });
    // }
  }

  void _handleEdit(StockModel stock) async {
    // final editStock = await Navigator.pushNamed(
    //   context,
    //   ProductFormScreen.routeName,
    //   arguments: StockFormArgs(
    //     type: 'edit',
    //     stock: stock,
    //   ),
    // );
    
    // if (editStock != null) {
    //   editStock as StockModel;

    //   setState(() {
    //     stocks[stocks.indexWhere((item) => item.id == editStock.id)] = editStock;
    //   });
    // }
  }

  void _handleDelete(StockModel stock) async {
    if (isBusy) {
      return;
    }

    setState(() {
      isBusy = true;
    });

    await _stockRepo.delete(stock);

    setState(() {
      isBusy = false;
      stocks.remove(stock);
    });
  }
}