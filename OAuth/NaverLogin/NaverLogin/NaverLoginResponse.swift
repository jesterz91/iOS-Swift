//
//  NaverLoginResponse.swift
//  NaverLogin
//
//  Created by lee on 2021/02/21.
//

import Foundation

// MARK: - NaverLoginResponse
struct NaverLoginResponse: Decodable {
    let resultcode: String
    let message: String
    let response: User
}

// MARK: - User
struct User: Decodable {
    let id: Int
    let name: String
    let nickname: String
    let profileImage: String
    let email: String
    let mobile: String
    let birthday: String
    let age: String
    let gender: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, nickname, email, mobile, birthday, age, gender
        case profileImage = "profile_image"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = (try? values.decode(Int.self, forKey: .id)) ?? -1
        name = (try? values.decode(String.self, forKey: .name)) ?? ""
        nickname = (try? values.decode(String.self, forKey: .nickname)) ?? ""
        profileImage = (try? values.decode(String.self, forKey: .profileImage)) ?? ""
        email = (try? values.decode(String.self, forKey: .email)) ?? ""
        mobile = (try? values.decode(String.self, forKey: .mobile)) ?? ""
        birthday = (try? values.decode(String.self, forKey: .birthday)) ?? ""
        age = (try? values.decode(String.self, forKey: .age)) ?? ""
        gender = (try? values.decode(String.self, forKey: .gender)) ?? ""
    }
}
