import 'package:flutter/foundation.dart';

class SearchDataModel with ChangeNotifier {
    String _params;

    String get params => _params;


    void setParams(String params) {
      this._params = params;
      notifyListeners();
    }

}