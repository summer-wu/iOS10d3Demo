//
//  ViewController.m
//  iOS10d3Demo
//
//  Created by n on 2017/2/8.
//  Copyright © 2017年 summerwuOrganization. All rights reserved.
//

#import "ViewController.h"
#import <StoreKit/StoreKit.h>
#import <UserNotifications/UserNotifications.h>

@interface ViewController ()
@property (nonatomic,strong) UIButton *changeIconBtn1;
@property (nonatomic,strong) UIButton *changeIconBtn2;
@property (nonatomic,strong) UIButton *reviewBtn;
@property (nonatomic,strong) UIButton *settingsBtn;
@property (nonatomic,strong) UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:UNAuthorizationOptionBadge completionHandler:^(BOOL granted, NSError * _Nullable error) {
    }];//in order to see appicon in Settings.app
    [self.view addSubview:self.changeIconBtn1];
    [self.view addSubview:self.changeIconBtn2];
    [self.view addSubview:self.reviewBtn];
    [self.view addSubview:self.settingsBtn];
    [self.view addSubview:self.label];
    [self updateLabel];
}



- (UIButton *)changeIconBtn1{
    if (!_changeIconBtn1) {
        UIButton *b = _changeIconBtn1 = [UIButton buttonWithType:UIButtonTypeSystem];
        [b setTitle:@"change to default AppIcon" forState:UIControlStateNormal];
        [self.class changeViewOriginToX:10 y:40 view:b];
        [b sizeToFit];
        [b addTarget:self action:@selector(changeIconBtn1Action) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changeIconBtn1;
}
- (void)changeIconBtn1Action{
    UIApplication *app = [UIApplication sharedApplication];
    if ([app supportsAlternateIcons]) {
        [app setAlternateIconName:nil completionHandler:^(NSError * _Nullable error) {
            if (error) {NSLog(@"%@",error);}
            dispatch_async(dispatch_get_main_queue(), ^{
                [self updateLabel];
            });
        }];
    }
}
- (UIButton *)changeIconBtn2{
    if (!_changeIconBtn2) {
        UIButton *b = _changeIconBtn2 = [UIButton buttonWithType:UIButtonTypeSystem];
        [b setTitle:@"change to AppIcon2" forState:UIControlStateNormal];
        [self.class changeViewOriginToX:10 y:80 view:b];
        [b sizeToFit];
        [b addTarget:self action:@selector(changeIconBtn2Action) forControlEvents:UIControlEventTouchUpInside];

    }
    return _changeIconBtn2;
}
- (void)changeIconBtn2Action{
    UIApplication *app = [UIApplication sharedApplication];
    if ([app supportsAlternateIcons]) {
        [app setAlternateIconName:@"AppIcon2" completionHandler:^(NSError * _Nullable error) {
            if (error) {NSLog(@"%@",error);}
            dispatch_async(dispatch_get_main_queue(), ^{
                [self updateLabel];
            });
        }];
    }
}
- (UIButton *)reviewBtn{
    if (!_reviewBtn) {
        UIButton *b = _reviewBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [b setTitle:@"show SKStoreReviewController" forState:UIControlStateNormal];
        [self.class changeViewOriginToX:10 y:120 view:b];
        [b sizeToFit];
        [b addTarget:self action:@selector(reviewBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reviewBtn;
}

- (void)reviewBtnAction{
    if ([UIDevice currentDevice].systemVersion.floatValue >= 10.3) {
        [SKStoreReviewController requestReview];
    }
}

-(UIButton *)settingsBtn{
    if (!_settingsBtn) {
        UIButton *b = _settingsBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [b setTitle:@"go to Settings.app(to view appicon)" forState:UIControlStateNormal];
        [self.class changeViewOriginToX:10 y:160 view:b];
        [b sizeToFit];
        [b addTarget:self action:@selector(settingsBtnAction) forControlEvents:UIControlEventTouchUpInside];

    }
    return _settingsBtn;
}
- (void)settingsBtnAction{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}

- (void)updateLabel{
    UIApplication *app = [UIApplication sharedApplication];
    NSString *currentName = app.alternateIconName;
    self.label.text = [NSString stringWithFormat:@"current AppIcon:%@",currentName?:@"<Default AppIcon>"];
    [self.label sizeToFit];
}

- (UILabel *)label{
    if (!_label) {
        _label = [UILabel new];
        [self.class changeViewOriginToX:10 y:200 view:_label];
    }
    return _label;
}

+ (void)changeViewOriginToX:(CGFloat) x y:(CGFloat)y view:(UIView *)v {
    CGRect frame = v.frame;
    CGPoint origin = CGPointMake(x, y);
    frame.origin = origin;
    v.frame = frame;
}

@end
