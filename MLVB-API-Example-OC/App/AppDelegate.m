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
    # error 需要FaceBeauty appid，与包名应用名绑定，请联系商务获取
    [[FaceBeauty shareInstance] initFaceBeauty:@"YOUR_APP_ID" withDelegate:nil];
    //todo --- facebeauty end ---
    
    return YES;
}


@end
