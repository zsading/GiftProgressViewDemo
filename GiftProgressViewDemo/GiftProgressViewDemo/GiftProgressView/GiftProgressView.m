//
//  GiftProgressView.m
//  GiftProgressViewDemo
//
//  Created by VictorDing on 2017/12/5.
//  Copyright © 2017年 VictorDing. All rights reserved.
//

#import "GiftProgressView.h"

@implementation GiftProgressView
{
    
    CAShapeLayer *maskLayer;//蒙版层
    UIView *aboveView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        maskLayer = [CAShapeLayer layer];
        self.backgroundColor = [UIColor clearColor];
        self.smallCircleRadius = 15;
        self.circleRadius = 20;
        
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (!self.disableAnimation) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self configElementsOnAbove:NO];
        
        
        aboveView = [[UIView alloc] initWithFrame:self.bounds];
        aboveView.backgroundColor = [UIColor clearColor];
        maskLayer =  [CAShapeLayer layer];
        maskLayer.frame = aboveView.bounds;
        [self addSubview:aboveView];
        
        [self configElementsOnAbove:YES];
        [self bringSubviewToFront:aboveView];
        [self configMask];
        [self configBtn];
    }
}



- (void)configElementsOnAbove:(BOOL)flag {
    
    CGFloat smallCircleRadius = self.smallCircleRadius;
    CGFloat circleRadius = self.circleRadius;
    CGFloat lineHeight = 7;
    CGFloat smallCircleY = self.frame.size.height/2 - smallCircleRadius;
    CGFloat bigCircleY = self.frame.size.height/2 - circleRadius;
    CGFloat lineY = self.frame.size.height/2 - lineHeight/2;
    
    
    [self generatePointWithFrame:CGRectMake(0, smallCircleY, smallCircleRadius*2, smallCircleRadius*2) above:flag];
    [self generatePointWithFrame:CGRectMake(self.frame.size.width/2-smallCircleRadius, smallCircleY, smallCircleRadius*2, smallCircleRadius*2) above:flag];
    [self generatePointWithFrame:CGRectMake(self.frame.size.width - circleRadius*2,bigCircleY, circleRadius*2, circleRadius*2) above:flag];
    
    [self generateLineWithFrame:CGRectMake(5, lineY, self.frame.size.width - 10, lineHeight) above:flag];
    
}

- (void)configBtn{
    
    if (!self.giftBtn1) {
        self.giftBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.giftBtn1.tag = 1;
        [self.giftBtn1 addTarget:self action:@selector(giftBtnClickAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    if (!self.giftBtn2) {
        self.giftBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.giftBtn2.tag = 2;
        [self.giftBtn2 addTarget:self action:@selector(giftBtnClickAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    if (!self.giftBtn3) {
        self.giftBtn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.giftBtn3.tag = 3;
        [self.giftBtn3 addTarget:self action:@selector(giftBtnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self addSubview:self.giftBtn1];
    [self addSubview:self.giftBtn2];
    [self addSubview:self.giftBtn3];
    
    
    CGFloat smallCircleRadius = self.smallCircleRadius;
    CGFloat circleRadius = self.circleRadius;
    CGFloat smallCircleY = self.frame.size.height/2 - smallCircleRadius;
    CGFloat bigCircleY = self.frame.size.height/2 - circleRadius;
    
    
    self.giftBtn1.frame = CGRectMake(0, smallCircleY, smallCircleRadius*2, smallCircleRadius*2);
    self.giftBtn2.frame = CGRectMake(self.frame.size.width/2-smallCircleRadius, smallCircleY, smallCircleRadius*2,smallCircleRadius*2);
    self.giftBtn3.frame = CGRectMake(self.frame.size.width - circleRadius*2,bigCircleY,circleRadius*2,circleRadius*2);
    
}


- (void)generateLineWithFrame:(CGRect)frame above:(BOOL)isAbove{
    
    UIView *lineView = [[UIView alloc] initWithFrame:frame];
    
    if (isAbove) {
        lineView.backgroundColor = [UIColor colorFromHexCode:@"c2e9ee"];
        [aboveView addSubview:lineView];
    }else{
        lineView.backgroundColor = [UIColor colorFromHexCode:@"348aae"];
        [self addSubview:lineView];
    }
}

- (void)generatePointWithFrame:(CGRect)frame above:(BOOL)isAbove {
    UIView *pointView = [[UIView alloc] initWithFrame:frame];
    
    pointView.layer.cornerRadius = frame.size.width/2;
  
    
    if (isAbove) {
        pointView.backgroundColor = [UIColor colorFromHexCode:@"c2e9ee"];
        [aboveView addSubview:pointView];
    }else{
        pointView.backgroundColor = [UIColor colorFromHexCode:@"348aae"];
        [self addSubview:pointView];
    }
    
}


- (void)configMask{
    
    
    maskLayer = [CAShapeLayer layer];
    maskLayer.bounds = aboveView.bounds;
    maskLayer.fillColor = [[UIColor blackColor] CGColor];
    maskLayer.path = [UIBezierPath bezierPathWithRect:aboveView.bounds].CGPath;
    maskLayer.opacity = 0.8;
    maskLayer.position = CGPointMake(-aboveView.bounds.size.width / 2.0, aboveView.bounds.size.height / 2.0);
    
    aboveView.layer.mask = maskLayer;
    
    
}

- (void)giftBtnClickAction:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(giftProgressClickGiftButton:)]) {
        [self.delegate giftProgressClickGiftButton:btn];
    }
}

//MARK:Public Method

- (void)startAnimation {
    //    _percentValue*self.width
    //    [moveLayer removeAllAnimations];
    maskLayer.position = CGPointMake(-aboveView.bounds.size.width / 2.0 + _currentPercent * CGRectGetWidth(aboveView.bounds), aboveView.bounds.size.height / 2.0);
    CABasicAnimation *rightAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    rightAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(-aboveView.bounds.size.width / 2.0, aboveView.bounds.size.height / 2.0)];
    rightAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(-aboveView.bounds.size.width / 2.0 + _currentPercent * CGRectGetWidth(aboveView.bounds), aboveView.bounds.size.height / 2.0)];
    rightAnimation.duration = 1;
    rightAnimation.repeatCount = 0;
    rightAnimation.removedOnCompletion = YES;
    [maskLayer addAnimation:rightAnimation forKey:@"rightAnimation"];
}


//MARK:Setter And Getter
- (void)setCurrentPercent:(CGFloat)currentPercent{
    _currentPercent = currentPercent;
}

@end
