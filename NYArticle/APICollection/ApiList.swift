//
//  ApiList.swift
//  NYArticle
//
//  Created by Ravi dwivedi on 09/12/19.
//  Copyright © 2019 Ravi dwivedi. All rights reserved.
//

import Foundation




let api_Key = "OEJ8iusSi5z0dXOkwoGc2XyGrJdz0wVq"



enum Base : String{
    
    
    case articleList = "https://api.nytimes.com/svc/mostpopular/v2/viewed/7.json?"
     init(fromRawValue: String){
        self = Base(rawValue: fromRawValue) ?? .articleList
    }
    
    static func valueFor(Key : String?)->Base{
        
        guard let key = Key else {
            return Base.articleList
        }
        
        if let base = Base(rawValue: key) {
            return base
        }
        
        return Base.articleList
        
    }
}
