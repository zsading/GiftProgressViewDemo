//
//  GiftProgressView.h
//  GiftProgressViewDemo
//
//  Created by VictorDing on 2017/12/5.
//  Copyright © 2017年 VictorDing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+Hex.h"

typedef NS_ENUM(NSInteger,GiftProgressViewType){
    GiftProgressViewTypeOfUnFinished,
    GiftProgressViewTypeOfFinished,
    GiftProgressViewTypeOfOpen,
};

@protocol GiftProgressViewDelegate <NSObject>
//点击了礼物
- (void)giftProgressClickGiftButton:(UIButton *)btn;
@end

@interface GiftProgressView : UIView

//当前的百分数 0....1
@property (nonatomic,assign) CGFloat currentPercent;
//小圆的半径
@property (nonatomic,assign) CGFloat smallCircleRadius;
//大圆的半径
@property (nonatomic,assign) CGFloat circleRadius;
@property (nonatomic,strong) UIButton *giftBtn1;
@property (nonatomic,strong) UIButton *giftBtn2;
@property (nonatomic,strong) UIButton *giftBtn3;
@property (nonatomic, assign) BOOL disableAnimation;
@property (nonatomic,weak) id <GiftProgressViewDelegate> delegate;

//开始动画
- (void)startAnimation;


@end
