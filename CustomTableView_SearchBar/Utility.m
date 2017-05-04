//
//  Utility.m
//  moveCHECK
//
//  Created by Virupaksh Futane on 1/9/16.
//  Copyright © 2016 Saltmines-Mac2. All rights reserved.
//

#import "Utility.h"

@implementation Utility

#pragma mark -
+ (BOOL)isNewtworkReachable {
    BOOL isReachable = NO;
    AppDelegate *_appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    Reachability *netReach = [_appDelegate reachable];
    
    NetworkStatus netStatus = [netReach currentReachabilityStatus];
    BOOL connectionRequired = [netReach connectionRequired];
    
    if ((netStatus == ReachableViaWiFi) ||((netStatus == ReachableViaWWAN) && !connectionRequired)){
        isReachable = YES;
    }
        return isReachable;
}

+(NSString *)getDateStringFromDate :(NSDate *)date {
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

+(NSDate *)getDateFromDateString :(NSString *)dateString {
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSDate *date = [dateFormatter dateFromString:dateString];
    return date;
}

+ (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return destImage;
}

+ (NSMutableArray*)getSateList
{
    NSString * filePath =[[NSBundle mainBundle] pathForResource:@"states_titlecase" ofType:@"json"];
    
    NSError * error;
    NSString* fileContents =[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    
    if(error)
    {
        NSLog(@"Error reading file: %@",error.localizedDescription);
    }
    
    NSMutableArray *stateList = [[NSMutableArray alloc] init];
    
    stateList = (NSMutableArray *)[NSJSONSerialization
                                   JSONObjectWithData:[fileContents dataUsingEncoding:NSUTF8StringEncoding]
                                   options:0 error:NULL];
    
    
    return stateList;
    
}

+ (NSString*)getStateInfo:(NSInteger)stateId
{
    NSString *aFilePath = [[NSBundle mainBundle] pathForResource:@"states_titlecase" ofType:@"json"];
    NSString *aJsonContent = [NSString stringWithContentsOfFile:aFilePath encoding:NSUTF8StringEncoding error:nil];
    
    
    NSData *aData = [aJsonContent dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSError *anError;
    NSArray *aStatesArray = [NSJSONSerialization JSONObjectWithData:aData options:kNilOptions error:&anError];
    
    for(NSDictionary *aStateDict in aStatesArray)
    {
        NSInteger aStateId = [[aStateDict valueForKey:@"stateId"] integerValue];
        
        if (aStateId == stateId)
        {
            NSString *stateName = [aStateDict valueForKey:@"abbreviation"];
            return stateName;
        }
        
    }
    
    return nil;
}

+ (NSInteger)getStateId:(NSString*)stateName
{
    NSString *aFilePath = [[NSBundle mainBundle] pathForResource:@"states_titlecase" ofType:@"json"];
    NSString *aJsonContent = [NSString stringWithContentsOfFile:aFilePath encoding:NSUTF8StringEncoding error:nil];
    
    
    NSData *aData = [aJsonContent dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSError *anError;
    NSArray *aStatesArray = [NSJSONSerialization JSONObjectWithData:aData options:kNilOptions error:&anError];
    
    for(NSDictionary *aStateDict in aStatesArray)
    {
        NSString *aStateName = [aStateDict valueForKey:@"abbreviation"];
        
        if ([aStateName isEqualToString:stateName])
        {
            NSInteger stateId = [[aStateDict valueForKey:@"stateId"] integerValue];
            return stateId;
        }
        
    }
    
    return 0;
}

//convert string to base64
+ (NSString *)base64Encode:(NSString *)text
{
    // Create NSData object
    NSData *nsdata = [text dataUsingEncoding:NSUTF8StringEncoding];
    
    // Get NSString from NSData object in Base64
    NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:0];
    
    return base64Encoded;
}

+ (NSString *)appVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
}

+ (NSString *)build
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey: (NSString *)kCFBundleVersionKey];
}

+ (NSString *)versionBuild
{
    NSString * version = [self appVersion];
    NSString * build = [self build];
    
    NSString * versionBuild = [NSString stringWithFormat: @"v%@", version];
    
    if (![version isEqualToString: build]) {
        versionBuild = [NSString stringWithFormat: @"%@(%@)", versionBuild, build];
    }
    
    return versionBuild;
}


+ (void)makeCall:(NSString*)phoneNumber
{
    UIAlertController *anAlertController=[UIAlertController alertControllerWithTitle:phoneNumber message:nil preferredStyle:UIAlertControllerStyleAlert];
    //...
    id rootViewController=[UIApplication sharedApplication].delegate.window.rootViewController;
    if([rootViewController isKindOfClass:[UINavigationController class]])
    {
        rootViewController=[((UINavigationController *)rootViewController).viewControllers objectAtIndex:0];
    }
    
    UIAlertAction *aAlertAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"Cancel");
        
    }];
    UIAlertAction *anAlertAction = [UIAlertAction actionWithTitle:@"Call" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSString *aPhoneNumber = [[phoneNumber componentsSeparatedByCharactersInSet:
                                   [[NSCharacterSet characterSetWithCharactersInString:@"+0123456789"]
                                    invertedSet]]
                                  componentsJoinedByString:@""];
        
        NSLog(@"Call");
        
        aPhoneNumber = [@"tel://" stringByAppendingString:aPhoneNumber];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:aPhoneNumber]];
        
    }];
    
    [anAlertController addAction:aAlertAction];
    [anAlertController addAction:anAlertAction];
    
    [rootViewController presentViewController:anAlertController animated:YES completion:nil];
    
}

+ (NSArray *)parseStatesResponseFileName:(NSString *)aFileName FileType:(NSString *)aFileType
{
    NSString *aFilePath = [[NSBundle mainBundle] pathForResource:aFileName ofType:aFileType];
    NSString *aJsonContent = [NSString stringWithContentsOfFile:aFilePath encoding:NSUTF8StringEncoding error:nil];
    NSData *aData = [aJsonContent dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];;;
    NSError *anError;
    NSArray *arrayJson = [NSJSONSerialization JSONObjectWithData:aData options:kNilOptions error:&anError];
    //    NSLog(@"%@",arrayJson);
    return arrayJson;
}




@end
