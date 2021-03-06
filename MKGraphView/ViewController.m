//
//  ViewController.m
//  MKGraphView
//
//  Created by Manish Kumar on 22/06/16.
//  Copyright © 2016 Innofied Solutions Pvt. Ltd. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    MKGraph *graph = [[MKGraph alloc]initWithFrame:CGRectMake(10.0, 100.0, self.view.frame.size.width - 20.0, 200.0)]  ;
    graph.backgroundColor = [UIColor clearColor];
    graph.strokeWidth = 2.0;
    graph.strokeColor = [UIColor greenColor];
    graph.allowAnimation = true;
    graph.isSolidStroke = false;
    graph.showValuePointsOnGraph = true;
    graph.setFillColor = true;
    graph.arrayForValues = [[NSMutableArray alloc]init];
    [graph.arrayForValues addObject: [NSValue valueWithCGPoint: CGPointMake(0, 0)]];
    [graph.arrayForValues addObject: [NSValue valueWithCGPoint: CGPointMake(23, 23)]];
    [graph.arrayForValues addObject: [NSValue valueWithCGPoint: CGPointMake(56, 106)]];
    [graph.arrayForValues addObject: [NSValue valueWithCGPoint: CGPointMake(106, 62)]];
    [graph.arrayForValues addObject: [NSValue valueWithCGPoint: CGPointMake(173, 98)]];
    [graph.arrayForValues addObject: [NSValue valueWithCGPoint: CGPointMake(238, 105)]];
    [graph.arrayForValues addObject: [NSValue valueWithCGPoint: CGPointMake(290, 150)]];
//    [graph.arrayForValues addObject: [NSValue valueWithCGPoint: CGPointMake(310, 155)]];
//    [graph.arrayForValues addObject: [NSValue valueWithCGPoint: CGPointMake(400, 145)]];
//    [graph.arrayForValues addObject: [NSValue valueWithCGPoint: CGPointMake(510, 188)]];
//    [graph.arrayForValues addObject: [NSValue valueWithCGPoint: CGPointMake(550, 201)]];
//    [graph.arrayForValues addObject: [NSValue valueWithCGPoint: CGPointMake(625, 325)]];
//    [graph.arrayForValues addObject: [NSValue valueWithCGPoint: CGPointMake(701, 67)]];
//    [graph.arrayForValues addObject: [NSValue valueWithCGPoint: CGPointMake(800, 89)]];
//    [graph.arrayForValues addObject: [NSValue valueWithCGPoint: CGPointMake(805, 222)]];

    [self.view addSubview:graph];

    [graph drawGraph];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
