
//  ViewController.h
//  New_graph
//
//  Created by Test on 3/18/15.
//  Copyright (c) 2015 Test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    
    IBOutlet UIScrollView *scrollview;
    IBOutlet UIView *graphView;
}
@property (nonatomic, strong) IBOutlet UILabel *windSpd;
@property (nonatomic, strong) IBOutlet UIImageView *climate;
@property (nonatomic, strong) IBOutlet UILabel *tempC;


@end

