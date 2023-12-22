import 'package:ecommerceapp/core/managers/constants.dart';
import 'package:ecommerceapp/core/managers/values.dart';
import 'package:ecommerceapp/core/network/remote/dio_helper.dart';
import 'package:ecommerceapp/models/cart_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_state.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(CartInitState());

  static CartCubit get(context) => BlocProvider.of(context);

  Future<void> addToCart(productId) {
    
   return DioHelperStore.postData(url: ApiConstants.addCartApi, data: {
      'nationalId': natoinalId,
      'productId': productId,
      'quantity': '1'
    }).then((value) {
      emit(AddToCartSuccess());
      getCart();
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorAddToCart());
    });
  }

  CartModel? cartModel;

  void getCart() {
    DioHelperStore.getData(url: ApiConstants.getCartApi, data: {
      'nationalId': natoinalId,
    }).then((value) {
      cartModel = CartModel.fromJson(value.data);
     print(cartModel!.products!.length);
      emit(GetCart());
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorGetCart());
    });
  }

  Future<void>deletecart(productId) {
    return DioHelperStore.delData(url: ApiConstants.deleteCartApi, data: {
      'nationalId': natoinalId,
      'productId': productId,
    }).then((value) {
      emit(DeleteCart());
      getCart();
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorDeleteCart());
    });
  }

  void updateQuantity(productId, quantity) {
    DioHelperStore.putData(url: ApiConstants.updateCartApi, data: {
      'nationalId': natoinalId,
      'productId': productId,
      'quantity': quantity
    }).then((value) {
      emit(UpdateCart());
      getCart();
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorUpdateCart());
    });
  }
}
