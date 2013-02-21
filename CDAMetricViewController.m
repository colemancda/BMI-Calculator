//
//  CDAMetricViewController.m
//  BMI Calculator
//
//  Created by Alsey Coleman Miller on 11/27/12.
//  Copyright (c) 2012 ColemanCDA. All rights reserved.
//

#import "CDAMetricViewController.h"

@interface CDAMetricViewController ()

@end

@implementation CDAMetricViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(id)init
{
    self = [super initWithNibName:@"MetricView" bundle:nil];
    if (self) {
        [self setTitle:@"Metric"];
    }
    return self;
}

-(float)height
{
    NSLog(@"height = %.2f m", self.m);
    return self.m;
}

-(float)weight
{
    NSLog(@"weight = %.2f kg", self.kg);
    return self.kg;
}

@end
