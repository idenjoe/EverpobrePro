//
//  KCGPhotoViewController.h
//  Everpobre
//
//  Created by José Manuel Rodríguez Moreno on 22/01/16.
//  Copyright © 2016 José Manuel Rodríguez Moreno. All rights reserved.
//

@import UIKit;
@class KCGNote;

@interface KCGPhotoViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

-(id) initWithModel:(KCGNote*) note;

@end
