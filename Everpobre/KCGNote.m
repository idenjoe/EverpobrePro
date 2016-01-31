#import "KCGNote.h"
#import "KCGPhoto.h"
#import "KCGNotebook.h"
#import "KCLocation.h"

@import CoreLocation;

@interface KCGNote ()<CLLocationManagerDelegate>

// Private interface goes here.
@property (nonatomic, strong) CLLocationManager *locationManager;
@end

@implementation KCGNote
@synthesize locationManager=_locationManager;

+(NSArray*)observableKeys{
    return @[@"name", @"text", @"notebook",@"photo.imageData",@"location"];
}


+(instancetype)noteWithName:(NSString *) name
                   notebook: (KCGNotebook*) notebook
                    context:(NSManagedObjectContext*) context{
    
    
    KCGNote *note = [self insertInManagedObjectContext:context];
    note.name = name;
    note.notebook = notebook;
    note.creationDate = [NSDate date];
    note.photo = [KCGPhoto insertInManagedObjectContext:context];
    note.modificationDate = [NSDate date];
    
    return  note;
}

-(BOOL)hasLocation{
    return nil != self.location;
}

#pragma mark - Life cycle
-(void) awakeFromInsert{
    [super awakeFromInsert];
    // Se llama solo una vez
    [self setupKVO];
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    if ( status == kCLAuthorizationStatusAuthorizedWhenInUse && [CLLocationManager locationServicesEnabled]) {
        // Tenemos localización
        [self.locationManager startUpdatingLocation];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self zapLocationManager];
        });
    }else{
        NSLog(@"No tengo permiso");
        if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self.locationManager requestWhenInUseAuthorization];
        }
    }
    
}

-(void)awakeFromFetch{
    [super awakeFromFetch];
    // Se llama un huevo de veces
    [self setupKVO];
}

-(void) willTurnIntoFault{
    [super willTurnIntoFault];
    [self tearDownKVO];
}


#pragma mark - KVO
-(void) setupKVO{
    // Alta en notificaciones
    
    for (NSString *key in [self.class observableKeys]) {
        [self addObserver:self
               forKeyPath:key
                  options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    }
    
    
}

-(void) tearDownKVO{
    // Baja en notificaciones
    
    for (NSString *key in [self.class observableKeys]) {
        [self removeObserver:self
                  forKeyPath:key];
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary<NSString *,id> *)change
                      context:(void *)context{
    
    self.modificationDate = [NSDate date];
}


#pragma mark - CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager
    didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    // lo paramos
    [self zapLocationManager];
    
    if (!self.hasLocation) {
        // Pillamos la última localización
        CLLocation *loc = [locations lastObject];
        self.location = [KCLocation locationWithCLLocation:loc forNote:self];
    }else{
        NSLog(@"No deberíamos llegar nunca");
    }
}

-(void)zapLocationManager{
    [self.locationManager stopUpdatingLocation];
    self.locationManager.delegate = nil;
    self.locationManager = nil;
}








@end
