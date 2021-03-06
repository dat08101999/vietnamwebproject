import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intent/intent.dart' as android_intent;
// import 'package:intent/extra.dart' as android_extra;
// import 'package:intent/typedExtra.dart' as android_typedExtra;
import 'package:intent/action.dart' as android_action;

class AcctionSystem {
  static sendMessage({@required String text, @required String phoneNumber}) {
    final Uri _sendSMS =
        Uri(scheme: 'sms', path: phoneNumber, queryParameters: {'body': text});
    launch(_sendSMS.toString());
  }

  static sendEmail(
      {@required String subject,
      @required String text,
      @required String email}) {
    final Uri _emailLaunchUri = Uri(
        scheme: 'mailto',
        path: email,
        queryParameters: {'subject': subject, 'text': text});
    launch(_emailLaunchUri.toString());
  }

  static call({@required String phoneNumber}) {
    final Uri _call = Uri(scheme: 'tel', path: phoneNumber);
    launch(_call.toString());
  }

  static callOnlyAndroid({@required String phoneNumber}) async {
    final permisson = await CallPemission.getPemission(Permission.phone);
    switch (permisson) {
      case PermissionStatus.granted:
        android_intent.Intent()
          ..setAction(android_action.Action.ACTION_CALL)
          ..setData(Uri(scheme: 'tel', path: phoneNumber))
          ..startActivity().catchError((e) => print(e));
        break;
      case PermissionStatus.permanentlyDenied:
        print('permanentlyDenied');
        break;
      default:
        print('default');
        break;
    }
    android_intent.Intent()
      ..setAction(android_action.Action.ACTION_CALL)
      ..setData(Uri(scheme: 'tel', path: phoneNumber))
      ..startActivity().catchError((e) => print(e));
  }
}

class CallPemission {
  /// * Kiểm tra quyền Gọi Điện và yêu cầu cấp quyền
  static Future<PermissionStatus> getPemission(
      PermissionWithService permissionNow) async {
    final permission = await permissionNow.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      final newPermission = await Permission.phone.request();
      return newPermission;
    }
    return permission;
  }
}
