//
//  ChuckAPI.swift
//  ChuckNorrisFacts
//
//  Created by Lorhany Moraes on 29/06/22.
//

import Foundation
import Alamofire

class ChuckAPI {
    static private let basePath = "https://api.chucknorris.io/jokes/random"
    
    
    class func loadCategorys(name: String?, page: Int = 0, onComplete: @escaping (ChuckInfo?) -> Void) {
       
        let url = basePath
    
    AF.request(url).responseJSON { (response) in
        guard let data = response.data else {
            onComplete(nil)
            return
        }
        do {
            let chuckInfo = try JSONDecoder().decode(ChuckInfo.self, from: data)
            
            onComplete(chuckInfo)
        } catch {
            print(error.localizedDescription)
            onComplete(nil)
        }
    
        }
}
}
