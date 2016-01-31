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
#import "UIImage+Resize.h"
@import CoreImage;

@interface KCGPhotoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (nonatomic) BOOL shouldSaveImageToModel;
@property (nonatomic, strong) KCGNote *model;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *deleteButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
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
    self.activityIndicator.hidden = YES;
    self.activityIndicator.hidesWhenStopped = YES;
    
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
                         self.photoView.image = [UIImage imageNamed:@"no-image-available.png"];
                         self.shouldSaveImageToModel = NO;
                         
                     }];
}
- (IBAction)applyFilter:(id)sender {
    
    
    // Crear un contexto
    CIContext *context = [CIContext contextWithOptions:nil];
    //Crear un CIImage de entrada
    CIImage *input = [CIImage imageWithCGImage:self.model.photo.image.CGImage];
    //Crear primer filtro
    CIFilter *old = [CIFilter filterWithName:@"CIFalseColor"];
    [old setDefaults];
    [old setValue:input forKey:kCIInputImageKey];
    
    //Crear segundo filtro
    CIFilter *vignette = [CIFilter filterWithName:@"CIVignette"];
    [vignette setDefaults];
    [vignette setValue:@10 forKey:kCIInputIntensityKey];
    // Obtener imagen de salida
    CIImage *output = old.outputImage;
    
    //Los encadenamos
    [vignette setValue:output forKey:kCIInputImageKey];
    output = vignette.outputImage;
    
    //Aplicar el filtro
    [self.activityIndicator setHidesWhenStopped:YES];
    [self.activityIndicator setHidden:NO];
    [self.activityIndicator startAnimating];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        CGImageRef imageRef = [context createCGImage:output
                                            fromRect:output.extent];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.activityIndicator stopAnimating];
            // Guardamos la nueva imagen
            UIImage *img = [UIImage imageWithCGImage:imageRef];
            self.photoView.image = img;
            self.model.photo.image = img;
            
            //Liberar el CGImageRef
            CGImageRelease(imageRef);
        });
    });
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
    __block UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGFloat screenScale = [[UIScreen mainScreen] scale];
    CGSize screenSize = CGSizeMake(screenBounds.size.width * screenScale, screenBounds.size.height * screenScale);
    
    // Asegurarnos que la imagen se guarda
    self.shouldSaveImageToModel = YES;
    
    // Lo metemos en el modelo
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        img = [img resizedImageWithContentMode:UIViewContentModeScaleAspectFit bounds:screenSize interpolationQuality:kCGInterpolationHigh];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.photoView.image = img;
            [self.activityIndicator stopAnimating];
            self.model.photo.image = img;
            self.deleteButton.enabled = YES;
        });
    });
    
    // Ocultamos el picker
    [self dismissViewControllerAnimated:YES
                             completion:nil];
    
    
}

@end
