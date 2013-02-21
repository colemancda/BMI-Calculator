//
//  CDABMICalculator.m
//  BMI Calculator
//
//  Created by Alsey Coleman Miller on 11/27/12.
//  Copyright (c) 2012 ColemanCDA. All rights reserved.
//

#import "CDABMICalculator.h"

@implementation CDABMICalculator

- (id)init
{
    self = [super init];
    if (self) {
        self.measurement = None; // None = 0
        self.height = 0;
        self.weight = 0;
    }
    return self;
}

-(id)initWithMeasurement:(Measurement)measurement height:(float)height weight:(float)weight
{
    self = [super init];
    if (self) {
        self.measurement = measurement;
        self.height = height;
        self.weight = weight;
    }
    return self;
}

-(float)calculateWithError:(NSError *__autoreleasing *)error
{
    // check if a property is zero
    if (_measurement == 0 || _height == 0 || _weight == 0) {
        // count how many properties are not set.
        NSArray *properties =
        @[[NSNumber numberWithFloat:_measurement],
        [NSNumber numberWithFloat:_height],
        [NSNumber numberWithFloat:_weight]];
        int count = 0;
        for (NSNumber *number in properties) {
            if ([number floatValue] == 0.0) {
                count++;
            }
        }
        NSString *errorDescription = [NSString stringWithFormat:@"%d properties where not set.", count];
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey : errorDescription};
        *error = [NSError errorWithDomain:kErrorDomain
                                     code:102
                                 userInfo:userInfo];
    }
    
    // calculate for metric
    if (self.measurement == Metric) {
        return _weight / (_height * _height);
    }
    
    // calculate for english
    if (self.measurement == English) {
        return (_weight / (_height * _height)) * 703;
    }
    
    // if error
    return 0;
}

-(NSString *)resultMessageForBMI:(float)bmi error:(NSError *__autoreleasing *)error
{
    if (bmi < 0) {
        NSString *errorDescription = [NSString stringWithFormat:@"Your BMI is a negative number.  (BMI = %.2f)", bmi];
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey : errorDescription};
        *error = [NSError errorWithDomain:kErrorDomain
                                     code:103
                                 userInfo:userInfo];
        return nil;
    }
    if (bmi < 18.5) {
        return @"you might be underweight.";
    }
    
    if (18.5 <= bmi && bmi <= 24.9) {
        return @"you have a normal Body Mass Index.";
    }
    
    if (24.9 < bmi && bmi <= 29.9) {
        return @"you may be overweight.";
    }
    
    if (29.9 < bmi && !isinf(bmi)) {
        return @"you may be obese.";
    }
    
    // if error
    NSString *errorDescription = [NSString stringWithFormat:@"Your BMI is not in the valid range. (BMI = %.2f)", bmi ];
    NSDictionary *userInfo = @{NSLocalizedDescriptionKey : errorDescription};
    *error = [NSError errorWithDomain:kErrorDomain
                                 code:104
                             userInfo:userInfo];
    return nil;
}

@end
