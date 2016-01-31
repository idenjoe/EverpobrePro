//
//  KCGNoteViewController.m
//  Everpobre
//
//  Created by José Manuel Rodríguez Moreno on 21/01/16.
//  Copyright © 2016 José Manuel Rodríguez Moreno. All rights reserved.
//

#import "KCGNoteViewController.h"
#import "KCGNote.h"
#import "KCGPhotoViewController.h"

@interface KCGNoteViewController ()
@property (weak, nonatomic) IBOutlet UILabel *creationDateView;
@property (weak, nonatomic) IBOutlet UILabel *modificationDateView;
@property (weak, nonatomic) IBOutlet UITextField *nameView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIToolbar *bottomToolbar;

@property (strong, nonatomic) KCGNote *model;

@property (nonatomic) CGRect oldFrame;
@property (nonatomic) double animationDuration;
@property (nonatomic) BOOL isKeyBoardVisible;
@end

@implementation KCGNoteViewController

#pragma mark - Initialization
-(id) initWithModel: (KCGNote*) model{
    if (self = [super initWithNibName:nil
                               bundle:nil]) {
        _model = model;
    }
    return self;
    
}

#pragma mark - Life cycle
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // sincronizamos modelo -> vistas
    NSDateFormatter *fmt = [NSDateFormatter new];
    fmt.dateStyle = NSDateFormatterShortStyle;
    
    self.creationDateView.text = [fmt stringFromDate:self.model.creationDate];
    self.modificationDateView.text = [fmt stringFromDate:self.model.modificationDate];
    self.nameView.text = self.model.name;
    self.textView.text = self.model.text;
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    // sincronizamos vistas -> modelo
    self.model.text = self.textView.text;
    self.model.name = self.nameView.text;
}

#pragma mark - Notifications

#pragma mark - Actions
- (IBAction)displayPhoto:(id)sender {
    
    KCGPhotoViewController *pVC = [[KCGPhotoViewController alloc] initWithModel:self.model];
    
    [self.navigationController pushViewController:pVC
                                         animated:YES];
    
}

-(IBAction)removeKeyboard:(id)sender{
    
    [self.view endEditing:YES];
    
}

@end
