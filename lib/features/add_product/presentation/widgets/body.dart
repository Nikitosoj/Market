import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:style_hub/core/components/custom_form.dart';
import 'package:style_hub/features/add_product/bloc/seller_bloc.dart';

import '../../../../auth_notifier.dart';
import '../../../../core/models/user.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late TextEditingController _nameController;
  late TextEditingController _typeController;
  late TextEditingController _subTypeController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _sizeController;
  late TextEditingController _ratingController;
  late TextEditingController _stockController;

  void addProduct(String id) {
    _bloc.add(AddProductButton(context,
        size: _sizeController.text.toLowerCase(),
        name: _nameController.text,
        type: _typeController.text.toLowerCase(),
        subType: _subTypeController.text.toLowerCase(),
        price: double.parse(_priceController.text),
        description: _descriptionController.text,
        sellerId: id,
        stock: int.parse(_stockController.text)));
  }

  final _bloc = SellerBloc();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _typeController = TextEditingController();
    _subTypeController = TextEditingController();
    _descriptionController = TextEditingController();
    _priceController = TextEditingController();
    _sizeController = TextEditingController();
    _ratingController = TextEditingController();
    _stockController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _typeController.dispose();
    _subTypeController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _sizeController.dispose();
    _ratingController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<AuthNotifier>(context, listen: false).user!;
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('name'),
              SizedBox(height: 5.h),
              CustomForm(hint: 'Enter name', controller: _nameController),
              SizedBox(height: 16.0.h),
              const Text('type'),
              SizedBox(height: 5.h),
              CustomForm(hint: 'Enter type', controller: _typeController),
              SizedBox(height: 16.0.h),
              const Text('sub-type'),
              SizedBox(height: 5.h),
              CustomForm(
                  hint: 'Enter sub-type', controller: _subTypeController),
              SizedBox(height: 16.0.h),
              const Text('description'),
              SizedBox(height: 5.h),
              CustomForm(
                  hint: 'Enter description',
                  controller: _descriptionController),
              SizedBox(height: 16.0.h),
              const Text('price'),
              SizedBox(height: 5.h),
              CustomForm(hint: 'Enter price', controller: _priceController),
              SizedBox(height: 16.0.h),
              const Text('size'),
              SizedBox(height: 5.h),
              CustomForm(hint: 'Enter size', controller: _sizeController),
              SizedBox(height: 16.0.h),
              const Text('rating'),
              SizedBox(height: 5.h),
              CustomForm(hint: 'Enter rating', controller: _ratingController),
              SizedBox(height: 16.0.h),
              const Text('stock'),
              SizedBox(height: 5.h),
              CustomForm(hint: 'Enter stock', controller: _stockController),
              SizedBox(height: 16.0.h),
              TextButton(
                  onPressed: () {
                    addProduct(user.id);
                  },
                  child: const Text('Add product'))
            ],
          ),
        ),
      ),
    );
  }
}
