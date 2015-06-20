//
//  ViewController.m
//  New_graph
//
//  Created by Test on 3/18/15.
//  Copyright (c) 2015 Test. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
- (void)viewDidLoad
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(graphButtonAction:) name:@"GraphAction" object:nil];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    scrollview.contentSize =  CGSizeMake(770,250);
}
-(void)graphButtonAction:(NSNotification *)notification
{
    NSArray *arr=[notification object];
    float value = [[arr firstObject]floatValue];
    int intValue = value*100;
    int windValue = [arr[1] integerValue];
    int image = [[arr lastObject]integerValue];
    int imageCode = image;
    [self fillDetails:intValue withImage:imageCode andWith:windValue];
}
-(void)fillDetails:(int)tempC withImage:(int)image andWith:(int)windSpd
{
    NSString *value = [NSString stringWithFormat:@"%d",tempC];
    [self.tempC setText:value];
    UIImage *storeImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://media.nbcbayarea.com/designimages/new_wx_%d.png",image]]]];
   [ self.climate  setImage:storeImage];
    value = [NSString stringWithFormat:@"Wind %d MPH",windSpd];
    [self.windSpd setText:value];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
