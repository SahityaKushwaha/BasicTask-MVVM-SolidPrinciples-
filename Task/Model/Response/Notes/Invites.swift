

import Foundation
struct Invites : Codable {
	let profiles : [Profiles]?
	let totalPages : Int?
	let pending_invitations_count : Int?

	enum CodingKeys: String, CodingKey {

		case profiles = "profiles"
		case totalPages = "totalPages"
		case pending_invitations_count = "pending_invitations_count"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		profiles = try values.decodeIfPresent([Profiles].self, forKey: .profiles)
		totalPages = try values.decodeIfPresent(Int.self, forKey: .totalPages)
		pending_invitations_count = try values.decodeIfPresent(Int.self, forKey: .pending_invitations_count)
	}

}
