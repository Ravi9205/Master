//
//  ArticleList.swift
//  NYArticle
//
//  Created by Ravi dwivedi on 09/12/19.
//  Copyright © 2019 Ravi dwivedi. All rights reserved.
//

import Foundation

class ArticleList{
    var title:String?
    var published_date:String?
    var media:Array<Any>?
    var media_metadata:Array<Any>?
   
    init(data:[String:Any]) {
        
        if let title =  data["title"] as? String {
            self.title = title
            
        }
        if let published_date =  data["published_date"] as? String{
            self.published_date = published_date
        }
        
        if let media =  data["media"] as? Array<Any>{
            self.media = media
        }
        
    
        if let media_metadata =  data["media-metadata"] as? Array<Any>{
            self.media_metadata = media_metadata
        }
        
    }

    
    
    
}
