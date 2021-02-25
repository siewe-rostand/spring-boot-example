import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:login_form/model/account-model.dart';
import 'package:login_form/model/product-model.dart';
import 'package:login_form/product/product-detail.dart';

class ProviderClass extends ChangeNotifier {
   Account account = Account();
   Product product = Product();
  bool loading = false;

  getPostData(context) async {
    loading = true;
    account = await ProductView.fetchTeams(context,2);
    loading = false;

    notifyListeners();
  }

}
