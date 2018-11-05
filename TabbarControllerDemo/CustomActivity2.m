//
//  CustomActivity2.m
//  TabbarControllerDemo
//
//  Created by jecansoft on 15/11/21.
//  Copyright © 2015年 jecansoft. All rights reserved.
//

#import "CustomActivity2.h"

@implementation CustomActivity2

- (UIImage *)activityImage
{
    return [UIImage imageNamed:@"美酒--当前"];
}

- (NSString *)activityTitle
{
    return @"微信朋友圈";
}

+ (UIActivityCategory)activityCategory
{
    return UIActivityCategoryShare;
}

- (NSString *)activityType
{
    return NSStringFromClass([self class]);
}

//指明了我们的应用能否对数据源数组作出回应
- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    NSLog(@"%@",activityItems);
    for (id activityItem in activityItems) {
        if ([activityItem isKindOfClass:[UIImage class]]) {
            return YES;
        }
        if ([activityItem isKindOfClass:[NSURL class]]) {
            return YES;
        }
    }
    return NO;
}

//这是在回应点击消息前的一些准备，譬如你要处理下数据，再做反应。这时候可以把关键的数据存起来
- (void)prepareWithActivityItems:(NSArray *)activityItems
{
    NSLog(@"asdasdasd");
    for (id activityItem in activityItems) {
        if ([activityItem isKindOfClass:[UIImage class]]) {
            
        }
        if ([activityItem isKindOfClass:[NSURL class]]) {
            //            url = activityItem;
        }
        if ([activityItem isKindOfClass:[NSString class]]) {
            //            title = activityItem;
        }
    }
}

//这时候就真的进行回应了。
-(void)prepareForInterfaceBuilder{
    NSLog(@"prepareForInterfaceBuilder");
}

//程序回应之后
- (void)activityDidFinish:(BOOL)completed{
    NSLog(@"activityDidFinish");
}

@end
