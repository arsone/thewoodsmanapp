//
//  ViewController.h
//  WoodsmanPreshowApp
//
//  Created by Adam Salberg on 1/24/16.
//  Copyright © 2016 Adam Salberg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (IBAction)playPreshow:(id)sender;

- (IBAction)stopPreshow:(id)sender;

- (IBAction)playAnnounce:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *audioIndicator;

@property (weak, nonatomic) IBOutlet UIButton *announceIndicator;


@end

