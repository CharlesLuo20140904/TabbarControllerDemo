//
//  PasteCollectionCell.h
//  TabbarControllerDemo
//
//  Created by jecansoft on 16/1/19.
//  Copyright © 2016年 jecansoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PasteCellDelegate <NSObject>

-(void)showPasteboardMenuForView:(id)view;

@end

@interface PasteCollectionCell : UICollectionViewCell
@property (strong, nonatomic) UIImageView* imageView;
@property (strong, nonatomic) UILabel* nameLabel;
@property (assign, nonatomic) id<PasteCellDelegate>delegate;
@end
