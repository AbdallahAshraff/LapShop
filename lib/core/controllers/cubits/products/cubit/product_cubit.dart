import 'package:ecommerceapp/core/controllers/cubits/products/cubit/product_state.dart';
import 'package:ecommerceapp/core/managers/constants.dart';
import 'package:ecommerceapp/core/network/remote/dio_helper.dart';
import 'package:ecommerceapp/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());
  static ProductCubit get(context) => BlocProvider.of(context);

  LaptopsModel? laptopsModel;

  void getHomeProducts() {
    emit(FetchProductLoading());
    DioHelperStore.getData(url: ApiConstants.productUrl).then((value) {
      laptopsModel = LaptopsModel.fromJson(value.data);
      print(laptopsModel!.product!.length);
      emit(FetchProductSuccess());
    }).catchError((onError) {
      print(onError.toString());
      emit(FetchProductFailed());
    });
  }

  int quantity = 1;
  void decrease() {
    if (quantity>0) {
  quantity--;
  emit(QuantityDecreased());
}
  }

  void increase() {
    quantity++;
    emit(QuantityIncreased());
  }
}
