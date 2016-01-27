//
//  ViewController.m
//  WoodsmanPreshowApp
//
//  Created by Adam Salberg on 1/24/16.
//  Copyright © 2016 Adam Salberg. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()
{
    AVAudioPlayer *audioPlayer;
    AVAudioPlayer *announcementPlayer;
    void *fadeVolume;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [NSString stringWithFormat:@"%@/preshow_amb_v2.caf", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    audioPlayer.delegate = self;
    
    [audioPlayer setVolume:1.0];
    [audioPlayer setNumberOfLoops:-1];
    
    NSString *announcePath = [NSString stringWithFormat:@"%@/preshow_announce.caf", [[NSBundle mainBundle] resourcePath]];
    NSURL *announceUrl = [NSURL fileURLWithPath:announcePath];
    
    announcementPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:announceUrl error:nil];
    announcementPlayer.delegate = self;
    
    [announcementPlayer setVolume:0.4];

}

- (void)fadeVolumeDown {
    if(self->audioPlayer.volume > 0.3) {
        self->audioPlayer.volume = self->audioPlayer.volume - 0.05;
        [self performSelector:@selector(fadeVolumeDown) withObject:nil afterDelay:0.1];
    }
    NSLog( @"calling: %s", __PRETTY_FUNCTION__ );
}

- (void)fadeVolumeUp {
    if(self->audioPlayer.volume < 1.0) {
        self->audioPlayer.volume = self->audioPlayer.volume + 0.05;
        [self performSelector:@selector(fadeVolumeUp) withObject:nil afterDelay:0.1];
    }
    NSLog( @"calling: %s", __PRETTY_FUNCTION__ );
}

- (void)fadeVolumeOut {
    if(self->audioPlayer.volume > 0.0) {
        self->audioPlayer.volume = self->audioPlayer.volume - 0.02;
        [self performSelector:@selector(fadeVolumeOut) withObject:nil afterDelay:0.1];
    } else {
        [self->audioPlayer stop];
        audioPlayer.currentTime = 0;
        [audioPlayer setVolume:1.0];
    }
    NSLog( @"calling: %s", __PRETTY_FUNCTION__ );
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)announcementPlayer successfully:(BOOL)flag {
    if(flag == YES && audioPlayer.volume < 1.0) {
        audioPlayer.volume = audioPlayer.volume + 0.02;
        [self performSelector:@selector(fadeVolumeUp) withObject:nil afterDelay:0.1];
        _announceIndicator.hidden = true;
    }
    NSLog( @"calling: %s", __PRETTY_FUNCTION__ );
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playPreshow:(id)sender {
    [audioPlayer play];
    _audioIndicator.hidden = false;
    NSLog( @"calling: %s", __PRETTY_FUNCTION__ );
}

- (IBAction)playAnnounce:(id)sender {
    _announceIndicator.hidden = false;
    if (audioPlayer.volume > 0.3) {
        audioPlayer.volume = audioPlayer.volume - 0.05;
        [self performSelector:@selector(fadeVolumeDown) withObject:nil afterDelay:0.1];
    }
    [announcementPlayer play];
    [self performSelector:@selector(audioPlayerDidFinishPlaying:successfully:) withObject:nil afterDelay:0.1];
    NSLog( @"calling: %s", __PRETTY_FUNCTION__ );
}

- (IBAction)stopPreshow:(id)sender {
    if (audioPlayer.volume > 0.0) {
        audioPlayer.volume = audioPlayer.volume - 0.02;
        [self performSelector:@selector(fadeVolumeOut) withObject:nil afterDelay:0.1];
    }
    [announcementPlayer stop];
    [announcementPlayer setVolume:0.4];
    announcementPlayer.currentTime = 0;
    _audioIndicator.hidden = true;
    _announceIndicator.hidden = true;
    NSLog( @"calling: %s", __PRETTY_FUNCTION__ );
}

@end
