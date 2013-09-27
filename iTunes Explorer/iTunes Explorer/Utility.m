//
//  Utility.m
//  iTunes Explorer
//
//  Created by Tianyu Shi on 9/27/13.
//  Copyright (c) 2013 Tianyu Shi, Matt Tse, Andrew Shim. All rights reserved.
//

#import "Utility.h"
#import "NetworkConstants.h"

@implementation Utility

// HTTP string to define a maximum # of results
NSString *const REQUEST_LIMIT = @"&limit=";

static NSString *serverAddress;

+ (NSString*)serverAddress {
    if (serverAddress == NULL) return HOST;
    else return serverAddress;
}

+ (void)setServerAddress:(NSString *) address {
    serverAddress = address;
}

+ (NSMutableArray *)getRelatedGenres:(NSString *)genre
                        numRequested:(int)numRequested {
    
    NSMutableString *url = [[NSMutableString alloc] init];
    [url appendString:[Utility serverAddress]];
    
    if (numRequested <= 0) {
        NSMutableString *limit = [[NSMutableString alloc] init];
        [limit appendString:REQUEST_LIMIT];
        [limit appendString:[NSString stringWithFormat:@"%i", numRequested]];
    }
    
    
    
    return NULL;
}

+ (NSMutableArray *)getSongsInGenre:(NSString *)genre
                       numRequested:(int)numRequested {
    return NULL;
}

+ (void)incrementGenreCount:(NSString *)genre {
    //    NSString *url =
    //    NSString *count = [passData];
}

- (NSString *) passData:(NSString *)url
                   data: (NSData*) body
      getIfTrueElsePost: (BOOL) httpGetIfTruePostIfFalse {
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    if(httpGetIfTruePostIfFalse) {
        [request setHTTPMethod:GET];
    } else {
        // Depends on implementation
        [request setHTTPMethod:POST];
        [request setHTTPBody:body];
        [request setValue:[NSString stringWithFormat:@"%d", [body length]] forHTTPHeaderField:@"Content-Length"];
    }
    
    [request setURL:[NSURL URLWithString:url]];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %i", url, [responseCode statusCode]);
        return nil;
    }
    
    return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
}

@end
