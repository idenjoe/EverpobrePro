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
#import "KCPinAnnotationview.h"
#import "KCGNoteViewController.h"

@interface KCMapNotesViewController ()<MKMapViewDelegate>
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

-(void)viewDidLoad{
    [super viewDidLoad];
    self.mapView.delegate = self;
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

#pragma mark - MKMapViewDelegate

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    static NSString *reuseId = @"note";
    
    // la reciclamos
    
    KCPinAnnotationview *pinView = (KCPinAnnotationview *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseId];
    if (pinView == nil) {
        pinView = [[KCPinAnnotationview alloc] initWithAnnotation:annotation
                                                  reuseIdentifier:reuseId];
    }
    
    pinView.pinTintColor = [UIColor purpleColor];
    pinView.canShowCallout = YES;
    pinView.noteAnnotation = (KCNoteAnnotation *)annotation;
    UIButton *pinButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [pinButton addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
    pinView.rightCalloutAccessoryView = pinButton;
    
    return pinView;
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    KCGNoteViewController *detailNoteVC = [[KCGNoteViewController alloc] initWithModel:[(KCNoteAnnotation *)view.annotation model]];
    
    [self.navigationController pushViewController:detailNoteVC animated:YES];
}

@end
