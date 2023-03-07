

import Foundation
struct Drinking_v1 : Codable {
	let id : Int?
	let name : String?
	let name_alias : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case name = "name"
		case name_alias = "name_alias"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		name_alias = try values.decodeIfPresent(String.self, forKey: .name_alias)
	}

}
