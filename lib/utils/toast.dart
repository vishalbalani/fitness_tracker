import 'package:fitness_tracker/constants/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String text) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      textColor: kOffWhite,
      fontSize: 16.0);
}
