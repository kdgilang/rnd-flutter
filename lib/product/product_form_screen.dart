import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:purala/constants/color_constants.dart';
import 'package:purala/models/file_model.dart';
import 'package:purala/models/product_model.dart';
import 'package:purala/providers/merchant_provider.dart';
import 'package:purala/providers/user_provider.dart';
import 'package:purala/repositories/file_repository.dart';
import 'package:purala/repositories/product_repository.dart';
import 'package:purala/repositories/storage_repository.dart';
import 'package:purala/widgets/layouts/authenticated_layout.dart';
import 'package:purala/widgets/scaffold_widget.dart';
import 'package:flutter/services.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

class ProductFormScreen extends StatelessWidget {
  const ProductFormScreen({super.key});

  static const String routeName = "/add-product";

  @override
  Widget build(BuildContext context) {
    return const AuthenticatedLayout(
      child: ScaffoldWidget(
        title: "Product Form",
        child: ProductFormWidget(),
      )
    );
  }
}

class ProductFormWidget extends StatefulWidget {
  const ProductFormWidget({Key? key}) : super(key: key);

  @override
  State<ProductFormWidget> createState() => _ProductFormWidgetState();
}

class _ProductFormWidgetState extends State<ProductFormWidget> {
  final _productRepo = ProductRepository();
  final _storageRepo = StorageRepository();
  final _fileRepo = FileRepository();
  final _formKey = GlobalKey<FormState>();
  final _nameControl = TextEditingController();
  final _descriptionControl = TextEditingController();
  final _priceControl = TextEditingController();
  final _normalPriceControl = TextEditingController();
  final _quantityControl = TextEditingController();
  final _quantityNotifyControl = TextEditingController();
  final CurrencyTextInputFormatter _formatterPrice = CurrencyTextInputFormatter(locale: 'id', symbol: 'Rp', decimalDigits: 0);
  final CurrencyTextInputFormatter _formatterNormalPrice =  CurrencyTextInputFormatter(locale: 'id', symbol: 'Rp', decimalDigits: 0);

  bool isBusy = false;
  bool isLoading = false;
  bool _isEnabledProduct = false;
  File _image = File("");
  String _imageUrl = "";
  PlatformFile _imageMeta = PlatformFile(name: "", size: 0);
  late ProductModel _product;
  ProductFormArgs _productFormArgs = ProductFormArgs(type: '');

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _productFormArgs = ModalRoute.of(context)!.settings.arguments as ProductFormArgs;

    if (_productFormArgs.type == 'edit') {
      setState(() {
        _product = _productFormArgs.product!;
        _isEnabledProduct = _product.enabled;
        _nameControl.text = _product.name;
        _descriptionControl.text = _product.description;
        _priceControl.text = _formatterPrice.format(_product.price.toString());
        _normalPriceControl.text = _formatterNormalPrice.format(_product.normalPrice.toString());
        _quantityControl.text = _product.quantity.toString();
        _quantityNotifyControl.text = _product.quantityNotify.toString();
        _imageUrl = _product.image?.url ?? "";
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
                      return "Product name is required.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  controller: _descriptionControl,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: 'Description',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, width: 1.0)
                    )
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Product description is required.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  controller: _priceControl,
                  inputFormatters: <TextInputFormatter>[_formatterPrice],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: 'Price',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, width: 1.0)
                    )
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Product price is required.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  controller: _normalPriceControl,
                  inputFormatters: <TextInputFormatter>[_formatterNormalPrice],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: 'Normal price',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, width: 1.0)
                    )
                  ),
                ),
                const SizedBox(height: 20,),
                Wrap(
                  spacing: 20,
                  children: [
                    const Text("Quantity: "),
                    Text(_quantityControl.text)
                  ],
                ),
                const SizedBox(height: 10,),
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
                  onPressed: _handleAddStock,
                  child: const Text('Add stock'),
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  controller: _quantityNotifyControl,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: 'Quantity notify',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, width: 1.0)
                    )
                  ),
                ),
                const SizedBox(height: 20,),
                Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Show this product on sale?"),
                    Switch(
                      value: _isEnabledProduct,
                      activeColor: ColorConstants.secondary,
                      onChanged: (bool value) {
                        setState(() {
                          _isEnabledProduct = value;
                        });
                      },
                    ),
                  ],
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
    final updatedProduct = _product.copyWith(
      name: _nameControl.text,
      description: _descriptionControl.text,
      price: _formatterPrice.getUnformattedValue(),
      normalPrice: _formatterNormalPrice.getUnformattedValue(),
      quantity: int.parse(_quantityControl.text),
      quantityNotify: int.parse(_quantityNotifyControl.text),
      enabled: _isEnabledProduct,
    );

    await _productRepo.update(updatedProduct);

    if (_image.path.isNotEmpty) {
      final storageRes = await _storageRepo.upload(_imageMeta.name, _image, ProductModel.type);

      if(_product.image != null) {
        // remove prev image from storage.
        await _storageRepo.delete(_product.image!.name, ProductModel.type);
      }
      
      final imgProp = await decodeImageFromList(_image.readAsBytesSync());

      updatedProduct.image = FileModel(
        name: storageRes.name,
        caption: _nameControl.text,
        url: storageRes.url,
        size: _imageMeta.size,
        ext: _imageMeta.extension,
        alternativeText: _descriptionControl.text,
        height: imgProp.height,
        width: imgProp.width
      );

      _fileRepo.update(updatedProduct.image!, updatedProduct.id!, ProductModel.type);
    }

    if (mounted) {
      Navigator.pop(context, updatedProduct);
    }
  }

  Future<void> add() async {
    final product = ProductModel(
      name: _nameControl.text,
      description: _descriptionControl.text,
      price: _formatterPrice.getUnformattedValue(),
      normalPrice: _formatterNormalPrice.getUnformattedValue(),
      quantity: int.parse(_quantityControl.text),
      quantityNotify: int.parse(_quantityNotifyControl.text),
      enabled: _isEnabledProduct,
      merchantId: context.read<MerchantProvider>().merchant!.id!,
      userId: context.read<UserProvider>().user!.id!
    );

    final productId = await _productRepo.add(product);
    if (_image.path.isNotEmpty) {
      final storageRes = await _storageRepo.upload(_imageMeta.name, _image, ProductModel.type);
      final imgProp = await decodeImageFromList(_image.readAsBytesSync());

      product.image = FileModel(
        name: storageRes.name,
        caption: _descriptionControl.text,
        url: storageRes.url,
        size: _imageMeta.size,
        ext: _imageMeta.extension,
        alternativeText: _descriptionControl.text,
        height: imgProp.height,
        width: imgProp.width
      );

      _fileRepo.add(product.image!,
        productId,
        ProductModel.type
      );
    }

    if (mounted) {
      Navigator.pop(context, product.copyWith(id: productId));
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
      if (_productFormArgs.type == 'edit') {
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

  Future<void> _handleAddStock() async {
    
  }
}

class ProductFormArgs {
  final String type;
  final ProductModel? product;

  ProductFormArgs({
    required this.type,
    this.product
  });
}
