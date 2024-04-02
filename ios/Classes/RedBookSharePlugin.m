#import "RedBookSharePlugin.h"


@implementation RedBookSharePlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"red_book_share_plugin"
            binaryMessenger:[registrar messenger]];
  RedBookSharePlugin* instance = [[RedBookSharePlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"init" isEqualToString:call.method]) {
    NSDictionary* arguments = (NSDictionary *)call.arguments;
    NSString* appKey = [arguments valueForKey:@"appKey"];
    NSString* link = [arguments valueForKey:@"universalLink"];
    BOOL init = [XHSApi registerApp:appKey universalLink:link delegate:self];
    result(@(init));
  } else if ([@"judgeShare" isEqualToString:call.method]) {
    BOOL isI = [XHSApi isXHSAppInstalled];
    if(isI){
      result(@0);
    }else{
      result(@1);
    }
  }else if ([@"redShare" isEqualToString:call.method]) {
    NSDictionary* arguments = (NSDictionary *)call.arguments;
    NSString* title = [arguments valueForKey:@"title"];
    NSString* des = [arguments valueForKey:@"des"];
    NSString* url = [arguments valueForKey:@"url"];
    dispatch_async(dispatch_get_main_queue(), ^{
        XHSOpenSDKShareRequest *shareRequest = [[XHSOpenSDKShareRequest alloc] init];
        shareRequest.mediaType = XHSOpenSDKShareMediaTypeImage;
        NSMutableArray<XHSShareInfoImageItem *> *imageResources = [NSMutableArray array];
        XHSShareInfoImageItem *imageObject = [[XHSShareInfoImageItem alloc] init];
        /// 图片远程url 或者本地沙盒路径
        imageObject.imageUrl = url;

        XHSShareInfoTextContentItem * textItem = [[XHSShareInfoTextContentItem alloc]init];
        textItem.title = title;
        textItem.content = des;
        [imageResources addObject:imageObject];
        shareRequest.textContentItem = textItem;
        shareRequest.imageInfoItems = imageResources;
        [XHSApi sendRequest:shareRequest completion:^(BOOL success) {
            result(@(success));
        }];

    });
  }else if ([@"redShareVideo" isEqualToString:call.method]) {
    NSDictionary* arguments = (NSDictionary *)call.arguments;
    NSString* title = [arguments valueForKey:@"title"];
    NSString* des = [arguments valueForKey:@"des"];
    NSString* url = [arguments valueForKey:@"url"];
    NSString* poster = [arguments valueForKey:@"poster"];
    dispatch_async(dispatch_get_main_queue(), ^{
        XHSOpenSDKShareRequest *shareRequest = [[XHSOpenSDKShareRequest alloc] init];
        shareRequest.mediaType = XHSOpenSDKShareMediaTypeVideo;

        /// 视频
        NSMutableArray<XHSShareInfoVideoItem *> *videoResources = [NSMutableArray array];

        XHSShareInfoVideoItem *videoObject = [[XHSShareInfoVideoItem alloc] init];
        /// 视频
        videoObject.videoUrl = url;
        /// 视频封面
        videoObject.coverUrl = poster;
        XHSShareInfoTextContentItem *messageObject = [[XHSShareInfoTextContentItem alloc] init];
        messageObject.title = title;
        messageObject.content = des;

        [videoResources addObject:videoObject];
        shareRequest.videoInofoItems = videoResources;
        shareRequest.textContentItem = messageObject;
        [XHSApi sendRequest:shareRequest completion:^(BOOL success) {
            result(@(success));
        }];

    });
  }else{
    result(FlutterMethodNotImplemented);
  }
}

@end
