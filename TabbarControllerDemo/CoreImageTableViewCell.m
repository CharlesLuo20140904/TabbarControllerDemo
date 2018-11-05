//
//  CoreImageTableViewCell.m
//  TabbarControllerDemo
//
//  Created by jecansoft on 15/11/24.
//  Copyright © 2015年 jecansoft. All rights reserved.
//

#import "CoreImageTableViewCell.h"
#import <CoreImage/CoreImage.h>
#import <SVProgressHUD.h>

@interface CoreImageTableViewCell ()
{
    CIContext* context;
    CIFilter* filter;
    CIImage* cimg;
}
@end

@implementation CoreImageTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{\
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSString * imagePath = [[NSBundle mainBundle] pathForResource:@"coreImageTest" ofType:@"jpg"];
        UIImage * image = [UIImage imageWithContentsOfFile:imagePath];
        CGFloat imgH = ScreenWith/image.size.width*image.size.height;
        self.coreimageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, ScreenWith, imgH)];
        self.coreimageView.image = image;
        [self.contentView addSubview:self.coreimageView];
        self.slider = [[UISlider alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(self.coreimageView.frame), ScreenWith, 30.0f)];
        self.slider.value = 0.0f;
        [self.slider addTarget:self action:@selector(showValue:) forControlEvents:UIControlEventValueChanged];
        self.slider.maximumValue = 1;
        self.slider.continuous = NO;
        self.slider.minimumValue = 0.0f;
        [self.contentView addSubview:self.slider];
        cimg = [CIImage imageWithContentsOfURL:[NSURL fileURLWithPath:imagePath]];
        context = [CIContext contextWithOptions:nil];

    }
    return self;
}

//+ (void)setMinimumSize:(CGSize)minimumSize;                         // default is CGSizeZero, can be used to avoid resizing for a larger message
//+ (void)setRingThickness:(CGFloat)ringThickness;                    // default is 2 pt
//+ (void)setRingRadius:(CGFloat)radius;                              // default is 18 pt
//+ (void)setRingNoTextRadius:(CGFloat)radius;                        // default is 24 pt
//+ (void)setCornerRadius:(CGFloat)cornerRadius;
//@property (strong, nonatomic) UIColor *backgroundColor UI_APPEARANCE_SELECTOR;  // default is [UIColor whiteColor]
//@property (strong, nonatomic) UIColor *foregroundColor UI_APPEARANCE_SELEC

-(void)showValue:(UISlider*)slider{
//    [SVProgressHUD setRingNoTextRadius:20.0f];
//    [SVProgressHUD setRingThickness:30];
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
//    [SVProgressHUD setBackgroundColor:[UIColor redColor]];
//    [SVProgressHUD setForegroundColor:[UIColor greenColor]];
//    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        float slideValue = slider.value;
//        [filter setValue:@(slideValue) forKey:@"inputIntensity"];
        CIImage *outputImage = [filter outputImage];
        CGImageRef cgimg = [context createCGImage:outputImage
                                         fromRect:[outputImage extent]];
        UIImage *newImage = [UIImage imageWithCGImage:cgimg];
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            self.coreimageView.image = newImage;
            CGImageRelease(cgimg);
        });
    });
}

-(void)setFilterName:(NSString *)filterName{
    filter = [CIFilter filterWithName:filterName];
    [filter setValue:cimg forKey:kCIInputImageKey];
//    [filter setValue:@0.0f forKey:@"inputIntensity"];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
