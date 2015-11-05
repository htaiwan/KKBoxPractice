//
//  ViewController.swift
//  KK_Operation
//
//  Created by CHENG-TAI CHENG on 11/5/15.
//  Copyright © 2015 CHENG-TAI CHENG. All rights reserved.
//

import UIKit

class ViewController: UIViewController,HTTPBinManagerDelegate {

    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var imageView: UIImageView!
    
    let manager = HTTPBinManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        manager.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Button

    @IBAction func start(sender: UIButton) {
        manager.executeOperation()
    }

    @IBAction func cancel(sender: UIButton) {
        manager.cancelOperation()
    }
    
    
    // MARK: - HTTPBinManagerDelegate
    
    func HTTPBinManagerDidFail() {
        print("HTTPBinManagerDidFail")
        
    }
    
    func HTTPBinManagerDidCancel() {
        print("HTTPBinManagerDidCancel")
    }
    
    func HTTPBinManagerDidSuccess(dic1: NSDictionary, dic2: NSDictionary, image: UIImage) {
        print("HTTPBinManagerDidSuccess")
        print("dic1: \(dic1)")
        print("dic2: \(dic2)")
        
        imageView.image = image


    }
    
    func HTTPBinManagerUpdateProgress(progrss: Float) {
        print("HTTPBinManagerUpdateProgress \(progrss)")
        progressView.progress = progrss
    }
    
}

