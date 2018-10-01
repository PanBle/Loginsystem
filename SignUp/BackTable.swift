//
//  BackTable.swift
//  SignUp
//
//  Created by KM_TM on 2018. 9. 27..
//  Copyright © 2018년 KM_TM. All rights reserved.
//

import Foundation

struct Login:Codable {
    let auth:Auth
    let result:Result
    let user:User
    struct Auth :Codable{
        let token:String
    }
    struct Result :Codable{
        let message:String
        let success:Bool
    }
    struct User:Codable {
        let profile:String
        let name:String
        let email:String
    }
}

struct Register :Codable {
    let result:Result
    struct Result:Codable
    {
        let message:String
        let success:Bool
    }
}
