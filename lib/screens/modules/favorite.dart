import 'package:ecommerceapp/core/controllers/cubits/favorite/cubit/favorite_cubit.dart';
import 'package:ecommerceapp/core/controllers/cubits/favorite/cubit/favorite_state.dart';
import 'package:ecommerceapp/screens/widgets/favorite_cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoriteCubit, FavoriteStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = FavoriteCubit.get(context);
        print(cubit.favorite);
        if (cubit.favorite!.favoriteProducts!.isEmpty) {
          return Scaffold(
            
              appBar: AppBar(
                title: const Text('Favorites'),
              ),
              body: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.menu,
                      color: Colors.grey,
                      size: 70,
                    ),
                    Text('No Favorite Products Added',
                        style: TextStyle(
                          fontSize: 18,
                        ))
                  ],
                ),
              ));
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Favorites'),
            ),
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
                          cubit.favorite!.favoriteProducts!.length,
                          (index) => favoriteProductItem(
                              cubit.favorite!.favoriteProducts![index],
                              context)),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
