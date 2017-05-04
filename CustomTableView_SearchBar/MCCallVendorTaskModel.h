//
//  MCCallVendorTaskModel.h
//  moveCHECK
//
//  Created by Roshan Sequeira on 27/05/16.
//  Copyright © 2016 Saltmines-Mac2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCCallVendorVendorModel.h"

@interface MCCallVendorTaskModel : NSObject

@property (nonatomic, assign) BOOL expanded;
@property (nonatomic, strong) NSString *taskName;
@property (nonatomic, strong) NSMutableArray *vendorsArray; // of type vendors model

- (void)setDataFromDictionary:(NSDictionary *)dictionary;

@end
