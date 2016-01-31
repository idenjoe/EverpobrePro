#import "KCLocation.h"
#import "KCGNote.h"
@import AddressBookUI;

@interface KCLocation ()

// Private interface goes here.

@end

@implementation KCLocation

// Custom logic goes here.
+(instancetype)locationWithCLLocation:(CLLocation *)location forNote:(KCGNote *)note{
    
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:[KCLocation entityName]];
    NSPredicate *latitudePredicate = [NSPredicate predicateWithFormat:@"abs(latitude) - abs(%lf) < 0.001",location.coordinate.latitude];
    NSPredicate *longitudePredicate = [NSPredicate predicateWithFormat:@"abs(longitude) - abs(%lf) < 0.001",location.coordinate.longitude];
    request.predicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[latitudePredicate,longitudePredicate]];
    
    NSError *error = nil;
    NSArray *fetchResults = [note.managedObjectContext executeFetchRequest:request error:&error];
    
    NSAssert(fetchResults, @"Error al buscar");
    
    if ([fetchResults count] > 0) {
        KCLocation *found = [fetchResults lastObject];
        [found addNotesObject:note];
        return found;
        
    }else{
        KCLocation *loc = [self insertInManagedObjectContext:note.managedObjectContext];
        loc.latitudeValue = location.coordinate.latitude;
        loc.longitudeValue = location.coordinate.longitude;
        [loc addNotesObject:note];
        CLGeocoder *coder = [CLGeocoder new];
        [coder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            
            if (error) {
                NSLog(@"Error obtaining address");
            }else{
                loc.address = ABCreateStringWithAddressDictionary([[placemarks lastObject] addressDictionary], YES);
            }
        }];
        
        return loc;
    }
    
    
}

@end
