//
//  TimerWindowController.h
//  PDFPresenter
//
//  Created by Henning Perl on 09.02.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface TimerWindowController : NSWindowController {
    @private
	IBOutlet NSTextField *timer;
	NSTimer *stopwatchTimer;
	NSDate *startDate;
    NSTimeInterval currentInterval;
}

- (IBAction)startStopTimer:(id)sender;
- (IBAction)resetTimer:(id)sender;

@property(assign) NSTimeInterval currentInterval;

@end
