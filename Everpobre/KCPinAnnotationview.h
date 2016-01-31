//
//  KCPinAnnotationview.h
//  EverpobrePro
//
//  Created by José Manuel Rodríguez Moreno on 31/01/16.
//  Copyright © 2016 José Manuel Rodríguez Moreno. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "KCNoteAnnotation.h"

@interface KCPinAnnotationview : MKPinAnnotationView

@property (strong, nonatomic) KCNoteAnnotation *noteAnnotation;

@end
