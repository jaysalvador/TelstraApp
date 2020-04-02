//
//  ViewController.swift
//  Telstra
//
//  Created by Jay Salvador on 2/4/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit
import TelstraAPI

class ViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .systemBlue
        
        let client = FeedClient()
        
        client?.getFeed { (response) in
            
            switch response {
            case .success(let feed):
                
                print(feed)
            case .failure(let error):
                
                print(error)
            }
        }
    }


}

