

import Foundation
struct Work : Codable {
	let industry_v1 : Industry_v1?
	let monthly_income_v1 : String?
	let experience_v1 : Experience_v1?
	let highest_qualification_v1 : Highest_qualification_v1?
	let field_of_study_v1 : Field_of_study_v1?

	enum CodingKeys: String, CodingKey {

		case industry_v1 = "industry_v1"
		case monthly_income_v1 = "monthly_income_v1"
		case experience_v1 = "experience_v1"
		case highest_qualification_v1 = "highest_qualification_v1"
		case field_of_study_v1 = "field_of_study_v1"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		industry_v1 = try values.decodeIfPresent(Industry_v1.self, forKey: .industry_v1)
		monthly_income_v1 = try values.decodeIfPresent(String.self, forKey: .monthly_income_v1)
		experience_v1 = try values.decodeIfPresent(Experience_v1.self, forKey: .experience_v1)
		highest_qualification_v1 = try values.decodeIfPresent(Highest_qualification_v1.self, forKey: .highest_qualification_v1)
		field_of_study_v1 = try values.decodeIfPresent(Field_of_study_v1.self, forKey: .field_of_study_v1)
	}

}
