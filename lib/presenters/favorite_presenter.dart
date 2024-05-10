import 'dart:convert';

import 'package:do_an_mobile/core/app_showtoast.dart';
import 'package:do_an_mobile/data_sources/repositories/favorite_product_repository.dart';
import 'package:do_an_mobile/models/home_model/favorite_model.dart';

import '../models/home_model/history_purchase_model.dart';
import '../models/home_model/product_model.dart';

abstract class FavoriteViewContract {
  void getFavoriteListComplete(List<NewProduct> products);
  void getFavoriteListError(String msg);
  void deleteProductComplete(String productID);
}

class FavoritePresenter {
  FavoriteViewContract? _view;
  FavoritePresenter(this._view);

  Future getListFavoriteProduct() async {
    FavoriteRepositoryImpl.shared.getListFavorite().then((value) {
      FavoriteModel model = FavoriteModel.fromJson(jsonDecode(value));
      if (model.code == 200) {
        _view!.getFavoriteListComplete(model.products);
      } else {
        _view!.getFavoriteListError('get wishlist fail');
      }
    }).catchError((onError) {
      _view!.getFavoriteListError(onError.toString());
    });
  }

  Future deleteProductFromWishList(String productID) async {
    FavoriteRepositoryImpl.shared
        .deleteProductFromListFavorite(productID).then((value) {
      FeedbackModel model = FeedbackModel.fromJson(jsonDecode(value));
      AppShowToast.showToast(model.message);
      if (model.code == 200) {
        _view!.deleteProductComplete(productID);
      }
    }).catchError((onError) {
      AppShowToast.showToast(onError.toString());
    });
  }
}