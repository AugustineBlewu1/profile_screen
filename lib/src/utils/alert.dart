import 'package:profile_screen/src/utils/export.dart';

extension ScaffoldMessanger on BuildContext {
  showSnackBar(SnackBar? snackbar) {
    return ScaffoldMessenger.of(this).showSnackBar(snackbar!);
  }
}
