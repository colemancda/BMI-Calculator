//
//  CDAPreferencesWindowController.m
//  BMI Calculator
//
//  Created by Alsey Coleman Miller on 11/27/12.
//  Copyright (c) 2012 ColemanCDA. All rights reserved.
//

#import "CDAPreferencesWindowController.h"
#import "CDAAppController.h"

@interface CDAPreferencesWindowController ()

@end

@implementation CDAPreferencesWindowController

-(id)init
{
    self = [super initWithWindowNibName:@"PreferencesWindow"];
    if (self) {
        
    }
    return self;
}

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

-(void)awakeFromNib
{
    if (self.currentMeasurement.intValue == None ) {
        self.metric = YES;
    }
}

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
    
    // notify the notification center
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:CDAMeasurementChangedNotification object:self];
}

-(BOOL)metric
{
    if (self.currentMeasurement.intValue == Metric) {
        return YES;
    }
    return NO;
}

-(void)setMetric:(BOOL)metric
{
    if (metric) {
        self.currentMeasurement = [NSNumber numberWithInt:Metric];
    }
    if (!metric) {
        self.currentMeasurement = [NSNumber numberWithInt:English];
    }
}

@end
