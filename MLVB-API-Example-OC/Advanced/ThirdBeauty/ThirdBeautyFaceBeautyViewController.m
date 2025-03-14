//
//  ThirdBeautyViewController.m
//  MLVB-API-Example-OC
//
//  Created by adams on 2021/4/22.
//

/*
 第三方美颜功能示例
 MLVB APP 支持第三方美颜功能
 本文件展示如何集成第三方美颜功能
 1、打开扬声器 API:[self.livePusher startMicrophone];
 2、打开摄像头 API: [self.livePusher startCamera:true];
 3、开始推流 API：[self.livePusher startPush:url];
 4、开启自定义视频处理 API: [self.livePusher enableCustomVideoProcess:true pixelFormat:V2TXLivePixelFormatNV12 bufferType:V2TXLiveBufferTypePixelBuffer];
 5、使用第三方美颜SDK<Demo中使用的是FaceBeauty美颜>;

 参考文档：https://cloud.tencent.com/document/product/647/34066
 第三方美颜：https://github.com/FaceBeauty/FBTXLiteAVDemo_iOS
 */
/*
 Third-Party Beauty Filter Example
 The MLVB app supports third-party beauty filters.
 This document shows how to integrate third-party beauty filters.
 1. Turn speaker on: [self.livePusher startMicrophone]
 2. Turn camera on: [self.livePusher startCamera:true]
 3. Start publishing: [self.livePusher startPush:url]
 4. Enable custom video processing: [self.livePusher enableCustomVideoProcess:true pixelFormat:V2TXLivePixelFormatNV12 bufferType:V2TXLiveBufferTypePixelBuffer]
 5. Use a third-party beauty filter SDK (MtBeauty is used in the demo)

 Documentation: https://cloud.tencent.com/document/product/647/34066
 Third-party beauty filter: https://github.com/FaceBeauty/FBTXLiteAVDemo_iOS
 */

#import "ThirdBeautyFaceBeautyViewController.h"

//todo --- facebeauty start2 ---
#import "FBUIManager.h"
#import <FaceBeauty/FaceBeautyInterface.h>
bool is_Mirror = true;
//todo --- facebeauty end ---

@interface ThirdBeautyFaceBeautyViewController () <V2TXLivePusherObserver>

@property (weak, nonatomic) IBOutlet UILabel *streamIdLabel;
@property (weak, nonatomic) IBOutlet UITextField *streamIdTextField;

@property (weak, nonatomic) IBOutlet UIButton *startPushStreamButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

@property (strong, nonatomic) V2TXLivePusher *livePusher;

@property (nonatomic, assign) BOOL isRenderInit;
@property (weak, nonatomic) IBOutlet UIButton *beautyButton;

@end

@implementation ThirdBeautyFaceBeautyViewController

- (V2TXLivePusher *)livePusher {
    if (!_livePusher) {
        _livePusher = [[V2TXLivePusher alloc] initWithLiveMode:V2TXLiveMode_RTC];
        [_livePusher setObserver:self];
    }
    return _livePusher;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.beautyButton setTitle:@"" forState:UIControlStateNormal];
    [self setupDefaultUIConfig];
    [self addKeyboardObserver];
    //todo --- facebeauty start3 ---
    [[FBUIManager shareManager] loadToWindowDelegate:nil];
    //todo --- facebeauty end ---
    
    [self.livePusher setRenderView:self.view];
    [self.livePusher startCamera:true];
    [self.livePusher startMicrophone];
    
    //todo --- facebeauty start4 ---
    [self.livePusher enableCustomVideoProcess:true pixelFormat:V2TXLivePixelFormatTexture2D bufferType:V2TXLiveBufferTypeTexture];
    //todo --- facebeauty end ---
    
//    [self.livePusher startCamera:true];
//    [self startPush:self.streamIdTextField.text];
}

- (void)setupDefaultUIConfig {
    self.streamIdTextField.text = [NSString generateRandomStreamId];
    
    self.streamIdLabel.text = localize(@"MLVB-API-Example.ThirdBeauty.streamIdInput");
    self.streamIdLabel.adjustsFontSizeToFitWidth = true;
    
    self.startPushStreamButton.backgroundColor = [UIColor themeBlueColor];
    [self.startPushStreamButton setTitle:localize(@"MLVB-API-Example.ThirdBeauty.startPush") forState:UIControlStateNormal];
    [self.startPushStreamButton setTitle:localize(@"MLVB-API-Example.ThirdBeauty.stopPush") forState:UIControlStateSelected];
}

- (void)startPush:(NSString*)streamId {
    self.title = streamId;
    [self.livePusher setRenderView:self.view];
    [self.livePusher startCamera:true];
    [self.livePusher startMicrophone];
    
//    //todo --- facebeauty start2 ---
//    [self.livePusher enableCustomVideoProcess:true pixelFormat:V2TXLivePixelFormatNV12 bufferType:V2TXLiveBufferTypePixelBuffer];
//    //todo --- facebeauty end ---

//    [self.livePusher startPush:[URLUtils generateTRTCPushUrl:streamId]];
}

- (void)stopPush {
    [self.livePusher stopCamera];
    [self.livePusher stopMicrophone];
    [self.livePusher stopPush];
}

#pragma mark - IBActions
- (IBAction)onPushStreamClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self startPush:self.streamIdTextField.text];
    } else {
        [self stopPush];
    }
}

- (IBAction)openBeauty:(UIButton *)sender {
    [[FBUIManager shareManager] showBeautyView];
}





#pragma mark - V2TXLivePusherObserver
- (void)onProcessVideoFrame:(V2TXLiveVideoFrame *)srcFrame dstFrame:(V2TXLiveVideoFrame *)dstFrame {
    
    //todo --- facebeauty start5 ---
    if (!_isRenderInit) {
        [[FaceBeauty shareInstance] releaseTextureRenderer];
        _isRenderInit = [[FaceBeauty shareInstance] initTextureRenderer:(int)srcFrame.width height:(int)srcFrame.height rotation:FBRotationClockwise0 isMirror:YES maxFaces:5];
    }
    GLuint dstTextureId = [[FaceBeauty shareInstance] processTexture:srcFrame.textureId];
    dstFrame.textureId = dstTextureId;
    //todo --- facebeauty end ---
 
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:true];
}

- (void)dealloc {
    //todo --- facebeauty start6 ---
    [[FaceBeauty shareInstance] releaseTextureRenderer];
    [[FBUIManager shareManager] destroy];
    //todo --- facebeauty end ---
    [self removeKeyboardObserver];
}

#pragma mark - Notification
- (void)addKeyboardObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)removeKeyboardObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (BOOL)keyboardWillShow:(NSNotification *)noti {
    CGFloat animationDuration = [[[noti userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect keyboardBounds = [[[noti userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:animationDuration animations:^{
        self.bottomConstraint.constant = keyboardBounds.size.height;
    }];
    return YES;
}

- (BOOL)keyboardWillHide:(NSNotification *)noti {
     CGFloat animationDuration = [[[noti userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
     [UIView animateWithDuration:animationDuration animations:^{
         self.bottomConstraint.constant = 25;
     }];
     return YES;
}

@end
