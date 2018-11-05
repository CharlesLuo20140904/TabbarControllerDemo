//
//  CoreImageTableViewCell.h
//  TabbarControllerDemo
//
//  Created by jecansoft on 15/11/24.
//  Copyright © 2015年 jecansoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoreImageTableViewCell : UITableViewCell
@property (strong, nonatomic) UIImageView * coreimageView;
@property (strong, nonatomic) UISlider * slider;
@property (strong, nonatomic) NSString * filterName;
@end
