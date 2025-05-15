//
//  AppDelegate.m
//  TRTCSimpleDemo-OC
//
//  Created by dangjiahe on 2021/4/10.
//  Copyright (c) 2021 Tencent. All rights reserved.
//

#import "AppDelegate.h"
//todo --- facebeauty start0 ---
#import <FaceBeauty/FaceBeautyInterface.h>
//todo --- facebeauty end ---
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [V2TXLivePremier setLicence:LICENSEURL key:LICENSEURLKEY];
    
    //todo --- facebeauty start1 ---

    // 本地资源文件拷贝至沙盒路径
    BOOL isResourceCopied = NO;
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"FaceBeauty" ofType:@"bundle"];

    NSArray *libraryPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    if (libraryPaths.count > 0) {
        NSString *libraryDirectory = [libraryPaths lastObject];
        NSString *sandboxPath = [libraryDirectory stringByAppendingPathComponent:@"FaceBeauty"];
        isResourceCopied = [[FaceBeauty shareInstance] copyResourceBundle:bundlePath toSandbox:sandboxPath];
    }

    NSString *version = [[FaceBeauty shareInstance] getVersion];
    NSLog(@"当前FaceBeauty版本 %@", version ?: @"");

    //    # error 需要FaceBeauty appid，与包名应用名绑定，请联系商务获取
    if (isResourceCopied) {
        [[FaceBeauty shareInstance] initFaceBeauty:@"YOUR_APP_ID" withDelegate:nil];
    }
    //todo --- facebeauty end ---
    
    return YES;
}


@end
