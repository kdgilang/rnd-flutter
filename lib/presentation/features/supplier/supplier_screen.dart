import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:purala/presentation/core/consts/color_constants.dart';
import 'package:purala/models/supplier_model.dart';
import 'package:purala/providers/merchant_provider.dart';
import 'package:purala/repositories/supplier_repository.dart';
import 'package:purala/presentation/features/supplier/supplier_form_screen.dart';
import 'package:purala/presentation/core/components/layouts/authenticated_layout.dart';
import 'package:purala/presentation/core/components/not_found_widget.dart';
import 'package:purala/presentation/core/components/scaffold_widget.dart';
import 'package:purala/presentation/core/components/tile_widget.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SupplierScreen extends StatelessWidget {
  const SupplierScreen({super.key});

  static const String routeName = "/suppliers";

  @override
  Widget build(BuildContext context) {
    return const SupplierWidget();
  }
}

class SupplierWidget extends StatefulWidget {
  const SupplierWidget({Key? key}) : super(key: key);

  @override
  State<SupplierWidget> createState() => _SupplierWidgetState();
}

class _SupplierWidgetState extends State<SupplierWidget> {
  final _supplierRepo = SupplierRepository();

  List<SupplierModel> suppliers = [];
  bool isBusy = false;
  bool isLoading = false;
  int merchantId = 0;

  @override
  Widget build(BuildContext context) {
    merchantId = context.watch<MerchantProvider>().merchant?.id ?? 0;

    return AuthenticatedLayout(
      child: ScaffoldWidget(
        title: "Suppliers",
        appBarActions: [
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: IconButton(
                  icon: const Icon(Icons.add),
                  tooltip: 'Add supplier',
                  onPressed: _handleAdd,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  icon: const Icon(Icons.replay),
                  tooltip: 'Reload suppliers',
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
                  SearchableList<SupplierModel>(
                  style: const TextStyle(fontSize: 25),
                  builder: (SupplierModel supplier) {
                    return Slidable(
                      key: ValueKey(supplier.id),
                      startActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        dismissible: DismissiblePane(onDismissed: () {
                          _handleDelete(supplier);
                        }),
                        children: [
                          SlidableAction(
                            onPressed: (_) {
                              _handleDelete(supplier);
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
                              _handleEdit(supplier);
                            },
                            backgroundColor: Colors.green,
                            foregroundColor: Theme.of(context).primaryColor,
                            icon: Icons.edit,
                            label: 'Edit',
                          ),
                        ],
                      ),
                      child: TileWidget(
                        title: supplier.name,
                        subtitle: "${supplier.address}",
                        // imageUrl: supplier.image?.url,
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
                    suppliers = await _supplierRepo.getAll(merchantId);
                    return suppliers;
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
                    hintText: 'Search suppliers',
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

    var res = await _supplierRepo.getAll(merchantId);

    setState(() {
      suppliers = res;
      isLoading = isBusy = false;
    });
  }

  void _handleAdd() async {
    final supplier = await Navigator.pushNamed(
      context,
      SupplierFormScreen.routeName,
      arguments: SupplierFormArgs(
        type: 'add',
      ),
    );
    
    if (supplier != null) {
      supplier as SupplierModel;

      setState(() {
        suppliers.insert(0, supplier);
      });
    }
  }

  void _handleEdit(SupplierModel supplier) async {
    final res = await Navigator.pushNamed(
      context,
      SupplierFormScreen.routeName,
      arguments: SupplierFormArgs(
        type: 'edit',
        supplier: supplier,
      ),
    );
    
    if (res != null) {
      res as SupplierModel;

      setState(() {
        suppliers[suppliers.indexWhere((item) => item.id == res.id)] = res;
      });
    }
  }

  void _handleDelete(SupplierModel supplier) async {
    if (isBusy) {
      return;
    }

    setState(() {
      isBusy = true;
    });

    await _supplierRepo.delete(supplier);

    setState(() {
      isBusy = false;
      suppliers.remove(supplier);
    });
  }
}