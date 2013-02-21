//
//  CDAMeasurementToString.m
//  BMI Calculator
//
//  Created by Alsey Coleman Miller on 11/27/12.
//  Copyright (c) 2012 ColemanCDA. All rights reserved.
//

#import "CDAMeasurementToString.h"
#import "CDAAppController.h"

@implementation CDAMeasurementToString

-(NSString *)convert:(int)i
{
    if (i == Metric) {
        return @"Metric";
    }
    if (i == English) {
        return @"English";
    }
    if (i == None) {
        return @"None";
    }
    else return @"?";
}

@end
