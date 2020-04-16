
//
//  Data Source.swift
//  TableView
//
//  Created by Priyank Ahuja on 16/04/20.
//  Copyright © 2020 Priyank Ahuja. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DataService {
    
    static let instance = DataService()
    
    private init() {
    }
    
    func fetchUsers(_ completion: @escaping CompletionHandler) {
        Alamofire.request(BASE_URL).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                if let json = JSON(data: data).array {
                    var users = [User]()
                    for item in json {
                        let name = item["name"].stringValue
                        let age = item["age"].stringValue
                        let location = item["location"].stringValue
                        let userImage = item["url"].stringValue
                        
                        let newUser = User(name: name, age: age, location: location, userImage: userImage)
                        users.append(newUser)
                    }
                    completion(true,users)
                }else{
                    debugPrint("Error while parsing the data")
                    completion(false, nil)
                }
            } else {
                debugPrint(response.result.error as Any)
                completion(false, nil)
            }
        }
    }
    
}
