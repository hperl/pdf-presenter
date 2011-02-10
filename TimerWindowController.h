//
//  TimerWindowController.h
//  PDFPresenter
//
//  Created by Henning Perl on 09.02.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface TimerWindowController : NSWindowController {
	IBOutlet NSTextField *timer;
	NSTimer *stopwatchTimer;
	NSDate *startDate;
}

- (IBAction)startStopTimer:(id)sender;
- (IBAction)resetTimer:(id)sender;

@property(assign) NSTimeInterval currentInterval;

@end
