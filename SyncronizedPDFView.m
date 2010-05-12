//
//  SyncronizedPDFView.m
//  PDFPresenter
//
//  Created by Henning Perl on 12.05.10.
//  Copyright 2010 Henning Perl. All rights reserved.
//

#import "SyncronizedPDFView.h"


@implementation SyncronizedPDFView

- (void)setDocument:(PDFDocument *)document
{
	[super setDocument:document];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(updatePage:)
												 name:@"PDFPageChanged"
											   object:nil];
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"PDFPageChanged" object:nil];
	[super dealloc];
}

- (void)updatePage:(NSNotification *)notification
{
	PDFView *reference = [notification object];
	NSLog(@"Got Notified!");
	if (reference != self) {
		[self goToPage:[reference currentPage]];
	}
}

@end
