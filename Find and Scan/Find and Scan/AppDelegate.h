//
//  AppDelegate.h
//  Find and Scan
//
//  Created by 贝宁 on 22/02/2018.
//  Copyright © 2018 贝宁. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

