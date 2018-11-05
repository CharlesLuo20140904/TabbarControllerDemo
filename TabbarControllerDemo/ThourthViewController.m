//
//  ThourthViewController.m
//  TabbarControllerDemo
//
//  Created by jecansoft on 15/8/21.
//  Copyright (c) 2015年 jecansoft. All rights reserved.
//

#import "ThourthViewController.h"
#import <GLKit/GLKit.h>

#define LIGHT_DIRECTION 0, 1, -0.5
#define AMBIENT_LIGHT 0.5


const static CGFloat RectWidth = 200.0f;
const static CGFloat LageRectWidth = 2000.0f;

@interface ThourthViewController ()
@property (strong, nonatomic) UIImageView * imageView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) NSMutableArray *faces;
@property (assign, nonatomic) NSInteger j;
@end

@implementation ThourthViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.j=0;
        self.faces = [NSMutableArray array];
        self.containerView = [[UIView alloc] initWithFrame:self.view.bounds];
//        self.containerView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.containerView];
        for (int i=0; i<6; i++) {
            self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, RectWidth, RectWidth)];
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, RectWidth/2, RectWidth, 25.0f)];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:15];
            label.text = [NSString stringWithFormat:@"%i",i];
            [self.imageView addSubview:label];
            self.imageView.backgroundColor = RANDOM_COLOR;
            [self.faces addObject:self.imageView];
        }
//        CGAffineTransform transform = CGAffineTransformIdentity;
//        transform.c = -1;
//        transform.b = 0;
        CATransform3D perspective = CATransform3DIdentity;
        perspective.m34 = -0.8 / 500.0;
        perspective = CATransform3DRotate(perspective, -M_PI_4, 1, 0, 0);
        perspective = CATransform3DRotate(perspective, -M_PI_4, 0, 1, 0);
        self.containerView.layer.sublayerTransform = perspective;
        CATransform3D transform = CATransform3DMakeTranslation(0, 0, LageRectWidth);
        [self addFace:0 withTransform:transform];
        transform = CATransform3DMakeTranslation(LageRectWidth, 0, 0);
        transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
        [self addFace:1 withTransform:transform];
        transform = CATransform3DMakeTranslation(0, -LageRectWidth, 0);
        transform = CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
        [self addFace:2 withTransform:transform];
        transform = CATransform3DMakeTranslation(0, LageRectWidth, 0);
        transform = CATransform3DRotate(transform, -M_PI_2, 1, 0, 0);
        [self addFace:3 withTransform:transform];
        transform = CATransform3DMakeTranslation(-LageRectWidth, 0, 0);
        transform = CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
        [self addFace:4 withTransform:transform];
        transform = CATransform3DMakeTranslation(0, 0, -LageRectWidth);
        transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);
        [self addFace:5 withTransform:transform];
        
    }
    return self;
}

- (void)applyLightingToFace:(CALayer *)face
{
    //add lighting layer
    CALayer *layer = [CALayer layer];
    layer.frame = face.bounds;
    [face addSublayer:layer];
    //convert the face transform to matrix
    //(GLKMatrix4 has the same structure as CATransform3D)
    CATransform3D transform = face.transform;
    GLKMatrix4 matrix4 = *(GLKMatrix4 *)&transform;
    GLKMatrix3 matrix3 = GLKMatrix4GetMatrix3(matrix4);
    //get face normal
    GLKVector3 normal = GLKVector3Make(0, 0, 1);
    normal = GLKMatrix3MultiplyVector3(matrix3, normal);
    normal = GLKVector3Normalize(normal);
    //get dot product with light direction
    GLKVector3 light = GLKVector3Normalize(GLKVector3Make(LIGHT_DIRECTION));
    float dotProduct = GLKVector3DotProduct(light, normal);
    //set lighting layer opacity
    CGFloat shadow = 1 + dotProduct - AMBIENT_LIGHT;
    UIColor *color = [UIColor colorWithWhite:0 alpha:shadow];
    layer.backgroundColor = color.CGColor;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UIView * face = [[UIView alloc] init];
    if (self.j < 6) {
        face = self.faces[self.j];
    }else if (self.j >= 6 && self.j<12){
        face = self.faces[self.j-6];
    }else{
        self.j = 0;
        face = self.faces[self.j];
    }
    if (self.j == 0) {
        [UIView animateWithDuration:2 animations:^{
            face.layer.transform = CATransform3DMakeTranslation(0, 0, RectWidth/2);
        }];
    }else if (self.j == 1){
        [UIView animateWithDuration:2 animations:^{
            CATransform3D transform = CATransform3DIdentity;
            transform = CATransform3DMakeTranslation(RectWidth/2, 0, 0);
            transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
            face.layer.transform = transform;
        }];
    }else if (self.j == 2){
        [UIView animateWithDuration:2 animations:^{
            CATransform3D transform = CATransform3DIdentity;
            transform = CATransform3DMakeTranslation(0, -RectWidth/2, 0);
            transform = CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
            face.layer.transform = transform;
        }];
    }else if (self.j == 3){
        [UIView animateWithDuration:2 animations:^{
            CATransform3D transform = CATransform3DIdentity;
            transform = CATransform3DMakeTranslation(0, RectWidth/2, 0);
            transform = CATransform3DRotate(transform, -M_PI_2, 1, 0, 0);
            face.layer.transform = transform;
        }];
    }else if (self.j == 4){
        [UIView animateWithDuration:2 animations:^{
            CATransform3D transform = CATransform3DIdentity;
            transform = CATransform3DMakeTranslation(-RectWidth/2, 0, 0);
            transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
            face.layer.transform = transform;
        }];
    }else if (self.j == 5){
        [UIView animateWithDuration:2 animations:^{
            CATransform3D transform = CATransform3DIdentity;
            transform = CATransform3DMakeTranslation(0, 0, -RectWidth/2);
            transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);
            face.layer.transform = transform;
        }];
    }else if (self.j == 6){
        [UIView animateWithDuration:2 animations:^{
            face.layer.transform = CATransform3DMakeTranslation(0, 0, LageRectWidth);
        }];
    }else if (self.j == 7){
        [UIView animateWithDuration:2 animations:^{
            CATransform3D transform = CATransform3DIdentity;
            transform = CATransform3DMakeTranslation(LageRectWidth, 0, 0);
            transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
            face.layer.transform = transform;
        }];
    }else if (self.j == 8){
        [UIView animateWithDuration:2 animations:^{
            CATransform3D transform = CATransform3DIdentity;
            transform = CATransform3DMakeTranslation(0, -LageRectWidth, 0);
            transform = CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
            face.layer.transform = transform;
        }];
    }else if (self.j == 9){
        [UIView animateWithDuration:2 animations:^{
            CATransform3D transform = CATransform3DIdentity;
            transform = CATransform3DMakeTranslation(0, LageRectWidth, 0);
            transform = CATransform3DRotate(transform, -M_PI_2, 1, 0, 0);
            face.layer.transform = transform;
        }];
    }else if (self.j == 10){
        [UIView animateWithDuration:2 animations:^{
            CATransform3D transform = CATransform3DIdentity;
            transform = CATransform3DMakeTranslation(-LageRectWidth, 0, 0);
            transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
            face.layer.transform = transform;
        }];
    }else if (self.j == 11){
        [UIView animateWithDuration:2 animations:^{
            CATransform3D transform = CATransform3DIdentity;
            transform = CATransform3DMakeTranslation(0, 0, -LageRectWidth);
            transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);
            face.layer.transform = transform;
        }];
    }
    self.j++;
}

- (void)addFace:(NSInteger)index withTransform:(CATransform3D)transform{
    UIView *face = self.faces[index];
    [self.containerView addSubview:face];
    CGSize containerSize = self.containerView.bounds.size;
    face.center = CGPointMake(containerSize.width / 2.0, containerSize.height / 2.0);
    face.layer.transform = transform;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    UIGraphicsBeginImageContext(CGSizeMake(150.0f, 150.0f));
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
//    CGContextClip(contextRef);
    CGContextAddRect(contextRef, CGRectMake(0.0f, 0.0f, 150.0f, 150.0f));
    [RANDOM_COLOR setFill];
//    [RANDOM_COLOR setStroke];
//    CGContextDrawPath(contextRef, kCGPathFillStroke);
    CGContextFillPath(contextRef);
    CGContextMoveToPoint(contextRef, 0.0f, 75.0f);
    CGContextAddLineToPoint(contextRef, 150.0f, 75.0f);
    CGContextMoveToPoint(contextRef, 75.0f, 0.0f);
    CGContextAddLineToPoint(contextRef, 75.0f, 150.0f);
    [[UIColor whiteColor] setStroke];
    CGContextStrokePath(contextRef);
    self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
@end
