//
//  sso_client_api.h
//  sso-client-api
//
//  Created by Black, Gavin S. on 12/17/13.
//  Copyright (c) 2013 Black, Gavin S. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ssoClient : NSObject

+ (void) logout;
+ (NSString*) fetchHash : (NSString*) callbackURI;
+ (NSString* ) fetchAndMergeHash : (NSString *) callbackURI : (NSString *) additionalHash;


@end
