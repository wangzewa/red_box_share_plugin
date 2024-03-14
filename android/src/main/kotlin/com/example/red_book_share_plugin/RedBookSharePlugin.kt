package com.example.red_book_share_plugin

import android.content.Context
import android.util.Log
import androidx.annotation.Nullable
import com.xingin.xhssharesdk.XhsShareSdkTools
import com.xingin.xhssharesdk.callback.XhsShareCallback
import com.xingin.xhssharesdk.callback.XhsShareRegisterCallback
import com.xingin.xhssharesdk.core.XhsShareSdk
import com.xingin.xhssharesdk.model.config.XhsShareGlobalConfig
import com.xingin.xhssharesdk.model.other.VersionCheckResult
import com.xingin.xhssharesdk.model.sharedata.XhsImageInfo
import com.xingin.xhssharesdk.model.sharedata.XhsImageResourceBean
import com.xingin.xhssharesdk.model.sharedata.XhsNote
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** RedBookSharePlugin */
class RedBookSharePlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var mContext: Context

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "red_book_share_plugin")
    mContext = flutterPluginBinding.applicationContext
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "init") {
      init(call.argument("appKey"),call,result)
    } else if (call.method == "judgeShare") {
      val judgeData = judgeShare()
      result.success(judgeData.checkResultCode)
    }else if (call.method == "redShare") {
      share(call.argument("title"),call.argument("des"),call.argument("url"))
      result.success(true)
    }else {
      result.notImplemented()
    }
  }

  private fun init(appkey:String?,call: MethodCall, result: Result){
    /**
     * 初始化 SDK
     */
    XhsShareSdk.registerApp(mContext, appkey,
      XhsShareGlobalConfig().setEnableLog(true).setClearCacheWhenShareComplete(true),
      object : XhsShareRegisterCallback {
        override fun onSuccess() {
          Log.i("xhs", "onSuccess: 注册成功！")
          result.success(true)
          callback()
        }

        override fun onError(
          errorCode: Int,
          errorMessage: String,
          @Nullable exception: Exception?
        ) {
          Log.i(
            "xhs",
            "onError: 注册失败！errorCode: $errorCode errorMessage: $errorMessage exception: $exception"
          )
          result.success(false)
        }
      })
  }

  private fun callback(){
    XhsShareSdk.setShareCallback(object : XhsShareCallback {
      override fun onSuccess(sessionId: String?) {
        Log.i("xhs", "onSuccess: 分享成功！！！")
        channel.invokeMethod("onMessage", true)
      }

      // 1.1.0 版本之后废弃
      override fun onError(
        sessionId: String,
        errorCode: Int,
        errorMessage: String,
        throwable: Throwable?
      ) {
        Log.i(
          "xhs",
          "onError: 分享失败!! $sessionId $errorCode $errorMessage $throwable"
        )
      }

      // 1.1.0 版本后提供的新错误回调，内含新的错误码
      override fun onError2(
        sessionId: String,
        newErrorCode: Int,
        oldErrorCode: Int,
        errorMessage: String,
        throwable: Throwable?
      ) {
        Log.i(
          "xhs",
          "onError: 分享失败!! $sessionId $newErrorCode $oldErrorCode $errorMessage $throwable"
        )
      }

    })
  }

  private fun callBackCancel(){
    XhsShareSdk.setShareCallback(null)
  }
  private fun judgeInstall ():Boolean{
    return  XhsShareSdkTools.isXhsInstalled(mContext)
  }

  private fun judgeShare (): VersionCheckResult {
    val data = XhsShareSdkTools.isSupportShareNote(mContext)
//    if(data.checkResultCode == 0){
//      share("给你看看我画的美图","一个小女孩在这里哭","https://idotdesign.oss-cn-beijing.aliyuncs.com/ai_template/1750017280757043202.webp")
//    }
    return  data
  }
  private fun share (titles:String?,contents:String?,url:String?) {
    val note = XhsNote().apply {
      title = titles  // 正文，String
      content = contents  // 标题，String
      imageInfo = XhsImageInfo(listOf(
        XhsImageResourceBean.fromUrl(url)))
    }
    val sessionId = XhsShareSdk.shareNote(mContext, note)
    Log.i(
      "xhs",
      "----sessionId---$sessionId"
    )
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    Log.i(
      "xhs",
      "cancel: 取消绑定"
    )
    callBackCancel()
    channel.setMethodCallHandler(null)
  }
}
