import 'dart:convert';

import 'package:do_an_mobile/data_sources/repositories/history_purchase_repository.dart';
import 'package:do_an_mobile/models/home_model/history_purchase_model.dart';

abstract class FeedbackViewContract {
  void onFeedbackComplete();
  void onFeedbackError(String msg);
}

class FeedbackPresenter {
  FeedbackViewContract? _view;
  FeedbackPresenter(this._view);

  Future feedback(String productID, String orderID, String childTitle,
      String comment, double rate) async {
    HistoryPurchaseRepositoryImpl.shared
        .feedback(productID, orderID, childTitle, comment, rate).then((value) {
          FeedbackModel feedbackModel = FeedbackModel.fromJson(jsonDecode(value));
          if (feedbackModel.code == 200) {
            _view!.onFeedbackComplete();
          } else {
            _view!.onFeedbackError(feedbackModel.message);
          }
    }).catchError((onError) {
      _view!.onFeedbackError(onError);
    });
  }
}