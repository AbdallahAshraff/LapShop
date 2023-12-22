import 'package:ecommerceapp/core/controllers/cubits/products/cubit/product_cubit.dart';
import 'package:ecommerceapp/core/controllers/cubits/products/cubit/product_state.dart';
import 'package:ecommerceapp/screens/modules/cart.dart';
import 'package:ecommerceapp/screens/modules/favorite.dart';
import 'package:ecommerceapp/screens/modules/profile.dart';
import 'package:ecommerceapp/screens/widgets/build_product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/managers/nav.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ProductCubit.get(context);
        if (cubit.laptopsModel == null) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Products'),
            ),
            body: const Center(child: CircularProgressIndicator()),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Products'),
          ),
          drawer: Drawer(
              child: ListView(children: [
            ListTile(
              title: const Text('Cart'),
              leading: const Icon(Icons.person),
              onTap: () {
                navigateToNextScreen(context, const CartScreen());
              },
            ),
            ListTile(
              title: const Text('Favorite'),
              leading: const Icon(Icons.favorite),
              onTap: () {
                navigateToNextScreen(context, const FavoriteScreen());
              },
            ),
            ListTile(
              title: const Text('Profile'),
              leading: const Icon(Icons.person),
              onTap: () {
                navigateToNextScreen(context, const ProfileScreen());
              },
            ),
          ])),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  color: Colors.transparent,
                  child: GridView.count(
                    childAspectRatio: 1 / 1.3,
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 1.0,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    children: List.generate(
                        cubit.laptopsModel!.product!.length,
                        (index) => buildProductItem(
                           cubit.laptopsModel!.product![index],  context)),
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
