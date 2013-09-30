//
//  iTunesGalaxyViewController.h
//  itunesGalaxy
//

//  Copyright (c) 2013 MTA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "ATTSpeechKit.h"

@interface iTunesGalaxyViewController : UIViewController <ATTSpeechServiceDelegate>

@property (retain, nonatomic) IBOutlet UILabel* textLabel;
@property (retain, nonatomic) IBOutlet UIWebView* webView;
@property (retain, nonatomic) IBOutlet UIButton* talkButton;

// Initialize SpeechKit for this app.
- (void) prepareSpeech;

// Message sent by "Press to Talk" button in UI
- (IBAction) listen: (id) sender;

@end
