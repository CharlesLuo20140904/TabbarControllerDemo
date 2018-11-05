//
//  DemoCollectionViewCell.h
//  TabbarControllerDemo
//
//  Created by jecansoft on 16/1/6.
//  Copyright © 2016年 jecansoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DemoCellDelegate <NSObject>

-(void)moveWithCell:(id)cell;
-(void)updateWithGesture:(UILongPressGestureRecognizer*)gesture;
-(void)end;

@end

@interface DemoCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) NSArray* array;
@property (assign, nonatomic) id<DemoCellDelegate>delegate;
@end
