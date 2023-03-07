

import Foundation

struct OTPResponse : Decodable {
    let token : String?
    let title : String?
    let message : String?

    enum CodingKeys: String, CodingKey {
        case token = "token"
        case title = "title"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }

}
