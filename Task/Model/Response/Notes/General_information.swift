

import Foundation
struct General_information : Codable {
	let date_of_birth : String?
	let date_of_birth_v1 : String?
	let location : Location?
	let drinking_v1 : Drinking_v1?
	let first_name : String?
	let gender : String?
	let marital_status_v1 : Marital_status_v1?
	let ref_id : String?
	let smoking_v1 : Smoking_v1?
	let sun_sign_v1 : Sun_sign_v1?
	let mother_tongue : Mother_tongue?
	let faith : Faith?
	let height : Int?
	let cast : String?
	let kid : String?
	let diet : String?
	let politics : String?
	let pet : String?
	let settle : String?
	let mbti : String?
	let age : Int?

	enum CodingKeys: String, CodingKey {

		case date_of_birth = "date_of_birth"
		case date_of_birth_v1 = "date_of_birth_v1"
		case location = "location"
		case drinking_v1 = "drinking_v1"
		case first_name = "first_name"
		case gender = "gender"
		case marital_status_v1 = "marital_status_v1"
		case ref_id = "ref_id"
		case smoking_v1 = "smoking_v1"
		case sun_sign_v1 = "sun_sign_v1"
		case mother_tongue = "mother_tongue"
		case faith = "faith"
		case height = "height"
		case cast = "cast"
		case kid = "kid"
		case diet = "diet"
		case politics = "politics"
		case pet = "pet"
		case settle = "settle"
		case mbti = "mbti"
		case age = "age"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		date_of_birth = try values.decodeIfPresent(String.self, forKey: .date_of_birth)
		date_of_birth_v1 = try values.decodeIfPresent(String.self, forKey: .date_of_birth_v1)
		location = try values.decodeIfPresent(Location.self, forKey: .location)
		drinking_v1 = try values.decodeIfPresent(Drinking_v1.self, forKey: .drinking_v1)
		first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
		gender = try values.decodeIfPresent(String.self, forKey: .gender)
		marital_status_v1 = try values.decodeIfPresent(Marital_status_v1.self, forKey: .marital_status_v1)
		ref_id = try values.decodeIfPresent(String.self, forKey: .ref_id)
		smoking_v1 = try values.decodeIfPresent(Smoking_v1.self, forKey: .smoking_v1)
		sun_sign_v1 = try values.decodeIfPresent(Sun_sign_v1.self, forKey: .sun_sign_v1)
		mother_tongue = try values.decodeIfPresent(Mother_tongue.self, forKey: .mother_tongue)
		faith = try values.decodeIfPresent(Faith.self, forKey: .faith)
		height = try values.decodeIfPresent(Int.self, forKey: .height)
		cast = try values.decodeIfPresent(String.self, forKey: .cast)
		kid = try values.decodeIfPresent(String.self, forKey: .kid)
		diet = try values.decodeIfPresent(String.self, forKey: .diet)
		politics = try values.decodeIfPresent(String.self, forKey: .politics)
		pet = try values.decodeIfPresent(String.self, forKey: .pet)
		settle = try values.decodeIfPresent(String.self, forKey: .settle)
		mbti = try values.decodeIfPresent(String.self, forKey: .mbti)
		age = try values.decodeIfPresent(Int.self, forKey: .age)
	}

}
