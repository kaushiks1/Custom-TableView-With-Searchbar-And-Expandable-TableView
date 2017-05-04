//
//  MCCallVendorVendorModel.m
//  moveCHECK
//
//  Created by Roshan Sequeira on 27/05/16.
//  Copyright © 2016 Saltmines-Mac2. All rights reserved.
//

#import "MCCallVendorVendorModel.h"

@implementation MCCallVendorVendorModel

- (void)setDataFromDictionary:(NSDictionary *)dictionary
{
    self.vendorName = dictionary[@"name"];
    self.vendorPhone = dictionary[@"phone"];
}

@end
