//
//  PreviewPDFView.m
//  PDFPresenter
//
//  Created by Henning Perl on 12.05.10.
//  Copyright 2010 Henning Perl. All rights reserved.
//

#import "PreviewPDFView.h"


@implementation PreviewPDFView

- (void)updatePage:(NSNotification *)notification
{
	PDFView *reference = [notification object];
	NSLog(@"Got Notified! (Preview)");
	if (reference != self) {
		[self goToPage:[reference currentPage]];
		[self goToNextPage:self];
	}
}

@end
