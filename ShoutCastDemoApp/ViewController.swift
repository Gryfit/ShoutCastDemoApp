//
//  ViewController.swift
//  ShoutCastDemoApp
//
//  Created by Kalaivani, Velusamy  on 07/04/19.
//  Copyright © 2019 Kalaivani, Velusamy  All rights reserved.
//

import UIKit

class ViewController: UIViewController,FSAudioControllerDelegate {

    var audioStream : FSAudioStream
    var audioCtrller : FSAudioController
    var progressTimer : Timer?
    var streamInfo : NSMutableString
    
    @IBOutlet var progressSlider: UISlider!

    @IBOutlet var stationName: UILabel!
    @IBOutlet var albumName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playRadio()
    }
    required init?(coder aDecoder: NSCoder) {
        self.audioStream = FSAudioStream.init()
        self.audioCtrller = FSAudioController.init()
        self.progressTimer = Timer()
        self.streamInfo = NSMutableString()

        super.init(coder: aDecoder)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.progressTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(progressTimerChanged), userInfo: nil, repeats: true)
        
        
    }
    
   

    @IBAction func playAudio(_ sender: UIButton) {
        if self.audioCtrller.isPlaying(){
            //sender.setTitle("Play", for: .normal)
            sender.setImage(UIImage(named: "Play"), for: .normal)
            self.view.setNeedsLayout()
            self.audioCtrller.pause()
        }
        else{
            //sender.setTitle("Pause", for: .normal)
            sender.setImage(UIImage(named: "Pause"), for: .normal)
            self.view.setNeedsLayout()
            self.playRadio()
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func progressTimerChanged(){
        
            self.progressSlider.isEnabled = true;
            
            var cur : FSStreamPosition
            var end : FSStreamPosition
            
             cur = self.audioCtrller.activeStream.currentTimePlayed;
             end = self.audioCtrller.activeStream.duration;
        
            print(cur.position)
            self.progressSlider.value = cur.position;
        
        self.audioCtrller.activeStream.onMetaDataAvailable = { userData in
            
            var MetaDataDict : Dictionary = Dictionary<AnyHashable,Any>()
            MetaDataDict = userData!
            print("meta data")
            self.stationName.text = MetaDataDict["IcecastStationName"] as? String
            self.albumName.text = MetaDataDict["StreamTitle"] as? String

        }
 
    }
    
        
    func playRadio(){
        
//        self.audioStream.strictContentTypeChecking = false;
//        self.audioStream.defaultContentType = "audio/mpeg";
//        self.audioStream.play(from: URL(string: "http://yp.shoutcast.com/sbin/tunein-station.pls?id=1826116"))
        
        
       // let url = URL(string: "http://yp.shoutcast.com/sbin/tunein-station.pls?id=1826116")
        let url = URL(string:"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1595898")
        self.audioCtrller.play(from: url);

        
    }


}

