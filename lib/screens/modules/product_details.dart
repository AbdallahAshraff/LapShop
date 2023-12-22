import 'package:ecommerceapp/core/controllers/cubits/cart/cubit/cart_cubit.dart';
import 'package:ecommerceapp/core/controllers/cubits/favorite/cubit/favorite_cubit.dart';
import 'package:ecommerceapp/core/controllers/cubits/favorite/cubit/favorite_state.dart';
import 'package:ecommerceapp/core/methods/show_snack_bar.dart';
import 'package:ecommerceapp/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class ProductDetails extends StatelessWidget {
  final Product product;

  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    var favoriteCubit = FavoriteCubit.get(context);
    var cartCubit = CartCubit.get(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
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
            const SizedBox(height: 16.0),
            // Product Name
            Text(
              product.name!,
              style: const TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            // Company
            Text(
              product.company!,
              style: const TextStyle(color: Colors.grey, fontSize: 18),
            ),
            const SizedBox(height: 8.0),
            // Price
            Text(
              '${product.price} EGP',
              style: const TextStyle(
                  fontSize: 26.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            // Description
            Text(
              '${product.description}',
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 16.0),
          

            const SizedBox(height: 16.0),
           
            Row(
              children: [
              
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      fixedSize:
                          MaterialStateProperty.all(const Size(double.infinity, 50)),
                      backgroundColor:
                          MaterialStateProperty.all(HexColor('#07094D')),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      await cartCubit.addToCart(product.sId!).then((value) =>
                          showSnackBar(context,
                              '${product.name} has been added to cart'));
                    },
                    child: const Text(
                      'Add to Cart',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
               
                IconButton(
                    onPressed: () {
                      favoriteCubit.favoriteID.contains(product.sId.toString())
                          ? {
                              favoriteCubit.deleteFavorite(product.sId),
                              showSnackBar(context,
                                  '${product.name} has been removed from Favorites')
                            }
                          : {
                              favoriteCubit.addToFavorite(product.sId),
                              showSnackBar(context,
                                  '${product.name} has been added to Favorites')
                            };
                    },
                    icon: BlocConsumer<FavoriteCubit, FavoriteStates>(
                      listener: (context, state) {
                       
                      },
                      builder: (context, state) {
                        return Icon(
                          favoriteCubit.favoriteID
                                  .contains(product.sId.toString())
                              ? Icons.favorite
                              : Icons.favorite_border,
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
