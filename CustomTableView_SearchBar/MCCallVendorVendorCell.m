//
//  MCCallVendorVendorCell.m
//  moveCHECK
//
//  Created by Roshan Sequeira on 27/05/16.
//  Copyright © 2016 Saltmines-Mac2. All rights reserved.
//

#import "MCCallVendorVendorCell.h"

@interface MCCallVendorVendorCell ()

@property (weak, nonatomic) IBOutlet UILabel *vendorName;

@end

@implementation MCCallVendorVendorCell

- (void)setModel:(MCCallVendorVendorModel *)model
{
    _model = model;
    self.vendorName.text = _model.vendorName;
}

- (IBAction)callVendorAction:(id)sender
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(tappedCallVendor:)])
    {
        [self.delegate tappedCallVendor:self];
    }
}


- (IBAction)viewMoreAction:(id)sender
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(tappedViewMore:)])
    {
        [self.delegate tappedViewMore:self];
    }
}

@end
