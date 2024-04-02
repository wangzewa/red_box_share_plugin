
import 'red_book_share_plugin_platform_interface.dart';

class RedBookSharePlugin {
  Future<bool?> init(String appKey,{String universalLink = ''}) {
    return RedBookSharePluginPlatform.instance.init(appKey: appKey,universalLink: universalLink);
  }
  Future<int?> judgeShare() {
    return RedBookSharePluginPlatform.instance.judgeShare();
  }
  Future<bool?> share({required String title,required String des,required String url}) {
    return RedBookSharePluginPlatform.instance.share(title: title, des: des, url: url);
  }
  Future<bool?> shareVideo({required String title,required String des,required String url,required String poster}) {
    return RedBookSharePluginPlatform.instance.shareVideo(title: title, des: des, url: url,poster:poster);
  }
}
