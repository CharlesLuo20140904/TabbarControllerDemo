//
//  PasteCollectionCell.m
//  TabbarControllerDemo
//
//  Created by jecansoft on 16/1/19.
//  Copyright © 2016年 jecansoft. All rights reserved.
//

#import "PasteCollectionCell.h"

@interface PasteCollectionCell ()
@property (strong, nonatomic) UIPasteboard* pasteboard;
@end

@implementation PasteCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.imageView];
        [self addSubview:self.nameLabel];
    }
    return self;
}

-(UIPasteboard *)pasteboard{
    if (_pasteboard == nil) {
        _pasteboard = [UIPasteboard generalPasteboard];
    }
    return _pasteboard;
}

-(UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, (ScreenWith-30.0f)/2, (ScreenWith-30.0f)/2)];
        _imageView.userInteractionEnabled = YES;
        UILongPressGestureRecognizer* imagePress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(delegateMethod:)];
        imagePress.minimumPressDuration = 1;
        [_imageView addGestureRecognizer:imagePress];
    }
    return _imageView;
}

-(UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(self.imageView.frame), (ScreenWith-30.0f)/2, 20.0f)];
        _nameLabel.backgroundColor = [UIColor yellowColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:14];
    }
    return _nameLabel;
}

-(BOOL)canBecomeFirstResponder{
    return YES;
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    NSArray* selecortNameArr = @[@"copy:",@"cut:",@"paste:",@"select:",@"selectAll:"];
    if ([selecortNameArr containsObject:NSStringFromSelector(action)]) {
        return YES;
    }
    return [super canPerformAction:action withSender:sender];
}

-(void)copy:(id)sender{
    NSDictionary* dict = @{@"name":self.nameLabel.text};
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:dict];
    [self.pasteboard setData:data forPasteboardType:@"imageAndString"];
}

-(void)cut:(id)sender{

}

-(void)paste:(id)sender{
    NSData* data = [self.pasteboard dataForPasteboardType:@"imageAndString"];
    NSDictionary* dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    self.nameLabel.text = [dict objectForKey:@"name"];
}

-(void)select:(id)sender{
    
}

-(void)selectAll:(id)sender{
    [self.pasteboard setString:self.nameLabel.text];
    [self.pasteboard setImage:self.imageView.image];
}

-(void)delegateMethod:(UILongPressGestureRecognizer*)longpress{
    if (longpress.state == UIGestureRecognizerStateBegan) {
        [self.delegate showPasteboardMenuForView:longpress.view];
    }
}

@end
