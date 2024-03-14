import 'package:flutter_test/flutter_test.dart';
import 'package:red_book_share_plugin/red_book_share_plugin.dart';
import 'package:red_book_share_plugin/red_book_share_plugin_platform_interface.dart';
import 'package:red_book_share_plugin/red_book_share_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockRedBookSharePluginPlatform
    with MockPlatformInterfaceMixin
    implements RedBookSharePluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final RedBookSharePluginPlatform initialPlatform = RedBookSharePluginPlatform.instance;

  test('$MethodChannelRedBookSharePlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelRedBookSharePlugin>());
  });

  test('getPlatformVersion', () async {
    RedBookSharePlugin redBookSharePlugin = RedBookSharePlugin();
    MockRedBookSharePluginPlatform fakePlatform = MockRedBookSharePluginPlatform();
    RedBookSharePluginPlatform.instance = fakePlatform;

    expect(await redBookSharePlugin.getPlatformVersion(), '42');
  });
}
