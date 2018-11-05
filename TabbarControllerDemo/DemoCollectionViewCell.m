//
//  DemoCollectionViewCell.m
//  TabbarControllerDemo
//
//  Created by jecansoft on 16/1/6.
//  Copyright © 2016年 jecansoft. All rights reserved.
//

#import "DemoCollectionViewCell.h"

@implementation DemoCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"..................");
        self.userInteractionEnabled = YES;
        UILongPressGestureRecognizer* longProgress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(startToMoveItem:)];
        [self addGestureRecognizer:longProgress];
    }
    return self;
}

-(void)startToMoveItem:(UILongPressGestureRecognizer*)press{
    if (press.state == UIGestureRecognizerStateBegan) {
        [self.delegate moveWithCell:self];
    }else if (press.state == UIGestureRecognizerStateChanged){
        [self.delegate updateWithGesture:press];
    }else if (press.state == UIGestureRecognizerStateEnded){
        [self.delegate end];
    }
}

@end
