#import "KCGNote.h"
#import "KCGPhoto.h"
#import "KCGNotebook.h"

@interface KCGNote ()

// Private interface goes here.

@end

@implementation KCGNote

+(NSArray*)observableKeys{
    return @[@"name", @"text", @"notebook",@"photo.imageData"];
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
