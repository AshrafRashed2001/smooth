import 'package:firebase_auth/firebase_auth.dart';

import '../SharedPref/shared_helper.dart';

class CachHelper {
  static void setCach({
    required String name,
    required String email,
    required String userUid,
  }) {
    SharedHelper.setstring(key: 'USER_UID', value: userUid);
    SharedHelper.setstring(key: 'NAME', value: name);
    SharedHelper.setstring(key: 'EMAIL', value: email);
  }

  static void clearCach() async {
    SharedHelper.removedata(key: 'USER_UID');
    SharedHelper.removedata(key: 'NAME');
    SharedHelper.removedata(key: 'EMAIL');
    await FirebaseAuth.instance.signOut();
  }
}
