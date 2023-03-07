

import Foundation
struct Preference_question : Codable {
	let first_choice : String?
	let second_choice : String?

	enum CodingKeys: String, CodingKey {

		case first_choice = "first_choice"
		case second_choice = "second_choice"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		first_choice = try values.decodeIfPresent(String.self, forKey: .first_choice)
		second_choice = try values.decodeIfPresent(String.self, forKey: .second_choice)
	}

}
