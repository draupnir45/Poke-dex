//
//  AppDelegate.m
//  TabNavAndView
//
//  Created by 박종찬 on 2017. 2. 21..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import "AppDelegate.h"
#import "SettingData.h"
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate ()

@property SettingData *settings;

@end

@implementation AppDelegate



///저장되는 설정을 불러옵니다.
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.settings = [SettingData sharedSettings];
    [self.window setTintColor:[UIColor redColor]];
    
    AVSpeechSynthesizer *speechSynthesizer = [[AVSpeechSynthesizer alloc] init]; //퍼포먼스를 위해 신서사이저를 만들고, 혹시 스피치 중이면 중단시킨다.
    
    if (speechSynthesizer.isSpeaking) {
        [speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    }
    
    return YES;
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    //어플리케이션이 종료되기 전에 설정을 저장해 줍니다.
    [self.settings saveData];
}


@end
