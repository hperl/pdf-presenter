//
//  SyncronizedPDFView.m
//  PDFPresenter
//
//  Created by Henning Perl on 12.05.10.
//  Copyright 2010 Henning Perl. All rights reserved.
//

#import "SyncronizedPDFView.h"
#import "PreviewPDFView.h"

@implementation SyncronizedPDFView


- (void)setDocument:(PDFDocument *)document
{
	if ([self document] == nil) {
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(updatePage:)
													 name:@"PDFPageChanged"
												   object:nil];
	}
	[super setDocument:document];
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"PDFPageChanged" object:nil];
	[super dealloc];
}

// [nc postNotificationName:@"PDFPageChanged" object:mainPdfView];
- (void)updatePage:(NSNotification *)notification
{
	PDFView *reference = [notification object];
	NSLog(@"Got Notified!");
	if (reference != self) {
		[self goToPage:[reference currentPage]];
		if ([reference isKindOfClass:[PreviewPDFView class]]) {
			[self goToPreviousPage:nil];
		}
	}
}

- (IBAction)goToNextPage:(id)sender
{
	[super goToNextPage:sender];
	if (sender != nil) {
		// notify others
		[[NSNotificationCenter defaultCenter] postNotificationName:@"PDFPageChanged" object:self];
	}
}

- (IBAction)goToPreviousPage:(id)sender
{
	[super goToPreviousPage:sender];
	if (sender != nil) {
		// notify others
		[[NSNotificationCenter defaultCenter] postNotificationName:@"PDFPageChanged" object:self];
	}
}

- (void)performAction:(PDFAction *)action
{
    [super performAction:action];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PDFPageChanged" object:self];
}

@end
