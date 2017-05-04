//
//  Utility.h
//  moveCHECK
//
//  Created by Virupaksh Futane on 1/9/16.
//  Copyright © 2016 Saltmines-Mac2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "AppDelegate.h"

@interface Utility : NSObject {
    
}

#pragma mark - 
+ (BOOL)isNewtworkReachable;

+ (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size;

+ (NSMutableArray*)getSateList;
+ (NSString*)getStateInfo:(NSInteger)stateId;
+ (NSInteger)getStateId:(NSString*)stateName;
+ (NSString *)base64Encode:(NSString *)text;

+ (NSString *)appVersion;
+ (NSString *)build;
+ (NSString *)versionBuild;

+ (void)makeCall:(NSString*)phoneNumber;
+ (NSArray *)parseStatesResponseFileName:(NSString *)aFileName FileType:(NSString *)aFileType;


@end
