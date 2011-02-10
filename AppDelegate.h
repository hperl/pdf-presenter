//
//  AppDelegate.h
//  PDFPresenter
//
//  Created by Henning Perl on 10.02.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class RemoteControl;
@class TimerWindowController;

@interface AppDelegate : NSObject {
	TimerWindowController* timerWC;
    RemoteControl* remoteControl;
}

- (IBAction)showTimerWindow:(id)sender;
- (RemoteControl*) remoteControl;
- (void) setRemoteControl: (RemoteControl*) newControl;

@end
