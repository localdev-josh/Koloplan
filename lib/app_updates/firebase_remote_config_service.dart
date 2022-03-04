
import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:koloplan/app_updates/models/app_update_config.dart';

class FirebaseRemoteConfigService{
   static const String _APPUPDATEKEY = "app_update";
   RemoteConfig _remoteConfig;

   // This must be called first
   Future<void> init()async{
    _remoteConfig =  await RemoteConfig.instance;
    await _remoteConfig.fetch(expiration: const Duration(seconds: 60));
    await _remoteConfig.activateFetched();

   }

   AppUpdateConfig fetchAppUpdate(){
     try{
       final value =  _remoteConfig.getString(_APPUPDATEKEY);
       final decodedValue = jsonDecode(value) as Map<String,dynamic>;
       return AppUpdateConfig.fromJson(decodedValue);
     }catch(error){
       return null;
     }
   }

}