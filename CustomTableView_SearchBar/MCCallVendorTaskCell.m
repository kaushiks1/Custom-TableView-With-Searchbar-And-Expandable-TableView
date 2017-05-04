//
//  MCCallVendorTaskCell.m
//  moveCHECK
//
//  Created by Roshan Sequeira on 27/05/16.
//  Copyright © 2016 Saltmines-Mac2. All rights reserved.
//

#import "MCCallVendorTaskCell.h"

@interface MCCallVendorTaskCell()

@property (weak, nonatomic) IBOutlet UILabel *taskName;

@property (weak, nonatomic) IBOutlet UIButton *expandButton;


@end

@implementation MCCallVendorTaskCell

- (IBAction)expandButtonAction:(id)sender
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(expandCell:)])
    {
        [self.delegate expandCell:self];
        [self updateButtonState];
    }
}

- (void)setModel:(MCCallVendorTaskModel *)model
{
    _model = model;
    self.taskName.text = _model.taskName;
    [self updateButtonState];
}

- (void)updateButtonState
{
    if(self.model.expanded)
    {
        [self.expandButton setBackgroundImage:[UIImage imageNamed:@"drop-up"] forState:UIControlStateNormal];
    }
    else
    {
        [self.expandButton setBackgroundImage:[UIImage imageNamed:@"drop-down"] forState:UIControlStateNormal];
    }
}

@end
