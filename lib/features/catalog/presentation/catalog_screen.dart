import 'package:flutter/material.dart';

import 'widgets/catalog_body.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0.0,
        title: Text('Каталог'),
      ),
      body: CatalogBody(),
    );
  }
}
