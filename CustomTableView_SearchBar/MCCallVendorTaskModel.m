//
//  MCCallVendorTaskModel.m
//  moveCHECK
//
//  Created by Roshan Sequeira on 27/05/16.
//  Copyright © 2016 Saltmines-Mac2. All rights reserved.
//

#import "MCCallVendorTaskModel.h"

@implementation MCCallVendorTaskModel

- (void)setDataFromDictionary:(NSDictionary *)dictionary
{
    self.taskName = dictionary[@"name"];
    //vendors
    self.vendorsArray = [NSMutableArray array];
    NSArray *vendorsArray = dictionary[@"vendors"];
    for(NSDictionary *vendorDictionay in vendorsArray )
    {
        MCCallVendorVendorModel *vendorModel = [[MCCallVendorVendorModel alloc] init];
        [vendorModel setDataFromDictionary:vendorDictionay];
        [self.vendorsArray addObject:vendorModel];
    }
}

@end
