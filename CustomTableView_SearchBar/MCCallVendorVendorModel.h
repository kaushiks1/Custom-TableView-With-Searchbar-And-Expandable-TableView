//
//  MCCallVendorVendorModel.h
//  moveCHECK
//
//  Created by Roshan Sequeira on 27/05/16.
//  Copyright © 2016 Saltmines-Mac2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCCallVendorVendorModel : NSObject

@property (nonatomic, strong) NSString *vendorName;
@property (nonatomic, strong) NSString *vendorPhone;

- (void)setDataFromDictionary:(NSDictionary *)dictionary;

@end
