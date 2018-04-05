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
        
        //creating x- axis
        UIView *viewForHorizontalAxis = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, frame.size.width, 1.0)];
        viewForHorizontalAxis.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.8];
        [self addSubview:viewForHorizontalAxis];
        
        //creating y-axis
        UIView *viewForVerticalAxis = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, 1.0, frame.size.height)];
        viewForVerticalAxis.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.8];
        [self addSubview:viewForVerticalAxis];

        //initializing graph constraints
        xRatioFactor = 1.0;
        yRatioFactor = 1.0;
        _strokeWidth = 1.0;
        _allowAnimation = false;
        _showValuePointsOnGraph = false;
        _isSolidStroke = true;
        _strokeColor = [UIColor blueColor];
    }
    
    return  self;
}

-(void)drawGraph{
    
    //checking if coordinates are there or not
   if (_arrayForValues.count <= 0){
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"No values found for plotting graph" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:okAction];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:true completion:nil];
        
    }else{
        
        //============================================================================================//
        //1. Checking for the max X value and max Y value in the graph.
        //2. Reassign variables _maxValueX and _maxValueY in case they are smaller than above values
        //3. Finding the xRatioFactor and yRatioFactor to recalculate points in case the _maxValueX and _maxValueY are greater than frame bounds
        //4. Create a UIBezierPath using those recalculated points
        //5. Adding the path in a CAShapeLayer for creating graph
        //6. Transformation of layer to readjust layer coordinates
        //============================================================================================//
        
        //Checking for the max X value and max Y value in the graph.
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
        
        //Reassign variables _maxValueX and _maxValueY in case they are smaller than above values
        if (yMax > _maxValueY){
            _maxValueY = yMax;
        }
        
        if (xMax > _maxValueX){
            _maxValueX = xMax;
        }
        
        //increasing _maxValueX and _maxValueY for providing padding to max X and max Y value graph points
        _maxValueY += 10;
        _maxValueX += 10;

        
        
        //Finding the xRatioFactor and yRatioFactor to recalculate points in case the _maxValueX and _maxValueY are greater than frame bounds
        xRatioFactor = _maxValueX/self.frame.size.width < 1 ? 1 : _maxValueX/self.frame.size.width;
        yRatioFactor = _maxValueY/self.frame.size.height < 1 ? 1 : _maxValueY/self.frame.size.height;
        
        //Create a UIBezierPath using those recalculated points
        UIBezierPath *graphPath = [UIBezierPath bezierPath];
        [graphPath moveToPoint:CGPointMake(0, 0)];
        
        for (int i = 0; i < _arrayForValues.count; i++ ){
            
            NSValue *pointValue = _arrayForValues[i];
            CGPoint point = [pointValue CGPointValue];
            CGPoint newPoint = CGPointMake(point.x/xRatioFactor, point.y/yRatioFactor);
            [graphPath addLineToPoint:newPoint];
        }
         
        
        //Adding the path in a CAShapeLayer for creating graph
        CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
        [shapeLayer setFrame: self.bounds];
        shapeLayer.lineWidth = _strokeWidth;
        
        if (!_isSolidStroke){
            shapeLayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInteger:6],[NSNumber numberWithInteger:4], nil];
        }
        
        [shapeLayer setFillColor:[[_strokeColor colorWithAlphaComponent:0.3]CGColor]];
        [shapeLayer setPath: [graphPath CGPath]];
        [shapeLayer setStrokeColor:[_strokeColor CGColor]];
        [shapeLayer setMasksToBounds:YES];
        [self.layer addSublayer:shapeLayer];

        
        if (_showValuePointsOnGraph){
            [self addBoundaryPointToGraph];
        }
        
        //Transformation of layer to readjust layer coordinates
        self.transform = CGAffineTransformMakeScale(1, -1);

        if(_allowAnimation){
            [self addAnimationToShapeLayer:shapeLayer];
        }
    }
}

-(void)addAnimationToShapeLayer:(CAShapeLayer *)layer{
    
    //provide stroke animation to graph
    CABasicAnimation *stroke = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    stroke.fromValue = @(0);
    stroke.toValue = @(1);
    stroke.repeatCount = 1;
    stroke.duration = 1.0f;
    stroke.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [layer addAnimation:stroke forKey:nil];

}


-(void)addBoundaryPointToGraph{
    
    //Create a UIBezierPath using those recalculated points
    for (int i = 0; i < _arrayForValues.count; i++ ){
        
        UIBezierPath *graphPath = [UIBezierPath bezierPath];

        NSValue *pointValue = _arrayForValues[i];
        CGPoint point = [pointValue CGPointValue];
        CGPoint newPoint = CGPointMake(point.x/xRatioFactor, point.y/yRatioFactor);
        
        [graphPath moveToPoint:newPoint];
        [graphPath addArcWithCenter:newPoint radius:3.0 startAngle:0.0 endAngle:2  * M_PI clockwise:true];
        
        CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
        [shapeLayer setFrame: self.bounds];
        shapeLayer.lineWidth = 1.0;
        [shapeLayer setFillColor:[_strokeColor CGColor]];
        [shapeLayer setPath: [graphPath CGPath]];
        [shapeLayer setStrokeColor:[_strokeColor CGColor]];
        [shapeLayer setMasksToBounds:YES];
        [self.layer addSublayer:shapeLayer];
    }
    
}

@end
