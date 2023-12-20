import 'package:ecommerceapp/core/controllers/cubits/favorite/cubit/favorite_state.dart';
import 'package:ecommerceapp/core/managers/constants.dart';
import 'package:ecommerceapp/core/managers/values.dart';
import 'package:ecommerceapp/models/favorite_model.dart';
import 'package:ecommerceapp/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../network/remote/dio_helper.dart';

class FavoriteCubit extends Cubit<FavoriteStates> {
  FavoriteCubit() : super(FavoriteInitState());

  static FavoriteCubit get(context) => BlocProvider.of(context);

  FavoriteModel? favorite;
  bool isFavorite = false;
  Set<String> favoriteID = {};
  void getFavorite() {
    DioHelperStore.getData(url: ApiConstants.favoriteApi, data: {
      'nationalId': natoinalId,
    }).then((value) {
      favorite = FavoriteModel.fromJson(value.data);
      favorite?.favoriteProducts?.forEach((product) {
        favoriteID.add(product.sId!);
        print(favoriteID);
      });

      print(favorite);
      emit(GetFavorite());
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorGetFavorite());
    });
  }

  void addToFavorite(productId) {
    DioHelperStore.postData(url: ApiConstants.favoriteApi, data: {
      'nationalId': natoinalId,
      'productId': productId,
    }).then((value) {
      emit(AddToFavoriteSuccess());
      favoriteID.add(productId);
      getFavorite();
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorAddToFavorite());
    });
  }

  void deleteFavorite(
    productId,
  ) {
    DioHelperStore.delData(url: ApiConstants.favoriteApi, data: {
      'nationalId': natoinalId,
      'productId': productId,
    }).then((value) {
      emit(DeleteFavorite());
      favoriteID.remove(productId);
      getFavorite();
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorDeleteFavorite());
    });
  }
}
