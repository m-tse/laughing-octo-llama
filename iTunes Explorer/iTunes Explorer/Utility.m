//
//  Utility.m
//  iTunes Explorer
//
//  Created by Tianyu Shi on 9/27/13.
//  Copyright (c) 2013 Tianyu Shi, Matt Tse, Andrew Shim. All rights reserved.
//

#import "Utility.h"
#import "NetworkConstants.h"

@interface Utility()
@property NSMutableData *data;
@end

@implementation Utility

@synthesize data = _data;

// CONSTANTS
NSString *const REQUEST_LIMIT = @"&limit=";
NSString *const GENRE_QUERY = @"&genre=";
int const MAX_LIMIT = 1000;

static NSString *serverAddress;

+ (NSString*)serverAddress {
    if (serverAddress == NULL) return HOST;
    else return serverAddress;
}

+ (void)setServerAddress:(NSString *) address {
    serverAddress = address;
}

+ (NSMutableArray *)getTracksInGenre:(NSString *)genre
                        numRequested:(int)numRequested {
    
    NSMutableString *url = [[NSMutableString alloc] init];
    [url appendString:[Utility serverAddress]];
    [url appendString:GENRE_QUERY];
    [url appendString:genre];
    
    NSMutableString *limit = [[NSMutableString alloc] init];
    [limit appendString:REQUEST_LIMIT];
    
    if (numRequested >= 0) [limit appendString:[NSString stringWithFormat:@"%i", numRequested]];
    else [limit appendString:[NSString stringWithFormat:@"%i", MAX_LIMIT]];
    
    [url appendString:limit];
    
    return NULL;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
        NSLog(RECIEVED_RESPONSE);
        [self.data setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
        [self.data appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
        NSLog(CONNECTION_ERROR);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading");
    
    // convert to JSON
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingMutableLeaves error:&myError];
    
    // show all values
    for(id key in res) {
        
        id value = [res objectForKey:key];
        
        NSString *keyAsString = (NSString *)key;
        NSString *valueAsString = (NSString *)value;
        
        NSLog(@"key: %@", keyAsString);
        NSLog(@"value: %@", valueAsString);
    }
    
    // extract specific value...
    NSArray *results = [res objectForKey:@"results"];
    
    for (NSDictionary *result in results) {
        NSString *icon = [result objectForKey:@"icon"];
        NSLog(@"icon: %@", icon);
    }
}

@end
