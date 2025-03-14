//
//  ThirdBeautyEntranceViewController.m
//  MLVB-API-Example-OC
//
//  Created by summer on 2022/5/11.
//  Copyright © 2022 Tencent. All rights reserved.
//

#import "ThirdBeautyEntranceViewController.h"
#import "ThirdBeautyTencentEffectViewController.h"
#import "ThirdBeautyFaceBeautyViewController.h"
@interface ThirdBeautyEntranceViewController ()
@property(nonatomic, strong) UIButton *fbeffectButton;
@property(nonatomic, strong) UIButton *xMagicButton;
@end

@implementation ThirdBeautyEntranceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = localize(@"MLVB-API-Example.Home.ThirdBeauty");
    self.view.backgroundColor = [UIColor blackColor];
    [self setupUI];
}

- (void)setupUI{
    self.fbeffectButton.frame = CGRectMake(22,
                                            self.view.frame.size.height * 0.5 - 75, UIScreen.mainScreen.bounds.size.width-44, 50);
    self.xMagicButton.frame = CGRectMake(22,
                                         self.view.frame.size.height * 0.5 + 15, UIScreen.mainScreen.bounds.size.width-44, 50);
    [self.view addSubview:self.fbeffectButton];
    [self.view addSubview:self.xMagicButton];
}

#pragma mark - Touch Event
- (void)clickBeautyButton {
    UIViewController *controller =
    [[ThirdBeautyFaceBeautyViewController alloc] initWithNibName:@"ThirdBeautyFaceBeautyViewController"
                                                         bundle:nil];
    [self.navigationController pushViewController:controller animated:true];
}

- (void)clickBytedButton {
    UIViewController *controller =
    [[ThirdBeautyTencentEffectViewController alloc] initWithNibName:@"ThirdBeautyTencentEffectViewController"
                                                             bundle:nil];
    [self.navigationController pushViewController:controller animated:true];
}

#pragma mark - Gettter
- (UIButton *)fbeffectButton {
    if (!_fbeffectButton) {
        _fbeffectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _fbeffectButton.layer.cornerRadius = 5;
        [_fbeffectButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _fbeffectButton.backgroundColor = [UIColor blueColor];
        [_fbeffectButton setTitle:localize(@"MLVB-API-Example.ThirdBeauty.facebeauty") forState:UIControlStateNormal];
        [_fbeffectButton addTarget:self
                             action:@selector(clickBeautyButton)
                   forControlEvents:UIControlEventTouchUpInside];
    }
    return _fbeffectButton;
}

- (UIButton *)xMagicButton {
    if (!_xMagicButton) {
        _xMagicButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_xMagicButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _xMagicButton.layer.cornerRadius = 5;
        _xMagicButton.backgroundColor = [UIColor blueColor];
        [_xMagicButton setTitle:localize(@"MLVB-API-Example.ThirdBeauty.xmagic") forState:UIControlStateNormal];
        [_xMagicButton addTarget:self
                          action:@selector(clickBytedButton)
                forControlEvents:UIControlEventTouchUpInside];
    }
    return _xMagicButton;
}

@end

