import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:purala/constants/color_constants.dart';
import 'package:purala/models/supplier_model.dart';
import 'package:purala/repositories/supplier_repository.dart';
import 'package:purala/widgets/layouts/authenticated_layout.dart';
import 'package:purala/widgets/scaffold_widget.dart';

class SupplierFormScreen extends StatelessWidget {
  const SupplierFormScreen({super.key});

  static const String routeName = "/add-supplier";

  @override
  Widget build(BuildContext context) {
    return const AuthenticatedLayout(
      child: ScaffoldWidget(
        title: "Supplier Form",
        child: SupplierFormWidget(),
      )
    );
  }
}

class SupplierFormWidget extends StatefulWidget {
  const SupplierFormWidget({Key? key}) : super(key: key);

  @override
  State<SupplierFormWidget> createState() => _SupplierFormWidgetState();
}

class _SupplierFormWidgetState extends State<SupplierFormWidget> {
  final _supplierRepo = SupplierRepository();
  final _formKey = GlobalKey<FormState>();
  final _nameControl = TextEditingController();
  final _addressControl = TextEditingController();
  final _phoneControl = TextEditingController();

  bool isBusy = false;
  bool isLoading = false;
  late SupplierModel _supplier;
  SupplierFormArgs _supplierFormArgs = SupplierFormArgs(type: '');

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _supplierFormArgs = ModalRoute.of(context)!.settings.arguments as SupplierFormArgs;

    if (_supplierFormArgs.type == 'edit') {
      setState(() {
        _supplier = _supplierFormArgs.supplier!;
        _nameControl.text = _supplier.name;
        _addressControl.text = _supplier.address ?? "";
        _phoneControl.text = _supplier.phone ?? "";
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
                  controller: _nameControl,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: 'Name',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, width: 1.0)
                    )
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Supplier name is required.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  controller: _addressControl,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: 'Address',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, width: 1.0)
                    )
                  ),
                ),
                TextFormField(
                  controller: _phoneControl,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: 'Phone',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, width: 1.0)
                    )
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
    final updatedsupplier = _supplier.copyWith(
      name: _nameControl.text,
      phone: _phoneControl.text,
      address: _addressControl.text,
    );

    await _supplierRepo.update(updatedsupplier);

    if (mounted) {
      Navigator.pop(context, updatedsupplier);
    }
  }

  Future<void> add() async {
    final supplier = SupplierModel(
      name: _nameControl.text,
      phone: _phoneControl.text,
      address: _addressControl.text,
    );

    final supplierId = await _supplierRepo.add(supplier);

    if (mounted) {
      Navigator.pop(context, supplier.copyWith(id: supplierId));
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
      if (_supplierFormArgs.type == 'edit') {
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
}

class SupplierFormArgs {
  final String type;
  final SupplierModel? supplier;

  SupplierFormArgs({
    required this.type,
    this.supplier
  });
}
