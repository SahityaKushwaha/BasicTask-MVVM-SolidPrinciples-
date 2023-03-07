

import Foundation
struct Profile_data_list : Codable {
	let question : String?
	let preferences : [Preferences]?
	let invitation_type : String?

	enum CodingKeys: String, CodingKey {

		case question = "question"
		case preferences = "preferences"
		case invitation_type = "invitation_type"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		question = try values.decodeIfPresent(String.self, forKey: .question)
		preferences = try values.decodeIfPresent([Preferences].self, forKey: .preferences)
		invitation_type = try values.decodeIfPresent(String.self, forKey: .invitation_type)
	}

}
