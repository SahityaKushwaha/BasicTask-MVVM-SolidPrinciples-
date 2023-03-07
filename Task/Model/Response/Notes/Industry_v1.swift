

import Foundation
struct Industry_v1 : Codable {
	let id : Int?
	let name : String?
	let preference_only : Bool?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case name = "name"
		case preference_only = "preference_only"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		preference_only = try values.decodeIfPresent(Bool.self, forKey: .preference_only)
	}

}
