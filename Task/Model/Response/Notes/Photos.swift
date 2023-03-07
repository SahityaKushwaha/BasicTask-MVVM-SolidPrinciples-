

import Foundation
struct Photos : Codable {
	let photo : String?
	let photo_id : Int?
	let selected : Bool?
	let status : String?

	enum CodingKeys: String, CodingKey {

		case photo = "photo"
		case photo_id = "photo_id"
		case selected = "selected"
		case status = "status"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		photo = try values.decodeIfPresent(String.self, forKey: .photo)
		photo_id = try values.decodeIfPresent(Int.self, forKey: .photo_id)
		selected = try values.decodeIfPresent(Bool.self, forKey: .selected)
		status = try values.decodeIfPresent(String.self, forKey: .status)
	}

}
