//
//  MainWindowController.m
//  PDFPresenter
//
//  Created by Henning Perl on 06.05.10.
//  Copyright 2010 Henning Perl. All rights reserved.
//

#import "MainWindowController.h"
#import "FullscreenWindow.h"
#import "MyDocument.h"

@implementation MainWindowController
@synthesize currentAndTotalPages;
@synthesize currentInterval;

- (void)windowDidLoad
{
	PDFDocument *pdfDocument;
	pdfDocument = [[PDFDocument alloc] initWithURL: [NSURL fileURLWithPath: [[self document] fileName]]];
	[mainPDFView setDocument: pdfDocument];
	[previewPDFView setDocument: pdfDocument];
	[pdfDocument release];
	
	[previewPDFView setBackgroundColor:[NSColor colorWithDeviceWhite:0.0 alpha:0.0]];
	
	[self.document setMainPdfView:mainPDFView];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"PDFPageChanged" object:mainPDFView];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(updateStatusbar:)
												 name:@"PDFPageChanged" 
											   object:nil];
	[self updateStatusbar:nil];
}

- (void)updateStatusbar:(NSNotification *)notification
{
	int totalPages = [[mainPDFView document] pageCount];
	int currentPage = [[mainPDFView document] indexForPage:[mainPDFView currentPage]] + 1;
	self.currentAndTotalPages = [NSString stringWithFormat:@"Seite %i von %i", currentPage, totalPages];
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
