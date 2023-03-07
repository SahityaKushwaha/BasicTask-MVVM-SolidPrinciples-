

import Foundation
struct Profiles : Codable {
	let first_name : String?
	let avatar : String?
    let general_information: General_information?
    let photos: [Photos]?

	enum CodingKeys: String, CodingKey {

		case first_name = "first_name"
		case avatar = "avatar"
        case general_information = "general_information"
        case photos = "photos"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
		avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
        general_information = try values.decodeIfPresent(General_information.self, forKey: .general_information)
        photos = try values.decodeIfPresent([Photos].self, forKey: .photos)
	}

}
