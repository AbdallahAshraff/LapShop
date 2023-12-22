import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerceapp/core/controllers/cubits/cart/cubit/cart_cubit.dart';
import 'package:ecommerceapp/core/controllers/cubits/favorite/cubit/favorite_cubit.dart';
import 'package:ecommerceapp/core/controllers/cubits/favorite/cubit/favorite_state.dart';
import 'package:ecommerceapp/core/managers/nav.dart';
import 'package:ecommerceapp/core/methods/show_snack_bar.dart';
import 'package:ecommerceapp/models/product_model.dart';
import 'package:ecommerceapp/screens/modules/cart.dart';
import 'package:ecommerceapp/screens/modules/product_details.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

Widget buildProductItem(Product product, context) => InkWell(
      onTap: () {
        navigateToNextScreen(context, ProductDetails(product: product));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
            width: 180,
            height: 200,
            //color: Colors.green,
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: HexColor('#07094D'),
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20))),
                          height: 125,
                          child: Center(
                            child: RotatedBox(
                                quarterTurns: 1,
                                child: Text(
                                  product.status!,
                                  style: const TextStyle(color: Colors.white),
                                )),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(20)),
                                color: HexColor('#07094D').withOpacity(0.6),
                              ),
                              height: 125,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 30, left: 10),
                                child: CachedNetworkImage(
                                    imageUrl: product.image!,
                                    imageBuilder: (context, imageProvider) =>
                                        Image(image: imageProvider),
                                    placeholder: (context, url) => const Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.black,
                                          ),
                                        ),
                                    errorWidget: (context, url, error) {
                                      print(error.toString());
                                      return Center(
                                        child: CircularProgressIndicator(
                                          color: HexColor('#07094D'),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                            IconButton(
                                onPressed: () async {
                                  FavoriteCubit.get(context)
                                          .favoriteID
                                          .contains(product.sId.toString())
                                      ? {
                                          await FavoriteCubit.get(context)
                                              .deleteFavorite(product.sId),
                                          showSnackBar(context,
                                              '${product.name} has been removed from Favorites')
                                        }
                                      : {
                                          await FavoriteCubit.get(context)
                                              .addToFavorite(product.sId),
                                          showSnackBar(context,
                                              '${product.name} has been added to Favorites')
                                        };
                                },
                                icon:
                                    BlocConsumer<FavoriteCubit, FavoriteStates>(
                                  listener: (context, state) {
                                    // TODO: implement listener
                                  },
                                  builder: (context, state) {
                                    return Icon(
                                      FavoriteCubit.get(context)
                                              .favoriteID
                                              .contains(product.sId.toString())
                                          ? Icons.favorite
                                          : Icons.favorite_border_outlined,
                                      size: 25,
                                      color: FavoriteCubit.get(context)
                                              .favoriteID
                                              .contains(product.sId.toString())
                                          ? Colors.red
                                          : Colors.grey[300],
                                    );
                                  },
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    product.name!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                if (product.status == 'New')
                                  Expanded(
                                    child: Container(
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color: HexColor('#C70000'),
                                            borderRadius:
                                                const BorderRadius.horizontal(
                                                    left: Radius.circular(20))),
                                        child: const Center(
                                            child: Text(
                                          '10% Off',
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 8),
                                        ))),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              product.company!,
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 15),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  '\$${product.price.toStringAsFixed(2)} ',
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                              ),
                              const Spacer(),
                              Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: HexColor('#07094D'),
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20))),
                                  child: MaterialButton(
                                    onPressed: () async {
                                      await CartCubit.get(context)
                                          .addToCart(product.sId);
                                      showSnackBar(context,
                                          '${product.name} has been added to cart');
                                      navigateToNextScreen(
                                          context, const CartScreen());
                                    },
                                    child: Text(
                                      'Buy'.toUpperCase(),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
    );
