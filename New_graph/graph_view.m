//
//  graph_view.m
//  New_graph
//
//  Created by Test on 3/18/15.
//  Copyright (c) 2015 Test. All rights reserved.
//

#import "graph_view.h"


@implementation graph_view
#define kBarTop 10
#define kBarWidth 40
#define kStepY 50
#define kOffsetY 10


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
*/

- (void)drawRect:(CGRect)rect
{
    maxGraphHeight = kGraphHeight - kOffsetY;
    width1 = 2;
    
    ctx = UIGraphicsGetCurrentContext();
    // Remove previous Drawed content
    color = [UIColor whiteColor];
    if (i_button_tag)
    {
    }
    else
    {
        [self service_calling];
        
        j_value = 1;
        i_x_color = 29;
        i_x_circle = i_x_color + 29;
    }
    [self drawLineGraphWithContext:ctx :NO];
    
}
-(void)getdata {
    
    int buttonIndex = [i_button_tag intValue];
    int imageCode = [arr_imge[buttonIndex-1] integerValue];
    CGFloat tempCValue =[ wind_Array[buttonIndex-1] floatValue];
    CGFloat tempFValue = [array_points[buttonIndex]floatValue];
    
    NSMutableArray *graphArray=[[NSMutableArray alloc]init];
    [graphArray addObject:array_points[buttonIndex]];
    [graphArray addObject:wind_Array[buttonIndex-1]];
    [graphArray addObject:arr_imge[buttonIndex-1]];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"GraphAction" object:graphArray];
//    [self.delegate fillDetails:tempCValue withImage:imageCode andWith:tempFValue];
    
}
#pragma mark - service method
-(void) service_calling
{
    arr_imge = [NSMutableArray new];
    arr_temp = [NSMutableArray new];
    timeArray =[NSMutableArray new];
    dateTimeArray = [NSMutableArray new];
    array_points = [NSMutableArray new];
    buttonArray = [NSMutableArray new];
    hourArray = [NSMutableArray new];
    precipArray = [NSMutableArray new];
    arr_temp = [@[@"0.0"] mutableCopy];
    wind_Array = [NSMutableArray new];
//    arr_imge = [@[@"0.0"] mutableCopy];
    // Set dummy Array
    NSArray *array = [NSArray arrayWithObjects:@"00",@"50", @"90", @"80", @"60", @"50", @"40", @"75", @"53", @"44", @"88", @"30",@"60", nil];
//    array_points = [NSMutableArray arrayWithObjects:@"0.0",@"0.5",@"0.9",@"0.8",@"0.6", @"0.5",@"0.4", @"0.75", @"0.53", @"0.44", @"0.88", @"0.30",@"0.60",@"0.0", nil];

    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://services.intellicast.com/200904-01/274135753/Weather/Report/94101?filter=1,3,4,9&Days=7&hours=12"]]];
    parser.delegate = self;
    [array_points addObject:@"0.0"];
   // [arr_temp addObject:@"0.0"];
    [parser parse];
//    array_points = [NSMutableArray arrayWithObjects:@"0.0",@"0.5",@"0.9",@"0.8",@"0.6",@"0.4", @"0.75", @"0.53", @"0.44", @"0.88", @"0.30",@"0.60",@"0.0", nil];

    //TODO: Adding view in graph view
    // Creating view for set the object on that
    for(int i =0;i<dateTimeArray.count;i++) {
        NSString *string = dateTimeArray[i] ;
        NSArray *arrayObjects = [string componentsSeparatedByString:@" "];
        string = [arrayObjects objectAtIndex:1];
        NSArray *separatedObjects = [string componentsSeparatedByString:@":"];
        int hour = [separatedObjects[0] intValue];
        id hourObject = separatedObjects[0];
        [hourArray addObject:hourObject];
        int minute = [separatedObjects[1] intValue];
        if(minute == 0){
        string = [NSString stringWithFormat:@"%d:%d0",hour,minute];
        }
        else {
            string = [NSString stringWithFormat:@"%d:%d",hour,minute];
        }        [timeArray addObject:string];
    }
    view = [[UIView alloc]initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y+170, self.frame.size.width, 86)];
    view.backgroundColor = [UIColor whiteColor];
 
    [self addSubview:view];
    
    UIView *view_line = [[UIView alloc]initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y+168, self.frame.size.width, 2)];
    view_line.backgroundColor = [UIColor blackColor];
    [self addSubview:view_line];
    
    // Is use to create a image, temprature value
    CGFloat x= 47;
    CGFloat y = 10;
    CGFloat xHalf = 58.0/2.0;
    CGFloat width = 15 , hieght = 10;
    for (int i = 0; i < [arr_imge count]; i++)
    {
        UILabel *lbl_date = [[UILabel alloc]initWithFrame:CGRectMake(x-7, y, width+20, hieght+2)];
        lbl_date.text = [NSString stringWithFormat:@"%@", timeArray[i]];
        lbl_date.font = [lbl_date.font fontWithSize:12.0];
        lbl_date.textColor = [UIColor blackColor];
        lbl_date.textAlignment = NSTextAlignmentCenter;
        [view addSubview:lbl_date];

        UIImageView *imge = [[UIImageView alloc]initWithFrame:CGRectMake(x, y+19, width+5, hieght+10)];
        imge.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://media.nbcbayarea.com/designimages/new_wx_%@.png", arr_imge[i]]]]];
        [view addSubview:imge];
        
        UILabel *tempC = [[UILabel alloc]initWithFrame:CGRectMake(x+2, y+45, width, hieght)];
        float value = [array_points[i+1]floatValue];
        int intValue = value*100;
           tempC.text = [NSString stringWithFormat:@"%d", intValue];
        tempC.textColor = [UIColor blackColor];
        tempC.font = [tempC.font fontWithSize:12.0];
        tempC.textAlignment = NSTextAlignmentCenter;
        [view addSubview:tempC];

        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(x-6, y+61,10, hieght+3
                                                                        )];
        img.image = [UIImage imageNamed:@"drop.png"];
        [view addSubview:img];

        UILabel *precipLabel = [[UILabel alloc]initWithFrame:CGRectMake(x, y+61, width+10, hieght+5)];
        int precipValue = [precipArray[i] integerValue];
        precipLabel.text = [NSString stringWithFormat:@"%d\%",precipValue];
        precipLabel.textColor = [UIColor blackColor];
        precipLabel.font = [precipLabel.font fontWithSize:11.0];
//        [precipLabel setFont:[UIFont fontWithName:@"Helvetica-Regular" size:3]];
        precipLabel.textAlignment = NSTextAlignmentCenter;
        [view addSubview:precipLabel];

        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(xHalf, y-10, 58, hieght+76)];
        btn.tag = i;
        [btn setBackgroundColor:[UIColor clearColor]];
        [btn addTarget:self action:@selector(button_action:) forControlEvents:UIControlEventTouchUpInside];
        [buttonArray addObject:btn];
        [view addSubview:btn];
        
        x = x+58;
        xHalf = xHalf+58;
    }
    [self getCurrentTime];

}
-(void)getCurrentTime{
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // display in 12HR/24HR (i.e. 11:25PM or 23:25) format according to User Settings
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *currentTime = [dateFormatter stringFromDate:today];
    NSArray *dividedTime = [currentTime componentsSeparatedByString:@":"];
    int minValue = [[dividedTime lastObject]integerValue];
    int hourValue = [[dividedTime firstObject]integerValue];
    for(int i=0;i<hourArray.count;i++) {
        int hourAtIndex = [hourArray[i] integerValue];
        if(hourAtIndex == hourValue) {
            UIButton *button;
            if(minValue>30)
            button = buttonArray[i+1];
            else
                button = buttonArray[i];
            [self performSelection:button];
        }
    }
    
}
-(void)performSelection:(UIButton*)button {
    i_button_tag =[NSString stringWithFormat:@"%ld", (long)button.tag+1];
    if (button.tag == 0)
    {
        j_value = 0;
    }
    [self setNeedsDisplay];
    
    for (UIView* subView in view.subviews)
    {
        if ([subView isKindOfClass:[UIButton class]])
        {
            [subView setBackgroundColor:[UIColor clearColor]];
        }
    }
    [button setBackgroundColor:[UIColor colorWithRed:0.717 green:0.882 blue:0.913 alpha:0.6]];
    [self getdata];

}
#pragma mark - button action
-(void) button_action : (UIButton *) btn
{
    [self performSelection:btn];
 //    Setting +1, Because of need to set more than o in j_value veriable

}

#pragma mark - drawing line and views
- (void)drawLineGraphWithContext:(CGContextRef)ctx1 : (BOOL) Contidion
{    
  //  array_points = [NSMutableArray arrayWithObjects:@"0.0",@"0.5",@"0.9",@"0.8",@"0.6", @"0.5",@"0.4", @"0.75", @"0.53", @"0.44", @"0.88", @"0.30",@"0.60",@"0.0", nil];
//    array_points = [NSArray arrayWithObjects:@"0.0",@"0.5",@"0.6",@"0.7",@"0.6", @"0.5",@"0.4", @"0.3", @"0.3", @"0.44", @"0.5", @"0.30",@"0.40",@"0.0", nil];
//    array_points = arr_temp;
 
    CGContextSetLineWidth(ctx,1.0);
    CGContextSetStrokeColorWithColor(ctx, color.CGColor); // [[UIColor colorWithRed:1.0 green:0.5 blue:0 alpha:1.0] CGColor]
//    CGContextStrokeEllipseInRect(ctx, CGRectMake(10, 11, 21, 21));
    
    // TODO: Code for fill the color
  //  CGMutablePathRef path = CGPathCreateMutable();

    CGContextSetFillColorWithColor(ctx, [UIColor colorWithRed:0.815 green:0.921 blue:0.941 alpha:1.0].CGColor);
   // CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:0.760 green:0.894 blue:0.921 alpha:0.5].CGColor);

    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, kOffsetX, kGraphHeight);
    CGContextAddLineToPoint(ctx, kOffsetX, kGraphHeight - maxGraphHeight * [array_points[0] floatValue]);
    [array_points addObject:@"0.0"];
    [arr_temp addObject:@"0.0"];
    for (int i = 0; i < array_points.count; i++)
    {
         CGContextAddLineToPoint(ctx, kOffsetX + i * kStepX, kGraphHeight - maxGraphHeight * [array_points[i] floatValue]);
    }
    
    CGContextAddLineToPoint(ctx, kOffsetX + (array_points.count - 1) * kStepX, kGraphHeight);
    CGContextClosePath(ctx);
    CGContextDrawPath(ctx, kCGPathFill);
  
    CGContextSetFillColorWithColor(ctx, [UIColor colorWithRed:0.796 green:0.917 blue:0.827 alpha:1.0].CGColor);

    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, kOffsetX, kGraphHeight);
    CGContextAddLineToPoint(ctx, kOffsetX, kGraphHeight - maxGraphHeight * [arr_temp[0] floatValue]);
    
    for (int i = 0; i < arr_temp.count; i++)
    {
        CGContextAddLineToPoint(ctx, kOffsetX + i * kStepX, kGraphHeight - maxGraphHeight * [arr_temp[i] floatValue]);
    }
    
    CGContextAddLineToPoint(ctx, kOffsetX + (arr_temp.count - 1) * kStepX, kGraphHeight);
    CGContextClosePath(ctx);
    CGContextDrawPath(ctx, kCGPathFill);

    // End Fill Color
    
    
     //TODO: Set smooth Line start
    int in_dec_value= 18;
    int i_y_value =8;
    int c2x = 10;
    int c2y = 10;
    int c1x;
    int c1y;
    int height1;
    int height2;
    int heightDifference;
    int value;
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    CGPoint point2, point1;
    CGPoint controlPoint;
    CGPoint controlPoint2, controlPoint1;
    
//    CGContextSetFillColorWithColor(ctx, [UIColor colorWithRed:0.717 green:0.882 blue:0.913 alpha:0.5].CGColor);
    CGContextSetFillColorWithColor(ctx, [UIColor colorWithRed:0.815 green:0.921 blue:0.941 alpha:1.0].CGColor);

    for (int i = 0; i < [array_points count]; i++)
    {
    
        point1 = CGPointMake(kOffsetX + i * kStepX, kGraphHeight - maxGraphHeight * [array_points[i] floatValue]);
        height1 = kGraphHeight - maxGraphHeight * [array_points[i] floatValue];
        controlPoint1 = CGPointMake(kOffsetX + i * kStepX+in_dec_value, kGraphHeight - (maxGraphHeight * [array_points[i] floatValue])-i_y_value);
        
        if(i >= [array_points count]-1)
        {
            point2 = CGPointMake(kOffsetX + i * kStepX+58, kGraphHeight - maxGraphHeight * 0);
            height2 = kGraphHeight - maxGraphHeight *0;
            controlPoint2 = CGPointMake(kOffsetX + i * kStepX+58-c2x, kGraphHeight - maxGraphHeight * 0+c2y);
        }
        else
        {
            point2 = CGPointMake(kOffsetX + i * kStepX+58, kGraphHeight - maxGraphHeight * [array_points[i+1] floatValue]);
            height2 = kGraphHeight - maxGraphHeight * [array_points[i+1] floatValue];
            controlPoint2 = CGPointMake(kOffsetX + i * kStepX+58-c2x, kGraphHeight - maxGraphHeight * [array_points[i+1] floatValue]-c2y);
        }
        [path1 setLineWidth:2];
        [path1 moveToPoint:point1];
        heightDifference = height2-height1;
        // Top to bottom
        if(heightDifference>0) {
            if(heightDifference>20) {
                c1x = heightDifference/10 + 2;
                c1y = heightDifference/10 + 9;
                controlPoint1 = CGPointMake(kOffsetX + i * kStepX+c1x, kGraphHeight - (maxGraphHeight * [array_points[i] floatValue])-c1y);
                if(i >= [array_points count]-1) {
            controlPoint2 = CGPointMake(kOffsetX + i * kStepX+58-c1x, kGraphHeight - maxGraphHeight *0);
                }
                else {
                controlPoint2 = CGPointMake(kOffsetX + i * kStepX+58-c1x, kGraphHeight - maxGraphHeight * [array_points[i+1] floatValue]+c1y);
                }

}
            else {
                c1x = heightDifference/10+2;
                c1y = heightDifference/10+2;
                controlPoint1 = CGPointMake(kOffsetX + i * kStepX+c1x, kGraphHeight - (maxGraphHeight * [array_points[i] floatValue])-c1y);
                if(i >= [array_points count]-1) {
                controlPoint2 = CGPointMake(kOffsetX + i * kStepX+58-c1x, kGraphHeight - maxGraphHeight * 0);
                }
                else {
                    controlPoint2 = CGPointMake(kOffsetX + i * kStepX+58-c1x, kGraphHeight - maxGraphHeight * [array_points[i+1] floatValue]+c1y);
                }
            }
        }
        else {
            // Bottom to Top
            if(heightDifference < -20) {
                int value = -heightDifference/10;
                c1x = value ;
                c1y = value+9;
                controlPoint1 = CGPointMake(kOffsetX + i * kStepX+c1x, kGraphHeight - (maxGraphHeight * [array_points[i] floatValue])+c1y);
                if(i >= [array_points count]-1) {
                    controlPoint2 = CGPointMake(kOffsetX + i * kStepX+58-c1x, kGraphHeight - maxGraphHeight * 0);

                }
                else {
                controlPoint2 = CGPointMake(kOffsetX + i * kStepX+58-c1x, kGraphHeight - maxGraphHeight * [array_points[i+1] floatValue]-c1y);
                }
            }
            else {
                value = -heightDifference/10;
                c1x = value +2 ;
                c1y = value +2;
                controlPoint1 = CGPointMake(kOffsetX + i * kStepX+c1x, kGraphHeight - (maxGraphHeight * [array_points[i] floatValue])+c1y);
                if(i >= [array_points count]-1) {
                    controlPoint2 = CGPointMake(kOffsetX + i * kStepX+58-c1x, kGraphHeight - maxGraphHeight * 0);

                }
                else {
                controlPoint2 = CGPointMake(kOffsetX + i * kStepX+58-c1x, kGraphHeight - maxGraphHeight * [array_points[i+1] floatValue]-c1y);
                }
            }
        }
//        if(height1 < height2) {
//            controlPoint = CGPointMake(kOffsetX + i * kStepX+in_dec_value, kGraphHeight - (maxGraphHeight * [array_points[i] floatValue])+i_y_value);
//        [path1 addCurveToPoint:point2 controlPoint1:controlPoint1 controlPoint2:controlPoint2];
//     //   [path1 addQuadCurveToPoint:point2 controlPoint:controlPoint];
//        }
//        else {
//            controlPoint = CGPointMake(kOffsetX + i * kStepX+in_dec_value, kGraphHeight - (maxGraphHeight * [array_points[i] floatValue])-i_y_value);

            [path1 addCurveToPoint:point2 controlPoint1:controlPoint1 controlPoint2:controlPoint2];
//
//         //   [path1 addQuadCurveToPoint:point2 controlPoint:controlPoint];
//        }
       // [path1 fillWithBlendMode:kCGBlendModePlusLighter
           //                alpha:0.1];
        [path1 fill];
    }
    CGContextSetFillColorWithColor(ctx, [UIColor colorWithRed:0.796 green:0.917 blue:0.827 alpha:1.0].CGColor);

    for (int i = 0; i < [arr_temp count]; i++)
    {
    point1 = CGPointMake(kOffsetX + i * kStepX, kGraphHeight - maxGraphHeight * [arr_temp[i] floatValue]);
    height1 = kGraphHeight - maxGraphHeight * [arr_temp[i] floatValue];
    controlPoint1 = CGPointMake(kOffsetX + i * kStepX+in_dec_value, kGraphHeight - (maxGraphHeight * [arr_temp[i] floatValue])-i_y_value);
    
    if(i >= [arr_temp count]-1)
    {
        point2 = CGPointMake(kOffsetX + i * kStepX+58, kGraphHeight - maxGraphHeight * 0);
        height2 = point2.y;
        controlPoint2 = CGPointMake(kOffsetX + i * kStepX+58-c2x, kGraphHeight - maxGraphHeight * 0);
    }
    else
    {
        point2 = CGPointMake(kOffsetX + i * kStepX+58, kGraphHeight - maxGraphHeight * [arr_temp[i+1] floatValue]);
        height2 = point2.y;
        controlPoint2 = CGPointMake(kOffsetX + i * kStepX+58-c2x, kGraphHeight - maxGraphHeight * [arr_temp[i+1] floatValue]+c2y);
    }
    [path2 setLineWidth:2];
    [path2 moveToPoint:point1];
        heightDifference = height2-height1;
        if(heightDifference>0) {
            if(heightDifference>20) {
                c1x = heightDifference/10 + 2;
                c1y = heightDifference/10 + 9;
                controlPoint1 = CGPointMake(kOffsetX + i * kStepX+c1x, point1.y-c1y);
                if(i >= [array_points count]-1) {
                    controlPoint2 = CGPointMake(kOffsetX + i * kStepX+58-c1x, kGraphHeight - maxGraphHeight *0);
                }
                else {
                    controlPoint2 = CGPointMake(kOffsetX + i * kStepX+58-c1x, point2.y+c1y);
                }
                
            }
            else {
                c1x = heightDifference/10+2;
                c1y = heightDifference/10+4;
                controlPoint1 = CGPointMake(kOffsetX + i * kStepX+c1x, point1.y-c1y);
                if(i >= [array_points count]-1) {
                    controlPoint2 = CGPointMake(kOffsetX + i * kStepX+58-c1x, kGraphHeight - maxGraphHeight * 0);
                }
                else {
                    controlPoint2 = CGPointMake(kOffsetX + i * kStepX+58-c1x, point2.y+c1y);
                }
            }
        }
        else {
            // Bottom to Top
            if(heightDifference < -20) {
                int value = -heightDifference/10;
                c1x = value ;
                c1y = value+9;
                controlPoint1 = CGPointMake(kOffsetX + i * kStepX+c1x, point1.y+c1y);
                if(i >= [array_points count]-1) {
                    controlPoint2 = CGPointMake(kOffsetX + i * kStepX+58-c1x, kGraphHeight - maxGraphHeight * 0);
                    
                }
                else {
                    controlPoint2 = CGPointMake(kOffsetX + i * kStepX+58-c1x, point2.y-c1y);
                }
            }
            else {
                value = -heightDifference/10;
                c1x = value ;
                c1y = value ;
                controlPoint1 = CGPointMake(kOffsetX + i * kStepX+c1x, point1.y+c1y);
                if(i >= [array_points count]-1) {
                    controlPoint2 = CGPointMake(kOffsetX + i * kStepX+58-c1x, kGraphHeight - maxGraphHeight * 0);
                    
                }
                else {
                    controlPoint2 = CGPointMake(kOffsetX + i * kStepX+58-c1x, point2.y-c1y);
                }
            }
        }

  //  if(height1 < height2) {
  //      controlPoint = CGPointMake(kOffsetX + i * kStepX+in_dec_value, kGraphHeight - (maxGraphHeight * [arr_temp[i] floatValue])+i_y_value);
        [path2 addCurveToPoint:point2 controlPoint1:controlPoint1 controlPoint2:controlPoint2];
      //  [path2 addQuadCurveToPoint:point2 controlPoint:controlPoint];
  //  }
  //  else {
   //     controlPoint = CGPointMake(kOffsetX + i * kStepX+in_dec_value, kGraphHeight - (maxGraphHeight * [arr_temp[i] floatValue])-i_y_value);
  //      [path2 addCurveToPoint:point2 controlPoint1:controlPoint1 controlPoint2:controlPoint2];
     //   [path2 addQuadCurveToPoint:point2 controlPoint:controlPoint];
  //  }
    // [path1 fillWithBlendMode:kCGBlendModePlusLighter
    //                alpha:0.1];
    [path2 fill];
    }
    
    // Set Smooth Line end
    
    // New Code for to set line from y position to at the point
    for (int i = 0; i < array_points.count; i++)
    {
        CGContextMoveToPoint(ctx, kOffsetX + i * kStepX, kGraphBottom);
        CGContextAddLineToPoint(ctx, kOffsetX + i * kStepX, kGraphHeight - maxGraphHeight * [array_points[i] floatValue]);
    }
    CGContextStrokePath(ctx);
    //End
    
    // Set Point on the line
    CGContextSetFillColorWithColor(ctx, color.CGColor); // [[UIColor colorWithRed:1.0 green:0.5 blue:0 alpha:1.0] CGColor]
    for (int i = 0; i < array_points.count; i++)
    {
        float x = kOffsetX + i * kStepX;
        float y = kGraphHeight - maxGraphHeight * [array_points[i] floatValue];
        
        CGRect rect = CGRectMake(x - kCircleRadius, y - kCircleRadius, width1 * kCircleRadius, width1 * kCircleRadius);
        CGContextAddEllipseInRect(ctx, rect);
    }
    CGContextDrawPath(ctx, kCGPathFillStroke);
    for (int i = 0; i < array_points.count; i++)
    {
        float x = kOffsetX + i * kStepX;
        float y = kGraphHeight - maxGraphHeight * [array_points[i] floatValue];
        
        CGRect rect = CGRectMake(x - 4, y - 4 , width1 * 4, width1 * 4);
        CGContextAddEllipseInRect(ctx, rect);
      //  CGContextSetLineWidth(ctx, 3);

    }
    CGContextSetFillColorWithColor(ctx,[UIColor colorWithRed:0.243 green:0.666 blue:0.760 alpha:0.5].CGColor);
    
//    CGContextSetStrokeColorWithColor(ctx,[UIColor colorWithRed:0.243 green:0.666 blue:0.760 alpha:0.5].CGColor);
    CGContextDrawPath(ctx, kCGPathFillStroke);

    
    // End
    if (i_button_tag)
    {
        [self dummy_drawing];
    }
}

#pragma mark - darwing overlayer on graph
-(void) dummy_drawing
{
    // TODO: Code for fill the color
    //  CGMutablePathRef path = CGPathCreateMutable();
    
    j_value = j_value * [i_button_tag intValue];
    int tagValue = [i_button_tag intValue];
    i_x_color = (tagValue *58)-29;
    i_x_circle = i_x_color + 29;

//    CGContextSetFillColorWithColor(ctx, [UIColor colorWithWhite:0.5 alpha:0.5].CGColor);
//    CGContextSetFillColorWithColor(ctx, [UIColor colorWithRed:0.003 green:0.043 blue:0.992 alpha:0.1].CGColor);
   // CGContextSetFillColorWithColor(ctx, [UIColor colorWithRed:0.219 green:0.525 blue:0.890 alpha:0.5].CGColor);
    CGContextSetFillColorWithColor(ctx,[UIColor colorWithRed:0.717 green:0.882 blue:0.913 alpha:0.6].CGColor);
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, kOffsetX+i_x_color, kGraphHeight);
   // CGContextAddLineToPoint(ctx, kOffsetX+i_x_color, kGraphHeight - maxGraphHeight * [array_points[0] floatValue]);
    
    int j;
    if (j_value ==0 )
    {
        j =0 ;
    }
    else
    {
        j = j_value-1;
    }
    CGFloat height;
    for (int i=0; i< 3 ; i++)
    {
        if(i==0)
        {
            if(j >= [array_points count]-1)
            {
                height = kGraphHeight - maxGraphHeight *  ([array_points[j] floatValue] + 0)/ 2;
                CGContextAddLineToPoint(ctx, kOffsetX+i_x_color+i * 58,height-1);
            }
            else
            {
                height =kGraphHeight - maxGraphHeight *  ([array_points[j] floatValue] + [array_points [j+1] floatValue])/ 2;
                CGContextAddLineToPoint(ctx, kOffsetX+i_x_color+i * 58,height-1);
                j++;
            }
            
           
        }
        else if (i==1)
        {
            height = kGraphHeight  - maxGraphHeight * [array_points[j] floatValue];
            CGContextAddLineToPoint(ctx, kOffsetX+i_x_color+i * 29,height-1);
        }
        else
        {
            if (j >= [array_points count]-1)
            {
                height = kGraphHeight - maxGraphHeight *  ([array_points[j] floatValue] + 0)/ 2;
                CGContextAddLineToPoint(ctx, kOffsetX+i_x_color+i * 29, height-1);
            }
            else
            {
                height = kGraphHeight - maxGraphHeight *  ([array_points[j] floatValue] + [array_points [j+1] floatValue])/ 2;
                CGContextAddLineToPoint(ctx, kOffsetX+i_x_color+i * 29, height-1);
                j++;
            }
            
        }
    }
    CGContextAddLineToPoint(ctx, kOffsetX+i_x_color + 1 * kStepX, kGraphHeight);
    CGContextClosePath(ctx);
    CGContextDrawPath(ctx, kCGPathFill);
    // End Fill Color
    
    CGContextSetLineWidth(ctx, 1.0);
    // This Code going to set a line between 2 points
    
    int i_circle;
    if (j_value == 0)
    {
        i_circle = 1;
        
    }
    else
    {
        i_circle = j_value;
    }
  //  CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
    //Displayes the selected hour line with magnified circle
    for (int i = 0; i < 1; i++)
    {
        CGContextMoveToPoint(ctx, kOffsetX+i_x_circle + i * kStepX, kGraphBottom);
        CGContextAddLineToPoint(ctx, kOffsetX+i_x_circle + i * kStepX, kGraphHeight - maxGraphHeight * [array_points[i_circle] floatValue]);
    }
    CGContextStrokePath(ctx);
    // end
    
    // This code for set bold circle on the point
    // Set Point on the line
    CGContextSetFillColorWithColor(ctx, color.CGColor); // [[UIColor colorWithRed:1.0 green:0.5 blue:0 alpha:1.0] CGColor]
    
    float x;
    float y;
    CGRect rect;
    for (int i = 0; i < 1; i++)
    {
         x = kOffsetX+i_x_circle + i * kStepX-1;
       y = kGraphHeight - maxGraphHeight * [array_points[i_circle] floatValue];
//        rect = CGRectMake(x - kCircleRadius, y - kCircleRadius, width1+2.5 * kCircleRadius, width1+2.5 * kCircleRadius);

        rect = CGRectMake(x-11, y-17 , width1+2.7 * 9, width1+2.3* 11);
        CGContextAddEllipseInRect(ctx, rect);
    }
    CGContextDrawPath(ctx, kCGPathFillStroke);
    // End
    CGContextSetFillColorWithColor(ctx, [UIColor colorWithRed:0.243 green:0.666 blue:0.760 alpha:0.9].CGColor);
    CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:0.243 green:0.666 blue:0.760 alpha:0.5].CGColor);
    rect = CGRectMake(x - 6, y -12, width1+2.5 * 6, width1+2.5 *6);
    CGContextAddEllipseInRect(ctx, rect);
    CGContextSetLineWidth(ctx, 6);
    CGContextDrawPath(ctx, kCGPathFillStroke);
    
    j_value = 1;
}

#pragma Mark - NSXMlParser Delegate
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    if ( ( elementName != nil ) && ( [[elementName lowercaseString] isEqualToString:@"hour"] ) )
    {
        [arr_imge addObject:[attributeDict objectForKey:@"IconCode"]];
        float point = [[attributeDict objectForKey:@"TempF"] floatValue];
        NSString *svalue = [NSString stringWithFormat:@"%.2f", point/100];
        [array_points addObject:svalue];
         
         point = [[attributeDict objectForKey:@"TempC"] floatValue];
        [arr_temp addObject:[NSString stringWithFormat:@"%.2f",point/100]];
        [wind_Array addObject:[attributeDict objectForKey:@"WndSpdMph"] ];
        [dateTimeArray addObject:[attributeDict objectForKey:@"ValidDateUtc"]];
        [precipArray addObject:[attributeDict objectForKey:@"PrecipChance"]];
    }
}


@end
