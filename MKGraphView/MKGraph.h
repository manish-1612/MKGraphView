//
//  MKGraph.h
//  MKGraphView
//
//  Created by Manish Kumar on 22/06/16.
//  Copyright © 2016 Innofied Solutions Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MKGraph : UIView{
    
    double xRatioFactor;
    double yRatioFactor;
}


@property (nonatomic) NSInteger maxValueX;
@property (nonatomic) NSInteger maxValueY;
@property (nonatomic , strong) NSMutableArray *arrayForValues;

@property (nonatomic) CGFloat strokeWidth;
@property (nonatomic, strong) UIColor *strokeColor;

-(id)initWithFrame:(CGRect)frame;
-(void)drawGraph;


@end
