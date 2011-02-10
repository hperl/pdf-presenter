//
//  TimerWindowController.m
//  PDFPresenter
//
//  Created by Henning Perl on 09.02.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TimerWindowController.h"


@implementation TimerWindowController

@synthesize currentInterval;

- (NSString *)windowTitleForDocumentDisplayName:(NSString *)displayName
{
	return @"Stoppuhr";
}


- (IBAction)startStopTimer:(id)sender
{
	if ([(NSButton *)sender state] == 1) {
		NSLog(@"Stoppuhr gestartet.");
		
		if (startDate) {
			// resume time
			[startDate release];
			startDate = [[NSDate dateWithTimeIntervalSinceNow:-currentInterval] retain];
		} else {
			// start new time
			startDate = [[NSDate date] retain];
		}
		
		
		stopwatchTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self
														selector:@selector(tick:)
														userInfo:nil repeats:YES];
		
		[stopwatchTimer fire];
	} else {
		NSLog(@"Stoppuhr gestoppt.");
		
		[stopwatchTimer invalidate];
		stopwatchTimer = nil;
	}
}

- (void)tick:(NSTimer *)theTimer
{
	currentInterval = -[startDate timeIntervalSinceNow];
    int seconds = ((int) currentInterval) % 60;
    int minutes = ((int) (currentInterval - seconds) / 60) % 60;
    int hours = ((int) currentInterval - seconds - 60 * minutes) % 3600;
	
    [timer setStringValue:[NSString stringWithFormat:@"%.2d:%.2d:%.2d",
						   hours, minutes, seconds]];
}

- (IBAction)resetTimer:(id)sender
{
	if (startDate) {
		NSDate *oldDate = startDate;
		startDate = [[NSDate date] retain];
		[oldDate release];
		[timer setStringValue:[NSString stringWithFormat:@"%.2d:%.2d:%.2d", 0, 0, 0]];
	}
	currentInterval = 0;
}

@end
