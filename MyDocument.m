//
//  MyDocument.m
//  PDFPresenter
//
//  Created by Henning Perl on 06.05.10.
//  Copyright 2010 Henning Perl. All rights reserved.
//

#import "MyDocument.h"
#import "MainWindowController.h"
#import "FullscreenWindow.h"

@implementation MyDocument

@synthesize mainPdfView;

- (id)init
{
    self = [super init];
    if (self) {
		nc = [NSNotificationCenter defaultCenter];
    }
    return self;
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document
	// supports multiple NSWindowControllers, you should remove this method and
	// override -makeWindowControllers instead.
    return @"MyDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *) aController
{
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
    if ( outError != NULL ) {
		*outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:NULL];
	}
	return nil;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
   if ( outError != NULL ) {
		*outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:NULL];
	}
    return YES;
}

- (void) makeWindowControllers
{
	MainWindowController	*controller;
	
	// Create controller.
	controller = [[MainWindowController alloc] initWithWindowNibName: [self windowNibName]];
	[self addWindowController: controller];
	
	// Done.
	[controller release];
}

#pragma mark fullscreen
- (void)setFullscreen:(BOOL)toFullscreen
{	
	if (isFullscreen == toFullscreen)
		return;
	
	isFullscreen = toFullscreen;
	
	if (toFullscreen) {
		// Since we want to ensure that in fullscreen mode we always cover exactly
		// the area of a single screen, register for screen config notifications
		[nc addObserver: self selector: @selector(screenParametersDidChange:)
				   name: NSApplicationDidChangeScreenParametersNotification object:NSApp];
		
		BOOL multihead = [[NSScreen screens] count] > 1 ? YES : NO;
		// Fullscreen auf den letzten screen setzen (meinst: Beamer)
		fullscreenScreen = [[[NSScreen screens] lastObject] retain];
		NSRect screenRect = [fullscreenScreen frame];
		
		FullscreenWindow *fullscreenWindow = [[[FullscreenWindow alloc] initWithContentRect:screenRect
																				  styleMask:NSBorderlessWindowMask
																					backing:NSBackingStoreBuffered
																					  defer:NO] autorelease];
		[fullscreenWindow setBackgroundColor:[NSColor blackColor]];
		
		// setup fullscreen WC
		fullscreenWindowController = [[NSWindowController alloc] initWithWindow:fullscreenWindow];
		[self addWindowController:fullscreenWindowController];
		
		// pdfView -> fullscreen
		fullscreenPdfView = [[[SyncronizedPDFView alloc] initWithFrame:[[fullscreenWindow contentView] bounds]] autorelease];
		[fullscreenPdfView setDisplayMode:kPDFDisplaySinglePage];
		[fullscreenPdfView setBackgroundColor:[NSColor blackColor]];
		[fullscreenPdfView setAutoScales: YES];
		[fullscreenPdfView setDocument: [mainPdfView document]];
		[nc postNotificationName:@"PDFPageChanged" object:mainPdfView];
		
		[[fullscreenWindow contentView] addSubview: fullscreenPdfView];
		
		[fullscreenPdfView setPostsBoundsChangedNotifications:YES];
		
		// fullscreen to front
		[fullscreenWindowController showWindow:self];
		
		savedPresentationOptions = [NSApp presentationOptions];
		if (!multihead) {
			[NSApp setPresentationOptions:(NSApplicationPresentationAutoHideDock | NSApplicationPresentationAutoHideMenuBar)];
		}
	} else {
		[nc removeObserver: self
					  name: NSApplicationDidChangeScreenParametersNotification object: NSApp];
		[fullscreenScreen release];
		fullscreenScreen = nil;
				
		// Get rid of the fullscreen windows
		[fullscreenWindowController close];
		[fullscreenWindowController release];
		fullscreenWindowController = nil;
		
		// Restore previous presentation options
		[NSApp setPresentationOptions:savedPresentationOptions];
	}
}

- (IBAction)toggleFullscreen:(id)sender 
{
	[self setFullscreen:!isFullscreen];
}

- (void)screenParametersDidChange:(NSNotification *)notification
{
	if ([[NSScreen screens] containsObject:fullscreenScreen]) {
		// The screen is still there, but may have changed resolution
		
		NSWindow *fullscreenWindow = [fullscreenWindowController window];
		NSRect screenRect = [fullscreenScreen frame];
		if (!NSEqualRects([fullscreenWindow frame], screenRect)) {
			[fullscreenWindow setFrame:screenRect display:YES];
		}
	} else {
		// That other screen is gone now.  Our best bet is just to break out of fullscreen mode.
		[self setFullscreen:NO];
	}
}

#pragma mark Navigation
- (IBAction)nextPage:(id)sender
{
	[mainPdfView goToNextPage:sender];
	[nc postNotificationName:@"PDFPageChanged" object:mainPdfView];
}

- (IBAction)previousPage:(id)sender
{
	[mainPdfView goToPreviousPage:sender];
	[nc postNotificationName:@"PDFPageChanged" object:mainPdfView];
}

@end
