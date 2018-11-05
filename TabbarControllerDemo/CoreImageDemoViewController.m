//
//  CoreImageDemoViewController.m
//  TabbarControllerDemo
//
//  Created by jecansoft on 15/11/21.
//  Copyright © 2015年 jecansoft. All rights reserved.
//

#import "CoreImageDemoViewController.h"
#import <CoreImage/CoreImage.h>
#import "CoreImageTableViewCell.h"

@interface CoreImageDemoViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView * tableView;
@property (strong, nonatomic) NSArray * filterNameArr;
@end

@implementation CoreImageDemoViewController
-(void)viewDidLoad{
    [super viewDidLoad];
//    self.filterNameArr = @[@"CIAdditionCompositing",@"CIAffineClamp",@"CIAffineTile",@"CIAffineTransform",@"CIBarsSwipeTransition",@"CIBlendWithAlphaMask",@"CIBlendWithMask",@"CIBloom",@"CIBumpDisTortion",@"CIBumpDisTortionLinear",@"CICheckerboardGeneraTor",@"CICircleSplashDisTortion",@"CICircularScreen",@"CIColorBlendMode",@"CIColorBurnBlendMode",@"CIColorClamp",@"CIColorControls",@"CIColorCrossPolynomial",@"CIColorCube",@"CIColorCubeWithColorSpace",@"CIColorDodgeBlendMode",@"CIColorInvert",@"CIColorMap",@"CIColorMatrix",@"CIColorMonochrome",@"CIColorPolynomial",@"CIColorPosterize",@"CIConstantColorGeneraTor",@"CIConvolution3X3",@"CIConvolution5X5",@"CIConvolution9Horizontal",@"CIConvolution9Vertical",@"CICopyMachineTransition",@"CICrop",@"CIDarkenBlendMode",@"CIDifferenceBlendMode",@"CIDisintegrateWithMaskTransition",@"CIDissolveTransition",@"CIDotScreen",@"CIEightfoldReflectedTile",@"CIExclusionBlendMode",@"CIExposureAdjust",@"CIFalseColor",@"CIFlashTransition",@"CIFourfoldReflectedTile",@"CIFourfoldRotatedTile",@"CIFourfoldTranslatedTile",@"CIGammaAdjust",@"CIGaussianBlur",@"CIGaussianGradient",@"CIGlideReflectedTile",@"CIGloom",@"CIHardLightBlendMode",@"CIHatchedScreen",@"CIHighlightShadowAdjust",@"CIHoleDisTortion",@"CIHueAdjust",@"CIHueBlendMode",@"CILanczosScaleTransform",@"CILightenBlendMode",@"CILightTunnel",@"CILinearGradient",@"CILinearToSRGBToneCurve",@"CILineScreen",@"CILuminosityBlendMode",@"CIMaskToAlpha",@"CIMaximumComponent",@"CIMaximumCompositing",@"CIMinimumComponent",@"CIMinimumCompositing",@"CIModTransition",@"CIMultiplyBlendMode",@"CIMultiplyCompositing",@"CIOverlayBlendMode",@"CIPhotoEffectChrome",@"CIPhotoEffectFade",@"CIPhotoEffectInstant",@"CIPhotoEffectMono",@"CIPhotoEffectNoir",@"CIPhotoEffectProcess",@"CIPhotoEffectTonal",@"CIPhotoEffectTransfer",@"CIPinchDisTortion",@"CIPixellate",@"CIQRCodeGeneraTor",@"CIRadialGradient",@"CIRandomGeneraTor",@"CISaturationBlendMode",@"CIScreenBlendMode",@"CISepiaTone",@"CISharpenLuminance",@"CISixfoldReflectedTile",@"CISixfoldRotatedTile",@"CISmoothLinearGradient",@"CISoftLightBlendMode",@"CISourceAtopCompositing",@"CISourceInCompositing",@"CISourceOutCompositing",@"CISourceOverCompositing",@"CISRGBToneCurveToLinear",@"CIStarShineGeneraTor",@"CIStraightenFilter",@"CIStripesGeneraTor",@"CISwipeTransition",@"CITemperatureAndTint",@"CIToneCurve",@"CITriangleKaleidoscope",@"CITwelvefoldReflectedTile",@"CITwirlDisTortion",@"CIUnsharpMask",@"CIVibrance",@"CIVignette",@"CIVignetteEffect",@"CIVortexDisTortion",@"CIWhitePointAdjust"];
    self.filterNameArr = @[@"CIPhotoEffectInstant",@"CIPhotoEffectNoir",@"CIPhotoEffectTonal",@"CIPhotoEffectTransfer",@"CIPhotoEffectMono",@"CIPhotoEffectFade",@"CIPhotoEffectProcess",@"CIPhotoEffectChrome"];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 64.0f, ScreenWith, ScreenHeight-64.0f-50.0f)];
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    NSArray *properties = [CIFilter filterNamesInCategory:
//                           kCICategoryBuiltIn];
//    NSLog(@"%@", properties);
//    for (NSString *filterName in properties) {
//        CIFilter *fltr = [CIFilter filterWithName:filterName];
//        NSLog(@"%@", [fltr attributes]);
//    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.filterNameArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * imagePath = [[NSBundle mainBundle] pathForResource:@"coreImageTest" ofType:@"jpg"];
    UIImage * image = [UIImage imageWithContentsOfFile:imagePath];
    CGFloat imgH = ScreenWith/image.size.width*image.size.height;
    return imgH+30.0f;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * identifier = NSStringFromUIOffset(UIOffsetMake(indexPath.section/1.0f, indexPath.row/1.0f));
    CoreImageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CoreImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.filterName = self.filterNameArr[indexPath.row];
    return cell;
}

@end
