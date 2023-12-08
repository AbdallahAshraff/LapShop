import 'package:ecommerceapp/core/controllers/cubits/products/cubit/product_cubit.dart';
import 'package:ecommerceapp/core/controllers/cubits/products/cubit/product_state.dart';
import 'package:ecommerceapp/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetails extends StatelessWidget {
  final Product product;

  const ProductDetails({Key? key, required this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var cubit = ProductCubit.get(context);
    return BlocConsumer<ProductCubit, ProductState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Product Details'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      image: DecorationImage(
                        image: NetworkImage(product.image!),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                // Product Name
                Text(
                  product.name!,
                  style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                // Company
                Text(
                  '${product.company!}',
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
                SizedBox(height: 8.0),
                // Price
                Text(
                  '\$${product.price}',
                  style: TextStyle(
                      fontSize: 26.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.0),
                // Description
                Text(
                  '${product.description}',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 16.0),
                // Quantity Control
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Minus Button
                    InkWell(
                      onTap: () {
                        cubit.decrease();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.deepOrange,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.remove, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0),

                    Text(
                      '${cubit.quantity}',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(width: 16.0),
                    // Add Button
                    InkWell(
                      onTap: () {
                        cubit.increase();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.deepOrange,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.add, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                // Add to Cart Button
                ElevatedButton(
                  style: ButtonStyle(
                    fixedSize:
                        MaterialStateProperty.all(Size(double.infinity, 50)),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.deepOrange),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
