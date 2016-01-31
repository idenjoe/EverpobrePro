//
//  EverpobreNotesViewController.h
//  EverpobrePro
//
//  Created by José Manuel Rodríguez Moreno on 25/01/16.
//  Copyright (c) 2016 José Manuel Rodríguez Moreno. All rights reserved.
//

#import "AGTCoreDataCollectionViewController.h"
@class KCGNotebook;

@interface EverpobreNotesViewController : AGTCoreDataCollectionViewController
@property (nonatomic, strong) KCGNotebook *notebook;

@end
