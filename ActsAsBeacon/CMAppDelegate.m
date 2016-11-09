//
//  CMAppDelegate.m
//  ActsAsBeacon
//
//  Created by Tim on 11/11/2013.
//  Copyright (c) 2013 Charismatic Megafauna Ltd. All rights reserved.
//

#import "CMAppDelegate.h"
#import <IOBluetooth/IOBluetooth.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "CMBeaconAdvertismentData.h"

@interface CMAppDelegate () <CBPeripheralManagerDelegate>
@property (nonatomic, strong) CBPeripheralManager *manager;
@property (nonatomic, strong) CBPeripheral *mainPeripheral;

@property (nonatomic, weak) IBOutlet NSTextFieldCell *uuidFieldCell;
@property (nonatomic, weak) IBOutlet NSTextFieldCell *majorFieldCell;
@property (nonatomic, weak) IBOutlet NSTextFieldCell *minorFieldCell;
@property (nonatomic, weak) IBOutlet NSTextFieldCell *powerFieldCell;

@property (nonatomic, weak) IBOutlet NSTextField *statusField;
@property (nonatomic, weak) IBOutlet NSButton *toggleButton;

@property (nonatomic) BOOL isBroadcasting;

@end

@implementation CMAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    self.manager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
    
    [self.uuidFieldCell setStringValue:@"B0702880-A295-A8AB-F734-031A98A512DE"];
    [self.majorFieldCell setStringValue:@"5"];
    [self.minorFieldCell setStringValue:@"1000"];
    [self.powerFieldCell setStringValue:@"-58"];
    
    self.isBroadcasting = NO;
    [self.statusField setStringValue:@"Not broadcasting"];
    

    
}

-(void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    
    if (peripheral.state == CBPeripheralManagerStatePoweredOn) {
        
        self.manager = peripheral;
        
//        NSUUID *proximityUUID = [[NSUUID alloc] initWithUUIDString:@"B0702880-A295-A8AB-F734-031A98A512DE"];
//        CMBeaconAdvertismentData *beaconData = [[CMBeaconAdvertismentData alloc] initWithProximityUUID:proximityUUID major:5 minor:5000 measuredPower:-58];
//        [peripheral startAdvertising:beaconData.beaconAdvertisement];
        
    }
}

-(IBAction)didTapToggleButton:(id)sender {
    
    if (self.manager && !self.isBroadcasting) {
    
        NSUUID *proxUUID = [[NSUUID alloc] initWithUUIDString:self.uuidFieldCell.stringValue];
        NSInteger major = [self.majorFieldCell.stringValue integerValue];
        NSInteger minor = [self.minorFieldCell.stringValue integerValue];
        NSInteger power = [self.powerFieldCell.stringValue integerValue];
        
        CMBeaconAdvertismentData *beaconData = [[CMBeaconAdvertismentData alloc] initWithProximityUUID:proxUUID
                                                                                                 major:major
                                                                                                 minor:minor
                                                                                         measuredPower:power];
        
        [self.manager startAdvertising:beaconData.beaconAdvertisement];
        self.isBroadcasting = YES;
        
        [self.statusField setStringValue:@"Broadcasting"];
        [self.toggleButton setTitle:@"Stop broadcasting"];
        
        [self.uuidFieldCell setEditable:NO];
        [self.uuidFieldCell setTextColor:[NSColor lightGrayColor]];
        [self.majorFieldCell setEditable:NO];
        [self.majorFieldCell setTextColor:[NSColor lightGrayColor]];
        [self.minorFieldCell setEditable:NO];
        [self.minorFieldCell setTextColor:[NSColor lightGrayColor]];
        [self.powerFieldCell setEditable:NO];
        [self.powerFieldCell setTextColor:[NSColor lightGrayColor]];
        
    } else if (self.manager && self.isBroadcasting) {
        
        [self.manager stopAdvertising];
        [self.statusField setStringValue:@"Not broadcasting"];
        
        self.isBroadcasting = NO;
        [self.toggleButton setTitle:@"Start broadcasting"];

        [self.uuidFieldCell setEditable:YES];
        [self.uuidFieldCell setTextColor:[NSColor blackColor]];
        [self.majorFieldCell setEditable:YES];
        [self.majorFieldCell setTextColor:[NSColor blackColor]];
        [self.minorFieldCell setEditable:YES];
        [self.minorFieldCell setTextColor:[NSColor blackColor]];
        [self.powerFieldCell setEditable:YES];
        [self.powerFieldCell setTextColor:[NSColor blackColor]];

    }
    
}

@end
