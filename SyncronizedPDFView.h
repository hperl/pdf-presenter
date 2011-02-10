//
//  SyncronizedPDFView.h
//  PDFPresenter
//
//  Created by Henning Perl on 12.05.10.
//  Copyright 2010 Henning Perl. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

@class PreviewPDFView;

@interface SyncronizedPDFView : PDFView {

}
- (void)updatePage:(NSNotification *)notification;

@end
