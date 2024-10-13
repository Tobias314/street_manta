import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

Future<String> getDeviceModel() async{
    if(Platform.isAndroid){
        return (await DeviceInfoPlugin().androidInfo).model;
    } else if(Platform.isIOS){
        return (await DeviceInfoPlugin().iosInfo).model;
    }
    return 'Unknown';
}