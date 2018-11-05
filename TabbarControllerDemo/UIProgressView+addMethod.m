//
//  UIProgressView+addMethod.m
//  TabbarControllerDemo
//
//  Created by jecansoft on 15/11/9.
//  Copyright © 2015年 jecansoft. All rights reserved.
//

#import "UIProgressView+addMethod.h"

@implementation UIProgressView (addMethod)
-(void)incrementBy:(NSInteger)index{
    self.progress = index/10.0f;
}
@end
