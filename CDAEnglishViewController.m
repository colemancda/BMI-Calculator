//
//  CDAEnglishViewController.m
//  BMI Calculator
//
//  Created by Alsey Coleman Miller on 11/27/12.
//  Copyright (c) 2012 ColemanCDA. All rights reserved.
//

#import "CDAEnglishViewController.h"

@interface CDAEnglishViewController ()

@end

@implementation CDAEnglishViewController

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
    self = [super initWithNibName:@"EnglishView" bundle:nil];
    if (self) {
        [self setTitle:@"English"];
    }
    return self;
}

-(float)height
{
    float result = self.inches  + (self.feet * 12);
    return result;
}

-(float)weight
{
    return self.pounds;
}



@end
