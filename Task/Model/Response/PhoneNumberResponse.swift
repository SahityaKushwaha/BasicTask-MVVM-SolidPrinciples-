

import Foundation
struct PhoneNumberResponse : Decodable {
	let status : Bool?

	enum CodingKeys: String, CodingKey {
		case status = "status"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(Bool.self, forKey: .status)
	}

}
