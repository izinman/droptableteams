//
//  ARViewController.m
//  FreeRealEstate
//
//  Created by Artem Jivotovski on 11/11/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(ARViewController, UIViewController)

RCT_EXTERN_METHOD(getSceneView)
RCT_EXTERN_METHOD(presentView)

@end
