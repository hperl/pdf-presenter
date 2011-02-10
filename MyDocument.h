//
//  MyDocument.h
//  PDFPresenter
//
//  Created by Henning Perl on 06.05.10.
//  Copyright 2010 Henning Perl. All rights reserved.
//


#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>
#import "SyncronizedPDFView.h"

@interface MyDocument : NSDocument {
	NSNotificationCenter	*nc;
	
	// PDF views
	SyncronizedPDFView		*fullscreenPdfView;
	
	// fullscreen
	NSRect					originalPdfViewFrame;
	BOOL					isFullscreen;
	NSWindowController		*fullscreenWindowController;
	NSScreen				*fullscreenScreen;
	NSApplicationPresentationOptions savedPresentationOptions;
}

@property (assign) PDFView *mainPdfView;

- (IBAction)toggleFullscreen:(id)sender;
- (IBAction)previousPage:(id)sender;
- (IBAction)nextPage:(id)sender;
- (IBAction)showPreviewWindow:(id)sender;

@end
