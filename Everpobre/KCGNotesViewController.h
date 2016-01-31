//
//  KCGNotesViewController.h
//  Everpobre
//
//  Created by José Manuel Rodríguez Moreno on 21/01/16.
//  Copyright © 2016 José Manuel Rodríguez Moreno. All rights reserved.
//

@import UIKit;
@import CoreData;

#import "AGTCoreDataTableViewController.h"
@class KCGNotebook;


@interface KCGNotesViewController : AGTCoreDataTableViewController

-(id) initWithFetchedResultsController:(NSFetchedResultsController *)aFetchedResultsController style:(UITableViewStyle)aStyle notebook:(KCGNotebook*) notebook;



@end
