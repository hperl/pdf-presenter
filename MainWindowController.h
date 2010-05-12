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
	IBOutlet NSTextField *statusBar;
	IBOutlet NSTextField *timer;
}
- (void)updateStatusbar:(NSNotification *)notification;

@end
