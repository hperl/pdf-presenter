//
//  MainWindowController.h
//  PDFPresenter
//
//  Created by Henning Perl on 06.05.10.
//  Copyright 2010 Henning Perl. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>
#import "SyncronizedPDFView.h"
#import "PreviewPDFView.h"

@interface MainWindowController : NSWindowController {
	IBOutlet SyncronizedPDFView *mainPDFView;
	IBOutlet PreviewPDFView *previewPDFView;
	IBOutlet NSTextField *timer;
	IBOutlet NSImageView *resetButton;
	IBOutlet NSButton *startStopButton;
	NSTimer *stopwatchTimer;
	NSDate *startDate;
}
- (void)updateStatusbar:(NSNotification *)notification;

- (IBAction)startStopTimer:(id)sender;
- (IBAction)resetTimer:(id)sender;

@property(assign) NSString *currentAndTotalPages;
@property(assign) NSTimeInterval currentInterval;
@end


