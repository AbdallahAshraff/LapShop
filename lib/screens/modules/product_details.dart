import 'package:ecommerceapp/core/controllers/cubits/cart/cubit/cart_cubit.dart';
import 'package:ecommerceapp/core/controllers/cubits/favorite/cubit/favorite_cubit.dart';
import 'package:ecommerceapp/core/controllers/cubits/favorite/cubit/favorite_state.dart';
import 'package:ecommerceapp/core/controllers/cubits/products/cubit/product_cubit.dart';
import 'package:ecommerceapp/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class ProductDetails extends StatelessWidget {
  final Product product;

  const ProductDetails({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var favoriteCubit = FavoriteCubit.get(context);
    var cartCubit = CartCubit.get(context);

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
              '${product.price} \EGP',
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

            SizedBox(height: 16.0),
            // Add to Cart and Favorites Buttons
            Row(
              children: [
                // Add to Cart Button
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      fixedSize:
                          MaterialStateProperty.all(Size(double.infinity, 50)),
                      backgroundColor:
                          MaterialStateProperty.all(HexColor('#07094D')),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      cartCubit.addToCart(product.sId!);
                    },
                    child: Text(
                      'Add to Cart',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                // Add to Favorites Button
                IconButton(
                    onPressed: () {
                      favoriteCubit.favoriteID.contains(product.sId.toString())
                          ? favoriteCubit.deleteFavorite(product.sId)
                          : favoriteCubit.addToFavorite(product.sId);
                    },
                    icon: BlocConsumer<FavoriteCubit, FavoriteStates>(
                      listener: (context, state) {
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        return Icon(
                         favoriteCubit.favoriteID
                                  .contains(product.sId.toString())
                              ? Icons.favorite : Icons.favorite_border,
                          size: 30,
                          color: favoriteCubit.favoriteID
                                  .contains(product.sId.toString())
                              ? Colors.red
                              : Colors.black,
                        );
                      },
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
