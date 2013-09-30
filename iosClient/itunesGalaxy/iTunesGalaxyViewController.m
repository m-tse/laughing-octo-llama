//
//  iTunesGalaxyViewController.m
//  itunesGalaxy
//
//  Created by Matthew on 9/26/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import "iTunesGalaxyViewController.h"
#import "MainScene.h"
#import "SongPlanetScene.h"
#import "iTunesCurrentNode.h"
#import "SuperClusterScene.h"

#import "SimpleSpeechViewController.h"
#import "SpeechConfig.h"
#import "SpeechAuth.h"

@interface iTunesGalaxyViewController ()
- (void) speechAuthFailed: (NSError*) error;
@end

@implementation iTunesGalaxyViewController

@synthesize textLabel;
@synthesize webView;
@synthesize talkButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Configure the view.
    SKView * skView = [[SKView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:skView];
//    SKView * skView = (SKView *)self.view;
    skView.showsFPS = NO;
    skView.showsNodeCount = NO;
    
    // Create and configure the scene.
    SKScene * scene = [MainScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    [iTunesCurrentNode setCurrentScene:scene];
    [skView presentScene:scene];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(listen:)
     forControlEvents:UIControlEventTouchDown];
    [button setTitle:@"Press to Talk" forState:UIControlStateNormal];
    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    button.backgroundColor = [SKColor blackColor];
    button.center = CGPointMake(75, 1000);
    [self.view addSubview:button];
}


- (void) prepareSpeech
{
    ATTSpeechService* speechService = [ATTSpeechService sharedSpeechService];
    speechService.recognitionURL = SpeechServiceUrl();
    speechService.delegate = self;
    speechService.showUI = YES;
    speechService.speechContext = @"WebSearch";
    speechService.audioFormat = ATTSKAudioFormatSpeex_WB;
    talkButton.enabled = NO;
    [[SpeechAuth authenticatorForService: SpeechOAuthUrl()
                                  withId: SpeechOAuthKey()
                                  secret: SpeechOAuthSecret()
                                   scope: SpeechOAuthScope()]
     fetchTo: ^(NSString* token, NSError* error) {
         if (token) {
             speechService.bearerAuthToken = token;
             talkButton.enabled = YES;
         }
         else
             [self speechAuthFailed: error];
     }];
    
    [speechService prepare];
}

// Perform the action of the "Push to talk" button
- (IBAction) listen: (id) sender
{
    NSLog(@"Starting speech request");
    ATTSpeechService* speechService = [ATTSpeechService sharedSpeechService];
    speechService.xArgs =
    [NSDictionary dictionaryWithObjectsAndKeys:
     @"main", @"ClientScreen", nil];
    
    [speechService startListening];
}

// Make use of the recognition text in this app.
- (void) handleRecognition: (NSString*) recognizedText
{
    if([recognizedText isEqualToString:@"play"]) {
        [SongPlanetScene playMySong];
    }
    
    else if([recognizedText isEqualToString:@"play demons"]) {
        [SongPlanetScene playDemons];
    }
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(listen:)
     forControlEvents:UIControlEventTouchDown];
    [button setTitle:recognizedText forState:UIControlStateNormal];
    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    button.backgroundColor = [SKColor blackColor];
    button.center = CGPointMake(200, 1000);
    [self.view addSubview:button];
    
//    [self.textLabel setText: recognizedText];
    
    // Load a website using the recognized text.
    // First make the recognizedText safe for use as a search term in a URL.
//    NSString* escapedTerm =
//    [recognizedText stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
//    NSString* urlString =
//    [NSString stringWithFormat: @"http://en.m.wikipedia.org/w/index.php?search=%@", escapedTerm];
//    NSURL* url = [NSURL URLWithString: urlString];
//    NSURLRequest* request = [NSURLRequest requestWithURL: url];
//    [self.webView loadRequest:request];
}

- (void) speechServiceSucceeded: (ATTSpeechService*) speechService
{
    NSLog(@"Speech service succeeded");
    NSArray* nbest = speechService.responseStrings;
    NSString* recognizedText = @"";
    if (nbest != nil && nbest.count > 0)
        recognizedText = [nbest objectAtIndex: 0];
    if (recognizedText.length) { // non-empty?
        [self handleRecognition: recognizedText];
    }
    else {
        UIAlertView* alert =
        [[UIAlertView alloc] initWithTitle: @"Didn't recognize speech"
                                   message: @"Please try again."
                                  delegate: self
                         cancelButtonTitle: @"OK"
                         otherButtonTitles: nil];
        [alert show];
    }
}

- (void) speechService: (ATTSpeechService*) speechService
       failedWithError: (NSError*) error
{
    if ([error.domain isEqualToString: ATTSpeechServiceErrorDomain]
        && (error.code == ATTSpeechServiceErrorCodeCanceledByUser)) {
        NSLog(@"Speech service canceled");
        // Nothing to do in this case
        return;
    }
    NSLog(@"Speech service had an error: %@", error);
    
    UIAlertView* alert =
    [[UIAlertView alloc] initWithTitle: @"An error occurred"
                               message: @"Please try again later."
                              delegate: self
                     cancelButtonTitle: @"OK"
                     otherButtonTitles: nil];
    [alert show];
}

/* The SpeechAuth authentication failed. */
- (void) speechAuthFailed: (NSError*) error
{
    NSLog(@"OAuth error: %@", error);
    UIAlertView* alert =
    [[UIAlertView alloc] initWithTitle: @"Speech Unavailable"
                               message: @"This app was rejected by the speech service.  Contact the developer for an update."
                              delegate: self
                     cancelButtonTitle: @"OK"
                     otherButtonTitles: nil];
    [alert show];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


@end
