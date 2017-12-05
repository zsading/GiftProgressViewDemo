//
//  ViewController.m
//  GiftProgressViewDemo
//
//  Created by VictorDing on 2017/12/5.
//  Copyright © 2017年 VictorDing. All rights reserved.
//

#import "ViewController.h"
#import "GiftProgressView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet GiftProgressView *giftProgressView;

@property (weak, nonatomic) IBOutlet UILabel *valueLbl;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
 

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sliderValueChange:(UISlider *)sender {
    self.valueLbl.text = [NSString stringWithFormat:@"%ld%%",(NSInteger)(sender.value*100)];
    self.giftProgressView.currentPercent = sender.value;
}


- (IBAction)beginAnimation:(id)sender {
    
    [self.giftProgressView startAnimation];
}

@end
