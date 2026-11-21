//
//  CDAAppController.m
//  BMI Calculator
//
//  Created by Alsey Coleman Miller on 11/27/12.
//  Copyright (c) 2012 ColemanCDA. All rights reserved.
//

#import "CDAAppController.h"
#import "CDAMetricViewController.h"
#import "CDAEnglishViewController.h"
#import "CDAPreferencesWindowController.h"
#import "CDAMeasurementToString.h"
#import "CDABMICalculator.h"

NSString* const CDAMeasurementKey = @"Measurements";

NSString* const CDAMeasurementChangedNotification = @"CDAMeasurementsChanged";

@implementation CDAAppController

@synthesize box = _box;
@synthesize bmiViewControllers = _bmiViewControllers;
@synthesize preferences = _preferences;

-(id)init
{
    self = [super init];
    if (self) {
        
        // create the array of view controllers;
        CDAMetricViewController *metricViewController = [[CDAMetricViewController alloc] init];
        CDAEnglishViewController *englishViewController = [[CDAEnglishViewController alloc] init];
        
        _bmiViewControllers = [[NSArray alloc] initWithObjects:metricViewController, englishViewController, nil];
        [metricViewController release];
        [englishViewController release];


        // log
        CDAMeasurementToString *converter = [[CDAMeasurementToString alloc] init];
        NSLog(@"Starting app with %@ measurements", [converter convert:self.currentMeasurement.floatValue]);
        [converter release];
        
        // register for notifications
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self
               selector:@selector(handleMeasurementChange:)
                   name:CDAMeasurementChangedNotification
                 object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_bmiViewControllers release];
    [_preferences release];
    [super dealloc];
}

#pragma mark Notification handler methods

-(void)handleMeasurementChange:(NSNotification *)note
{
    int measurement = self.currentMeasurement.intValue;
    CDAMeasurementToString *converter = [[CDAMeasurementToString alloc] init];
    NSLog(@"Measurements changed to %@", [converter convert:measurement]);
    [converter release];
    [self changeViewFor:measurement];
}


#pragma mark Change View Methods

-(void)changeViewFor:(Measurement)measurement
{
    int i = measurement;
    i--;
    CDABMIViewController *vc = [self.bmiViewControllers objectAtIndex:i];
    [self changeView:vc];
}

-(void)changeView:(CDABMIViewController *)vc
{
    [_box setContentView:vc.view];
    [_box setTitle:vc.title];
}

#pragma mark Properties Methods

-(NSNumber *)currentMeasurement
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *number = [defaults objectForKey:CDAMeasurementKey];
    return number;
}

-(void)setCurrentMeasurement:(NSNumber *)currentMeasurement
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:currentMeasurement forKey:CDAMeasurementKey];
}

-(BOOL)isUserDefaultBlank
{
    if (![self currentMeasurement]) {
        return YES;
    }
    else {
        [self changeViewFor:self.currentMeasurement.intValue];
        return NO;
    }
}

#pragma mark Action Methods

- (IBAction)preferencesMenuItem:(id)sender {
    if (!_preferences) {
        _preferences = [[CDAPreferencesWindowController alloc] init];
    }
    [_preferences showWindow:self];
}

- (IBAction)calculateButton:(id)sender {
    
    NSError *error = nil;

    int i = self.currentMeasurement.intValue;
    i--;
    CDABMIViewController *vc = [self.bmiViewControllers objectAtIndex:i];
    
    float height = vc.height;
    float weight = vc.weight;
    
    Measurement measurement = self.currentMeasurement.intValue;
    
    CDAMeasurementToString *toString = [[CDAMeasurementToString alloc] init];
    
    NSLog(@"Calculating BMI for %.2f height and %.2f weight in %@ measurements", height, weight, [toString convert:measurement]);
    [toString release];

    CDABMICalculator *bmiCalculator = [[[CDABMICalculator alloc] initWithMeasurement:measurement height:height weight:weight] autorelease];
    float result = [bmiCalculator calculateWithError:&error];
    if (error) {
        [NSApp presentError:error];
        return;
    }
    
    NSString *resultString = [NSString stringWithFormat:@"Your Body Mass Index is %.2f, %@",
                              result,
                              [bmiCalculator resultMessageForBMI:result error:&error]];
    if (!error) {
        NSRunAlertPanel(@"Body Mass Index", @"%@",
                        @"OK", nil, nil, resultString);
        return;
    }
    
    // if error exist present it to the user
    [NSApp presentError:error];
}

@end
