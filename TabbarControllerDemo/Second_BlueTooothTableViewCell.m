//
//  Second_BlueTooothTableViewCell.m
//  TabbarControllerDemo
//
//  Created by jecansoft on 15/11/5.
//  Copyright © 2015年 jecansoft. All rights reserved.
//

#import "Second_BlueTooothTableViewCell.h"

const static CGFloat marginLeft = 25.0f;
const static CGFloat leftRadiu = 60.0f;
const static CGFloat rightWidth = 100.0f;
const static CGFloat marginTop = 10.0f;


@implementation Second_BlueTooothTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.alpha = 0;
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(marginLeft, marginTop+leftRadiu/2-10.0f, leftRadiu, 20.0f)];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.textColor = [UIColor whiteColor];
        self.nameLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.nameLabel];
        self.stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWith-marginLeft-rightWidth, marginTop+leftRadiu/2-10.0f, rightWidth, 20.0f)];
        self.stateLabel.textAlignment = NSTextAlignmentCenter;
        self.stateLabel.textColor = [UIColor whiteColor];
        self.stateLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.stateLabel];
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(contextRef, CGRectMake(marginLeft, marginTop, leftRadiu, leftRadiu));
    CGContextSetLineWidth(contextRef, 5.0f);
    CGContextMoveToPoint(contextRef, marginLeft+leftRadiu, marginTop+leftRadiu/2);
    CGContextAddLineToPoint(contextRef, ScreenWith-marginLeft-rightWidth, 40.0f);
    CGContextMoveToPoint(contextRef, marginLeft+leftRadiu/2, 0.0f);
    CGContextAddLineToPoint(contextRef, marginLeft+leftRadiu/2, 10.0f);
    CGContextMoveToPoint(contextRef, marginLeft+leftRadiu/2, leftRadiu+10.0f);
    CGContextAddLineToPoint(contextRef, marginLeft+leftRadiu/2, 80.0f);
    [RANDOM_COLOR setFill];
    [RANDOM_COLOR setStroke];
    CGContextDrawPath(contextRef, kCGPathFillStroke);
    CGContextAddRect(contextRef, CGRectMake(ScreenWith-marginLeft-rightWidth, 20.0f, rightWidth, 40.0f));
    [RANDOM_COLOR setFill];
    CGContextFillPath(contextRef);
}

//sb活着xb调用
- (void)awakeFromNib {
    // Initialization code
}

//选择cell触发
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
