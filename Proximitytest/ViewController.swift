//
//  ViewController.swift
//  Proximitytest
//

import UIKit

//blueberrry_1! break room
let BEACON_1_UUID = "B9407F30-F5F8-466E-AFF9-25556B57FE6D"
let BEACON_1_MAJOR: CLBeaconMajorValue = 4543
let BEACON_1_MINOR: CLBeaconMinorValue = 24404

//blueberry_2 ashely and rich
let BEACON_2_UUID = "B9407F30-F5F8-466E-AFF9-25556B57FE6D"
let BEACON_2_MAJOR: CLBeaconMajorValue = 25707
let BEACON_2_MINOR: CLBeaconMinorValue = 14226

//ice_1 hans
let BEACON_3_UUID = "B9407F30-F5F8-466E-AFF9-25556B57FE6D"
let BEACON_3_MAJOR: CLBeaconMajorValue = 21214
let BEACON_3_MINOR: CLBeaconMinorValue = 33375

//ice_2 entrance
let BEACON_4_UUID = "B9407F30-F5F8-466E-AFF9-25556B57FE6D"
let BEACON_4_MAJOR: CLBeaconMajorValue = 61045
let BEACON_4_MINOR: CLBeaconMinorValue = 16636



func isBeacon(beacon: CLBeacon, withUUID UUIDString: String, major: CLBeaconMajorValue, minor: CLBeaconMinorValue) -> Bool {
    return beacon.proximityUUID.UUIDString == UUIDString && beacon.major.unsignedShortValue == major && beacon.minor.unsignedShortValue == minor
}

class ViewController: UIViewController, ESTBeaconManagerDelegate {
    


    let beaconManager = ESTBeaconManager()

    let beaconRegion1 = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: BEACON_1_UUID)!, major: BEACON_1_MAJOR, minor: BEACON_1_MINOR, identifier: "beaconRegion1")
    let beaconRegion2 = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: BEACON_2_UUID)!, major: BEACON_2_MAJOR, minor: BEACON_2_MINOR, identifier: "beaconRegion2")
    let beaconRegion3 = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: BEACON_3_UUID)!, major: BEACON_3_MAJOR, minor: BEACON_3_MINOR, identifier: "beaconRegion3")
    let beaconRegion4 = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: BEACON_4_UUID)!, major: BEACON_4_MAJOR, minor: BEACON_4_MINOR, identifier: "beaconRegion4")

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.beaconManager.delegate = self
        self.beaconManager.returnAllRangedBeaconsAtOnce = true
        self.beaconManager.startMonitoringForRegion(beaconRegion1!)
        self.beaconManager.startMonitoringForRegion(beaconRegion2!)
        self.beaconManager.startMonitoringForRegion(beaconRegion3!)
        self.beaconManager.startMonitoringForRegion(beaconRegion4!)
        

        self.beaconManager.requestWhenInUseAuthorization()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        self.beaconManager.startRangingBeaconsInRegion(self.beaconRegion1)
        self.beaconManager.startRangingBeaconsInRegion(self.beaconRegion2)
        self.beaconManager.startRangingBeaconsInRegion(self.beaconRegion3)
        self.beaconManager.startRangingBeaconsInRegion(self.beaconRegion4)
    }

    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)

        self.beaconManager.stopRangingBeaconsInRegion(self.beaconRegion1)
        self.beaconManager.stopRangingBeaconsInRegion(self.beaconRegion2)
        self.beaconManager.stopRangingBeaconsInRegion(self.beaconRegion3)
        self.beaconManager.stopRangingBeaconsInRegion(self.beaconRegion4)
    }

    func beaconManager(manager: AnyObject!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        if let neareastBeacon = beacons.first as? CLBeacon {
            if isBeacon(neareastBeacon, withUUID: BEACON_1_UUID, BEACON_1_MAJOR, BEACON_1_MINOR) {
                // beacon #1
                self.label.text = "You're near the break room table"
                self.imageView.image = UIImage(named: "Beacon1")
            }
            else if isBeacon(neareastBeacon, withUUID: BEACON_2_UUID, BEACON_2_MAJOR, BEACON_2_MINOR) {
                // beacon #2
                self.label.text = "You're near Ashley and Rich"
                self.imageView.image = UIImage(named: "Beacon2")
            }
            else if isBeacon(neareastBeacon, withUUID: BEACON_3_UUID, BEACON_3_MAJOR, BEACON_3_MINOR) {
                // beacon #3
                self.label.text = "You're near Hans! Beware"
                self.imageView.image = UIImage(named: "Beacon3")
            }
            else if isBeacon(neareastBeacon, withUUID: BEACON_4_UUID, BEACON_4_MAJOR, BEACON_4_MINOR) {
                // beacon #4
                self.label.text = "You're near the secret Delek entrance"
                self.imageView.image = UIImage(named: "Beacon4")
            }
            
        } else {
            // no beacons found
            self.label.text = "Keep moving. Zombies nearby!"
            self.imageView.image = UIImage(named: "NoBeacons")
        }
    }

    func beaconManager(manager: AnyObject!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .Denied || status == .Restricted {
            NSLog("Location Services authorization denied, can't range")
        }
    }

    func beaconManager(manager: AnyObject!, rangingBeaconsDidFailForRegion region: CLBeaconRegion!, withError error: NSError!) {
        NSLog("Ranging beacons failed for region '%@'\n\nMake sure that Bluetooth and Location Services are on, and that Location Services are allowed for this app. Also note that iOS simulator doesn't support Bluetooth.\n\nThe error was: %@", region.identifier, error);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

