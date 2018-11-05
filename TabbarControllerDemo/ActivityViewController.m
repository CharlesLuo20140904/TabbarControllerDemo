//
//  ActivityViewController.m
//  TabbarControllerDemo
//
//  Created by jecansoft on 15/11/21.
//  Copyright © 2015年 jecansoft. All rights reserved.
//

#import "ActivityViewController.h"
#import "CustomActivity.h"
#import "CustomActivity2.h"

@implementation ActivityViewController

/******************************
Activity 类型又分为“操作”和“分享”两大类：
UIActivityCategoryAction
1. UIActivityTypePrint
2. UIActivityTypeCopyToPasteboard
3. UIActivityTypeAssignToContact
4. UIActivityTypeSaveToCameraRoll
5. UIActivityTypeAddToReadingList
6. UIActivityTypeAirDrop

UIActivityCategoryShare
1. UIActivityTypeMessage
2. UIActivityTypeMail
3. UIActivityTypePostToFacebook
4. UIActivityTypePostToTwitter
5. UIActivityTypePostToFlickr
6. UIActivityTypePostToVimeo
7. UIActivityTypePostToTencentWeibo
8. UIActivityTypePostToWeibo
*******************************/

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:RANDOM_COLOR];
    [btn addTarget:self action:@selector(showActivityView:) forControlEvents:UIControlEventTouchUpInside];
    [btn setFrame:CGRectMake(0.0f, 0.0f, 80.0f, 80.0f)];
    btn.layer.cornerRadius = 40.0f;
    btn.clipsToBounds = YES;
    btn.center = CGPointMake(ScreenWith/2, ScreenHeight/2);
    [self.view addSubview:btn];
}

-(void)showActivityView:(UIButton*)btn{
    NSString * shareString= @"ios 原生分享嘻嘻嘻嘻";
    UIImage * shareImage = [UIImage imageNamed:@"second_bluetooth"];
    NSURL * shareUrl = [NSURL URLWithString:@"http://www.hao123.com"];
    NSArray * activityItems = @[shareString,shareImage,shareUrl];
    CustomActivity * ct = [[CustomActivity alloc] init];
    CustomActivity2 * ct2 = [[CustomActivity2 alloc] init];
    NSArray * activityArr = @[ct,ct2];
    UIActivityViewController * activityController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:activityArr];
//    activityController.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
    [self presentViewController:activityController animated:TRUE completion:nil];
    
}

@end
