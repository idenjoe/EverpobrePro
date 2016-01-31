//
//  KCGPhotoViewController.m
//  Everpobre
//
//  Created by José Manuel Rodríguez Moreno on 22/01/16.
//  Copyright © 2016 José Manuel Rodríguez Moreno. All rights reserved.
//

#import "KCGPhotoViewController.h"
#import "KCGNote.h"
#import "KCGPhoto.h"

@interface KCGPhotoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (nonatomic) BOOL shouldSaveImageToModel;
@property (nonatomic, strong) KCGNote *model;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *deleteButton;
@end

@implementation KCGPhotoViewController

-(id) initWithModel:(KCGNote*) note{
    
    if (self = [super initWithNibName:nil
                               bundle:nil]) {
        _model = note;
        if (note.photo.imageData == nil) {
            _shouldSaveImageToModel = NO;
        }else{
            _shouldSaveImageToModel = YES;
        }
    }
    
    return self;
}

#pragma mark - Ciclo de vida
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.title = self.model.name;
    if (self.model.photo.imageData != nil){
        self.photoView.image = self.model.photo.image;
        self.shouldSaveImageToModel = YES;
    }else{
        self.photoView.image = [UIImage imageNamed:@"no-image-available.png"];
        self.shouldSaveImageToModel = NO;
    }
    
    self.deleteButton.enabled = self.shouldSaveImageToModel;
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    if(self.shouldSaveImageToModel){
        self.model.photo.image = self.photoView.image;
    }
    
}
#pragma mark - Actions
- (IBAction)delete:(id)sender {
    
    
    
    CGRect oldBounds = self.photoView.bounds;
    
    [UIView animateWithDuration:0.9
                     animations:^{
                         self.photoView.alpha = 0;
                         self.photoView.bounds = CGRectZero;
                         self.photoView.transform = CGAffineTransformMakeRotation(M_2_PI);
                         
                     } completion:^(BOOL finished) {
                         
                         // Eliminamos de la photoView
                         self.photoView.image = nil;
                         
                         // La eliminamos del modelo
                         self.model.photo.image = nil;
                         
                         // Actualizamos estado del botón
                         self.deleteButton.enabled = NO;
                         
                         // Dejamos todo como estaba
                         self.photoView.alpha = 1;
                         self.photoView.bounds = oldBounds;
                         self.photoView.transform = CGAffineTransformIdentity;
                         
                     }];
    
    
    
    
    
}
- (IBAction)applyFilter:(id)sender {
}
- (IBAction)takePhoto:(id)sender {
    
    // Crear un ImagePicker
    UIImagePickerController *pVC = [[UIImagePickerController alloc]init];
    
    // Configurarlo
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        // Habemus camara
        pVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{
        // me conformo con carrete
        pVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    // Hacerme su delegado
    pVC.delegate = self;
    
    // Mostrarlo
    [self presentViewController:pVC
                       animated:YES
                     completion:nil];
    
    
    // Actualizamos estado del botón
    self.deleteButton.enabled = NO;
    
}


#pragma mark - UIImagePickerControllerDelegate
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    // Extraer la foto del diccionario de info
    UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    // Asegurarnos que la imagen se guarda
    self.shouldSaveImageToModel = YES;
    
    // Lo metemos en el modelo
    self.model.photo.image = img;
    
    // Ocultamos el picker
    [self dismissViewControllerAnimated:YES
                             completion:nil];
    
    
}
















@end
