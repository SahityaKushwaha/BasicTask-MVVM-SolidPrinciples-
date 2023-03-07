

import Foundation
struct Likes : Codable {
	let profiles : [Profiles]?
	let can_see_profile : Bool?
	let likes_received_count : Int?

	enum CodingKeys: String, CodingKey {

		case profiles = "profiles"
		case can_see_profile = "can_see_profile"
		case likes_received_count = "likes_received_count"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		profiles = try values.decodeIfPresent([Profiles].self, forKey: .profiles)
		can_see_profile = try values.decodeIfPresent(Bool.self, forKey: .can_see_profile)
		likes_received_count = try values.decodeIfPresent(Int.self, forKey: .likes_received_count)
	}

}
