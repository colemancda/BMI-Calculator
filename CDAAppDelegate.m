//
//  CDAAppDelegate.m
//  BMI Calculator
//
//  Created by Alsey Coleman Miller on 11/27/12.
//  Copyright (c) 2012 ColemanCDA. All rights reserved.
//

#import "CDAAppDelegate.h"

@implementation CDAAppDelegate

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

-(BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return YES;
}

@end
