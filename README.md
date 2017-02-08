#README
iOS 10.3 add two highlight features that developers may care. 

1. change app icon
2. in app review

This demo demostrate the two features.Go Directly to `ViewController.m`

##change icon
1 . add CFBundleAlternateIcons and CFBundlePrimaryIcon to info.plist. 

Notice: According to my test,adding CFBundlePrimaryIcon is necessary or icon may mismatch. 
```
<key>CFBundleIcons</key>
<dict>
	<key>CFBundleAlternateIcons</key>
	<dict>
		<key>AppIcon2</key>
		<dict>
			<key>CFBundleIconFiles</key>
			<array>
				<string>AppIcon2</string>
			</array>
			<key>UIPrerenderedIcon</key>
			<false/>
		</dict>
	</dict>
	<key>CFBundlePrimaryIcon</key>
	<dict>
		<key>CFBundleIconFiles</key>
		<array>
			<string>AppIcon60x60</string>
		</array>
	</dict>
</dict>
```
2 . add AppIcon2@2x.png AppIcon2@3x.png to project(not Assets.xcassets)

According to my test,adding to Assets.xcassets leading to no effect.

3 . add code
```
if ([app supportsAlternateIcons]) {
        [app setAlternateIconName:@"AppIcon2" completionHandler:^(NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self updateLabel];
            });
        }];
}
```

##in app review
```
#import <StoreKit/StoreKit.h>
if ([UIDevice currentDevice].systemVersion.floatValue >= 10.3) {
    [SKStoreReviewController requestReview];
}
```


#refrence

https://forums.developer.apple.com/message/207848#207848
https://developer.apple.com/library/prerelease/content/documentation/General/Reference/InfoPlistKeyReference/Articles/CoreFoundationKeys.html#//apple_ref/doc/uid/TP40009249-SW14
https://github.com/steventroughtonsmith/AlternateIconTest


