//
//  PokeDexNaviController.m
//  Pokédex
//
//  Created by 박종찬 on 2017. 3. 7..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import "PokeDexNaviController.h"

@interface PokeDexNaviController ()

@end

@implementation PokeDexNaviController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setBarTintColor:[UIColor redColor]];
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationBar setTranslucent:YES];
    [self.navigationBar setBarStyle:UIBarStyleBlack];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
