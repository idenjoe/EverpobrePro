//
//  KCGNoteCellView.m
//  Everpobre
//
//  Created by José Manuel Rodríguez Moreno on 25/01/16.
//  Copyright (c) 2016 José Manuel Rodríguez Moreno. All rights reserved.
//

#import "KCGNoteCellView.h"
#import "KCGNote.h"
#import "KCGPhoto.h"

@interface KCGNoteCellView ()
@property (strong, nonatomic) KCGNote* note;
@end
@implementation KCGNoteCellView

+(NSArray*) keys{
    return @[@"photo.image", @"name", @"modificationDate", @"location", @"location.latitude", @"location.longitude", @"location.address"];
}
-(void) observeNote:(KCGNote *) note{
    
    self.note = note;
    
    for (NSString *key in [KCGNoteCellView keys]) {
        [self.note addObserver:self
                    forKeyPath:key
                       options:NSKeyValueObservingOptionNew
                       context:NULL];
    }
    
    [self syncWithNote];
    
}


-(void) prepareForReuse{
    
    for (NSString *key in [KCGNoteCellView keys]) {
        [self.note removeObserver:self forKeyPath:key];

    }
    self.note = nil;
    [self syncWithNote];
}

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context{
    
    [self syncWithNote];
    

    
}

-(void) syncWithNote{
    self.titleView.text = self.note.name;
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateStyle = NSDateFormatterMediumStyle;
    self.modificationDateView.text = [fmt stringFromDate:self.note.modificationDate];
    
    UIImage *img;
    if (self.note.photo.image == nil) {
        img = [UIImage imageNamed:@"noImage.png"];
    }else{
        img = self.note.photo.image;
    }
    self.photoView.image = img;
    if (self.note.hasLocation) {
        self.locationView.image = [UIImage imageNamed:@"placemark.png"];
    }else{
        self.locationView.image = nil;
    }

}




@end
