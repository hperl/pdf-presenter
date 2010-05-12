//
//  FullscreenWindow.m
//  PDFPresenter
//
//  Created by Henning Perl on 08.05.10.
//  Copyright 2010 Henning Perl. All rights reserved.
//

#import "FullscreenWindow.h"


@implementation FullscreenWindow

- (BOOL)canBecomeKeyWindow
{
	return YES;
}

- (IBAction)cancelOperation:(id)sender
{
	SEL exitFullScreenSelector = @selector(toggleFullscreen:);	
	id target = [NSApp targetForAction:exitFullScreenSelector to:nil from:sender];
	[target performSelector:exitFullScreenSelector withObject:sender];
}

@end
