//
//  KCGNoteCellView.h
//  Everpobre
//
//  Created by José Manuel Rodríguez Moreno on 25/01/16.
//  Copyright (c) 2016 José Manuel Rodríguez Moreno. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KCGNote;

@interface KCGNoteCellView : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *modificationDateView;
@property (weak, nonatomic) IBOutlet UILabel *titleView;
@property (weak, nonatomic) IBOutlet UIImageView *locationView;

-(void) observeNote:(KCGNote *) note;

@end
