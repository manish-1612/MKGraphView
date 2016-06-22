//
//  MKGraph.m
//  MKGraphView
//
//  Created by Manish Kumar on 22/06/16.
//  Copyright © 2016 Innofied Solutions Pvt. Ltd. All rights reserved.
//

#import "MKGraph.h"

@implementation MKGraph

-(id)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]){
        
        xRatioFactor = 1.0;
        yRatioFactor = 1.0;
        _strokeWidth = 1.0;
        _strokeColor = [UIColor blueColor];
    }
    
    return  self;
}

-(void)drawGraph{
    
    if (_maxValueX == 0){
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Please set a max value for X- axis" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:okAction];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:true completion:nil];
        
    }else if (_maxValueY == 0){
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Please set a max value for Y- axis" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:okAction];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:true completion:nil];
        
    }else if (_arrayForValues.count <= 0){
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"No values found for plotting graph" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:okAction];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:true completion:nil];
        
    }else{
        
        CGFloat yMax = 0;
        CGFloat xMax = 0;
        
        for (int i = 0; i < _arrayForValues.count; i++ ){
            NSValue *pointValue = _arrayForValues[i];
            CGPoint point = [pointValue CGPointValue];
            
            if (point.y > yMax){
                yMax = point.y;
            }
            
            if (i == _arrayForValues.count - 1){
                xMax = point.x;
            }
        }
        
        if (yMax > _maxValueY){
            _maxValueY = yMax;
        }
        
        if (xMax > _maxValueX){
            _maxValueX = xMax;
        }
        
        xRatioFactor = _maxValueX/self.frame.size.width < 1 ? 1 : _maxValueX/self.frame.size.width;
        
        yRatioFactor = _maxValueY/self.frame.size.height < 1 ? 1 : _maxValueY/self.frame.size.height;
        
        UIBezierPath *graphPath = [UIBezierPath bezierPath];
        [graphPath moveToPoint:CGPointMake(0, 0)];
        
        for (int i = 0; i < _arrayForValues.count; i++ ){
            
            NSValue *pointValue = _arrayForValues[i];
            CGPoint point = [pointValue CGPointValue];
            CGPoint newPoint = CGPointMake(point.x/xRatioFactor, point.y/yRatioFactor);
            [graphPath addLineToPoint:newPoint];
        }
        
        
        CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
        [shapeLayer setFrame: self.bounds];
        shapeLayer.lineWidth = _strokeWidth;
        [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
        [shapeLayer setPath: [graphPath CGPath]];
        [shapeLayer setStrokeColor:[_strokeColor CGColor]];
        [shapeLayer setMasksToBounds:YES];
        [self.layer addSublayer:shapeLayer];
        
        self.transform = CGAffineTransformMakeScale(1, -1);
    }
    
    

    

}
@end
