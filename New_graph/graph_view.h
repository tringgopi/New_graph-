//
//  graph_view.h
//  New_graph
//
//  Created by Test on 3/18/15.
//  Copyright (c) 2015 Test. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "ViewController.h"



@interface graph_view : UIView <NSXMLParserDelegate>
{
    NSMutableArray *arr_imge,*arr_temp;
    UIView *view;
    CGContextRef ctx;
    NSMutableArray *array_points;
    NSMutableArray *array_TempF;
    NSMutableArray *wind_Array;
    NSMutableArray *dateTimeArray;
    NSMutableArray *timeArray;
    NSMutableArray *hourArray;
    NSMutableArray *buttonArray;
    NSMutableArray *precipArray;

    int maxGraphHeight ;
    UIColor *color;
    
    int width1;
    
    NSString* i_button_tag;
    UIView *view2;
    
    int j_value, i_x_circle, i_x_color;
}


// Defining the values
#define kGraphHeight 170
#define kDefaultGraphWidth 900
#define kOffsetX 0
#define Koffsetx_dummy 25
#define kStepX 58
#define kGraphBottom 170
#define kGraphTop 0

// Set circle radius

#define kCircleRadius 6
@end

