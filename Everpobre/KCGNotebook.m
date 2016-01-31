#import "KCGNotebook.h"

@interface KCGNotebook ()

// Private interface goes here.

@end

@implementation KCGNotebook
#pragma mark - Class Methods
+(NSArray*)observableKeys{
    return @[@"name", @"notes"];
}

+(instancetype) notebookWithName:(NSString*) name
                         context:(NSManagedObjectContext *)context{
    
    KCGNotebook *nb = [self insertInManagedObjectContext:context];
    
    nb.name = name;
    nb.creationDate = [NSDate date];
    nb.modificationDate = [NSDate date];
    
    return nb;
}

#pragma mark - Life cycle
-(void) awakeFromInsert{
    [super awakeFromInsert];
    // Se llama solo una vez
    [self setupKVO];
    
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









@end
