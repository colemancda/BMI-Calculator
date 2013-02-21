//
//  CDABMICalculator.h
//  BMI Calculator
//
//  Created by Alsey Coleman Miller on 11/27/12.
//  Copyright (c) 2012 ColemanCDA. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(int , Measurement) {
    None = 0,
    Metric,
    English
};

#define kErrorDomain @"com.ColemanCDA.FBApp.ErrorDomain"

@interface CDABMICalculator : NSObject

@property Measurement measurement;

@property float height;

@property float weight;

- (id)initWithMeasurement:(Measurement)measurement
                   height:(float)height
                   weight:(float)height;

-(float)calculateWithError:(NSError **)error;

-(NSString *)resultMessageForBMI:(float)bmi error:(NSError **)error;


@end
