//
//  sso_client_api.m
//  sso-client-api
//
//  Created by Black, Gavin S. on 12/17/13.
//  Copyright (c) 2013 Black, Gavin S. All rights reserved.
//

#import "ssoClient.h"
#import <UIKit/UIKit.h>


@implementation ssoClient

static NSString *uuid;

+ (void) logout {
    UIPasteboard *appPasteBoard = [UIPasteboard pasteboardWithName:@"iMAS_SSO" create:NO];
    appPasteBoard.persistent = NO;
    [appPasteBoard setString:@""];
}

+ (NSString*) fetchHash : (NSString*) callbackURI {
    if(uuid == nil) uuid = [[NSUUID UUID] UUIDString];
    NSString* pbName = [NSString stringWithFormat:@"%@%@", @"iMAS", [[NSUUID UUID] UUIDString]];
    
    // Test if the relevant iMAS pasteboard exists, if not open up SSO app
    //UIPasteboard *appPasteBoard = [UIPasteboard pasteboardWithName:pbName create:NO];
    UIPasteboard *appPasteBoard = [UIPasteboard pasteboardWithName:@"iMAS_SSO" create:NO];
    
    if(appPasteBoard != nil) {
        NSString* ps =[appPasteBoard string];
        if([ps length] >= 1) return ps;
    }
    
    NSString* ssoURI = [NSString stringWithFormat:@"iMASSO://%@/%@", pbName, callbackURI];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:ssoURI]];
    exit(0);
    return @"";
}

+ (NSString* ) fetchAndMergeHash : (NSString *) callbackURI : (NSString *) additionalHash {
    NSString* requestedHash = [ssoClient fetchHash:callbackURI];
    
    NSData *data = [requestedHash dataUsingEncoding:NSUTF8StringEncoding];
    char *dataBytes = (char *) [data bytes];
    char *keyData = (char *) [[additionalHash dataUsingEncoding:NSUTF8StringEncoding] bytes];

    char *dataPtr = dataBytes;
    int dataIndex = 0;
    
    char *keyPtr = keyData;
    int keyIndex = 0;
    
    int max = [data length];
    if( [data length] < [additionalHash length]) max = [additionalHash length];
    
    for (int x = 0; x < max; x++)
    {
        *dataPtr = *dataPtr++ ^ *keyPtr++;
        
        // Roll over
        if (++keyIndex == [additionalHash length])
            keyIndex = 0, keyPtr = keyData;
        if (++dataIndex == [data length])
            dataIndex = 0, dataPtr = dataBytes;
    }
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}


@end
