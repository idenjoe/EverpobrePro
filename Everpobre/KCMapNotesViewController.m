//
//  KCMapNotesViewController.m
//  EverpobrePro
//
//  Created by José Manuel Rodríguez Moreno on 31/01/16.
//  Copyright © 2016 José Manuel Rodríguez Moreno. All rights reserved.
//

#import "KCMapNotesViewController.h"
#import <MapKit/MapKit.h>
#import <CoreData/CoreData.h>
#import "KCGNote.h"
#import "KCNoteAnnotation.h"

@interface KCMapNotesViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) AGTCoreDataStack *model;
@end

@implementation KCMapNotesViewController

-(id)initWithModel:(AGTCoreDataStack *)model{
    if (self = [super init]) {
        self.model = model;
    }
    
    return self;
}

-(NSString *)title{
    return @"Map";
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self loadNotes];
}

-(void)loadNotes{
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[KCGNote entityName]];
    NSArray *notes = [self.model executeFetchRequest:req errorBlock:nil];
    NSMutableArray *annotations = [NSMutableArray array];
    for (KCGNote *note in notes) {
        KCNoteAnnotation *annotation = [[KCNoteAnnotation alloc] initWithModel:note];
        [annotations addObject:annotation];
    }
    
    [self.mapView addAnnotations:annotations];
    
}

@end
