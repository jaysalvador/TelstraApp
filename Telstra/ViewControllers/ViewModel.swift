//
//  ViewModel.swift
//  Telstra
//
//  Created by Jay Salvador on 2/4/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation
import TelstraAPI
import UIKit

typealias ViewModelCallback = (() -> Void)

protocol ViewModelProtocol {
    
    // MARK: - Data
    
    var title: String? { get }
    
    var images: [String: UIImage] { get set }
    var contents: [Content]? { get }
    
    // MARK: - Callbacks
    
    var onUpdated: ViewModelCallback? { get set }
    
    var onError: ViewModelCallback? { get set }
    
    // MARK: - Functions
    
    func getContents()
}

class ViewModel: ViewModelProtocol {
    
    private var client: FeedClient?
    
    // MARK: - Data
    
    var title: String?
    
    var contents: [Content]?
    
    var images: [String : UIImage]
    
    // MARK: - Callbacks
    
    var onUpdated: ViewModelCallback?
    
    var onError: ViewModelCallback?
    
    // MARK: - Init
    
    convenience init() {
        
        self.init(client: FeedClient())
    }
    
    init(client _client: FeedClient?) {
        
        self.client = _client
        
        self.images = [String : UIImage]()
    }
    
    // MARK: - Functions
    
    func getContents() {
        
        self.client?.getFeed { [weak self] response in
            
            switch response {
            case .success(let feed):
            
                self?.title = feed.title
                
                self?.contents = feed.rows?.filter { return !$0.isNil }
                
                self?.contents?.forEach { [weak self] content in
                
                    if let id = content.id {
                        
                        self?.images[id] = nil
                    }
                }
                
                self?.onUpdated?()
                
            case .failure:
                
                self?.onError?()
            }
        }
    }
}
