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
	IBOutlet SyncronizedPDFView* mainPDFView;
	IBOutlet PreviewPDFView* previewPDFView;
    IBOutlet NSPanel* previewWindow;
    
    @private
    NSString *currentAndTotalPages;
}
- (void)updateStatusbar:(NSNotification *)notification;
- (IBAction) showPreviewWindow:(id)sender;

@property(assign) NSString *currentAndTotalPages;
@end
