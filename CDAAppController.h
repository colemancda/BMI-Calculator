//
//  CDAAppController.h
//  BMI Calculator
//
//  Created by Alsey Coleman Miller on 11/27/12.
//  Copyright (c) 2012 ColemanCDA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDABMICalculator.h"
#import "CDABMIViewController.h"

@class CDAPreferencesWindowController;

extern NSString* const CDAMeasurementKey;

extern NSString* const CDAMeasurementChangedNotification;

@interface CDAAppController : NSObject

@property IBOutlet NSBox *box;

@property NSArray *bmiViewControllers;

@property CDAPreferencesWindowController *preferences;

@property NSNumber *currentMeasurement;

@property (readonly) BOOL isUserDefaultBlank;

-(void)changeViewFor:(Measurement)measurement;

-(void)changeView:(CDABMIViewController *)vc;

-(void)handleMeasurementChange:(NSNotification *)note;

- (IBAction)preferencesMenuItem:(id)sender;

-(IBAction)calculateButton:(id)sender;

@end
