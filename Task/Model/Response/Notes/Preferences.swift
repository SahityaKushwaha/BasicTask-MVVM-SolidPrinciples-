
import Foundation
struct Preferences : Codable {
	let answer_id : Int?
	let answer : String?
	let first_choice : String?
	let second_choice : String?

	enum CodingKeys: String, CodingKey {

		case answer_id = "answer_id"
		case answer = "answer"
		case first_choice = "first_choice"
		case second_choice = "second_choice"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		answer_id = try values.decodeIfPresent(Int.self, forKey: .answer_id)
		answer = try values.decodeIfPresent(String.self, forKey: .answer)
		first_choice = try values.decodeIfPresent(String.self, forKey: .first_choice)
		second_choice = try values.decodeIfPresent(String.self, forKey: .second_choice)
	}

}
