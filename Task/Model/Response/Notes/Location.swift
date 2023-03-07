

import Foundation
struct Location : Codable {
	let summary : String?
	let full : String?

	enum CodingKeys: String, CodingKey {

		case summary = "summary"
		case full = "full"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		summary = try values.decodeIfPresent(String.self, forKey: .summary)
		full = try values.decodeIfPresent(String.self, forKey: .full)
	}

}
