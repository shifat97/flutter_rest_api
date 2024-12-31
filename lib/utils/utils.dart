import 'package:flutter_rest_api/styles/styles.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppUtils {
  static void errorToast(message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppStyles.colorRed,
        textColor: AppStyles.colorWhite,
        fontSize: 16.0
    );
  }

  static void successToast(message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppStyles.colorGreen,
        textColor: AppStyles.colorWhite,
        fontSize: 16.0
    );
  }
}