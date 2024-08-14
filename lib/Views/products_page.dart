import 'dart:async';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../Controllers/auth_service.dart';
import '../Controllers/product_service.dart';
import '../Controllers/remote_config_service.dart';
import '../models/product_model.dart';
import 'login_page.dart';

class ProductsPage extends StatefulWidget {
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late Future<List<ProductModel>> _productsFuture;
  late RemoteConfigService _remoteConfigService;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _remoteConfigService = Provider.of<RemoteConfigService>(context, listen: false);
    _productsFuture = _fetchProducts();
    timer = Timer.periodic(const Duration(seconds: 10), (Timer t) async {

      await _remoteConfigService.initialize();
      setState((){});
    });
  }

  @override
  void dispose() {
    super.dispose();

    if(timer != null) {
      timer!.cancel();
    }
  }

  Future<List<ProductModel>> _fetchProducts() async {
    await _remoteConfigService.initialize();
    // Fetch products
    final productService = Provider.of<ProductService>(context, listen: false);
    return await productService.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Feed'),
          centerTitle:true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () async {
              await _remoteConfigService.initialize();
              setState((){});
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              final authService = Provider.of<AuthService>(context, listen: false);
              await authService.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<ProductModel>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No products available'));
          }

          final products = snapshot.data!;
          final showDiscountPrice = _remoteConfigService.showDiscountPrice;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              final price = showDiscountPrice
                  ? product.getDiscountedPrice()
                  : product.price;

              return Card(
                margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                elevation: 10.0,
                shadowColor: Colors.pink,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(4.0)),
                      child: Image.network(
                        product.imageUrl.isNotEmpty ? product.imageUrl[0].toString() : 'https://via.placeholder.com/150?text=No+Image',
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        product.name,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      child: Text(
                        'Price: \$${price.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 16, color: Colors.green[700]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      child: Text(
                        'Category: ${product.category}',
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      child: Text(
                        'Weight: ${product.weight} kg',
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        product.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
