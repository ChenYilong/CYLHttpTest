//
//  ViewController.m
//  CYLHttpTest
//
//  Created by chenyilong on 15/4/7.
//  Copyright (c) 2015年 chenyilong. All rights reserved.
//

#import "ViewController.h"
#import "CYLHttpTool.h"
#import "CYLHttpTestTool.h"
#import "CYLHttpTestParam.h"

@interface ViewController ()

@end

@implementation ViewController


- (IBAction)requestButtonClicked:(id)sender {
    
    CYLHttpTestParam *param = [[CYLHttpTestParam alloc] init];
    param.hospitalName = @"111";
    [CYLHttpTestTool operateNetHttpTestWithParam:param success:^(CYLHttpTestResult *result) {
        NSLog(@"✅✅✅✅✅✅✅%@",result);
    } failure:^(NSError *error) {
        NSLog(@"‼️‼️‼️‼️‼️%@",error);
    }];
}

@end
