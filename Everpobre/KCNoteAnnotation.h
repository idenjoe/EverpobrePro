//
//  KCNoteAnnotation.h
//  EverpobrePro
//
//  Created by José Manuel Rodríguez Moreno on 31/01/16.
//  Copyright © 2016 José Manuel Rodríguez Moreno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "KCGNote.h"
@interface KCNoteAnnotation : NSObject <MKAnnotation>
@property (nonatomic, strong) KCGNote *model;

-(instancetype)initWithModel:(KCGNote *)model;

@end
