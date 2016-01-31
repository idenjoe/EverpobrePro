//
//  KCNoteAnnotation.m
//  EverpobrePro
//
//  Created by José Manuel Rodríguez Moreno on 31/01/16.
//  Copyright © 2016 José Manuel Rodríguez Moreno. All rights reserved.
//

#import "KCNoteAnnotation.h"
#import "KCLocation.h"

@interface KCNoteAnnotation ()

@end


@implementation KCNoteAnnotation
@synthesize coordinate=_coordinate;

-(instancetype)initWithModel:(KCGNote *)model{
    if (self = [super init]) {
        self.model = model;
        _coordinate = CLLocationCoordinate2DMake(self.model.location.latitude.doubleValue, self.model.location.longitude.doubleValue);
    }
    
    return self;
}

#pragma mark - MKAnnotation
-(NSString *)title{
    return self.model.name;
}

-(NSString *)subtitle{
    NSString *dateString = [NSDateFormatter localizedStringFromDate:self.model.modificationDate
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterFullStyle];
    return dateString;
}
@end
