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

- (void)windowDidLoad
{
	PDFDocument* pdfDocument;
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

- (IBAction) showPreviewWindow:(id)sender
{
    [previewWindow orderFront:self];
}

@end
