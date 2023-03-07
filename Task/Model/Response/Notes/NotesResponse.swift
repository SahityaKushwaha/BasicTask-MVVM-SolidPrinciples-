

import Foundation
struct NotesResponse : Codable {
	let invites : Invites?
	let likes : Likes?

	enum CodingKeys: String, CodingKey {

		case invites = "invites"
		case likes = "likes"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		invites = try values.decodeIfPresent(Invites.self, forKey: .invites)
		likes = try values.decodeIfPresent(Likes.self, forKey: .likes)
	}

}
