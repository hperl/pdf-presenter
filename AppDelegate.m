//
//  AppDelegate.m
//  PDFPresenter
//
//  Created by Henning Perl on 10.02.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "AppleRemote.h"
#import "TimerWindowController.h"
#import "MyDocument.h"


@implementation AppDelegate

- (void) dealloc {
	[remoteControl autorelease];
	[super dealloc];
}


#pragma mark Remote Control
- (void)applicationWillBecomeActive:(NSNotification *)aNotification {
	NSLog(@"Application will become active - Using remote controls");
	[remoteControl startListening: self];
}

- (void)applicationWillResignActive:(NSNotification *)aNotification {
	NSLog(@"Application will resign active - Releasing remote controls");
	[remoteControl stopListening: self];
}

- (void)awakeFromNib {
	AppleRemote* newRemoteControl = [[[AppleRemote alloc] initWithDelegate: self] autorelease];
	[newRemoteControl setDelegate: self];
	
	// set new remote control which will update bindings
	[self setRemoteControl: newRemoteControl];
}

// for bindings access
- (RemoteControl *)remoteControl {
	return remoteControl;
}

- (void)setRemoteControl: (RemoteControl*) newControl {
	[remoteControl autorelease];
	remoteControl = [newControl retain];
}

- (void)sendRemoteButtonEvent:(RemoteControlEventIdentifier)buttonIdentifier pressedDown:(BOOL) pressedDown remoteControl:(RemoteControl *) remote
{
    if (pressedDown) {
        switch (buttonIdentifier) {
            case kRemoteButtonRight:
                NSLog(@"Remote: Nächste Folie");
                [(MyDocument*)[[NSDocumentController sharedDocumentController] currentDocument] nextPage:self];
                break;
                
            case kRemoteButtonLeft:
                [(MyDocument*)[[NSDocumentController sharedDocumentController] currentDocument] previousPage:self];
                NSLog(@"Remote: Vorherige Folie");
                
            default:
                break;
        }
    }
}

#pragma mark Timer Window
- (IBAction)showTimerWindow:(id)sender
{
    if (timerWC == nil) {
        timerWC = [[[TimerWindowController alloc] initWithWindowNibName:@"TimerWindow"] retain];
    }
	[timerWC showWindow:self];
}

@end
