//
//  UIViewController+Navigation.m
//  Everpobre
//
//  Created by José Manuel Rodríguez Moreno on 18/01/16.
//  Copyright © 2016 José Manuel Rodríguez Moreno. All rights reserved.
//

#import "UIViewController+Navigation.h"

@implementation UIViewController (Navigation)

-(UINavigationController *) wrappedInNavigation{
    
    // Creamos el navigation controller
    UINavigationController *nav = [UINavigationController new];
    
    // le encasquetamos
    [nav pushViewController:self
                   animated:NO];
    
    // Lo devolvemos
    return nav;
}
@end
