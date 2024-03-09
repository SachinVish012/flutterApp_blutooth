import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../data/api_network.dart';
import '../res/api_url/api_url.dart';

class RandomDogIMGProvider with ChangeNotifier{
  String _dogImage="";
  String get dogImage=>_dogImage;
  NetworkApiServices _api=NetworkApiServices();

  Future<void> getImage() async {
    await EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.black,
    );
    _api.getApi(APIURL.randomDogImg).then((value) async {
      await EasyLoading.dismiss();
      print(value.toString());
      if(value["status"]=="success")
        {
          print("true");
          var msg=value["message"];
          _dogImage=msg;
          notifyListeners();
        }
      else
        {
          print("Data Not Found");
        }
    }).timeout(Duration(seconds: 120),
        onTimeout: () async {
          await EasyLoading.dismiss();
          print("TimeOut");
        }).onError((error, stackTrace) async
    {
      await EasyLoading.dismiss();
      print("Something Went Wrong");
    });
  }
}