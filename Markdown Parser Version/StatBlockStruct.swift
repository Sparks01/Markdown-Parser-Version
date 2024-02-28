//
//  StatBlockStruct.swift
//  Markdown Parser Version
//
//  Created by JXMUNOZ on 1/24/24.
//

import Foundation

struct DnDStatBlock: Codable {
    var title: String
    var challengeRating: String
    var type: String
    var xp: Int
    var attributes: [String: Int]
    var armorClass: String
    var hitPoints: String
    var speed: String
    var damageVulnerabilities: [String]
    var damageResistances: [String]
    var damageImmunities: [String]
    var conditionImmunities: [String]
    var senses: String
    var languages: String
    var proficiencyBonus: String
    var traits: [String]
    var actions: [String]
    let experiencePoints: Int?
    var stats: Stats?
    var attributesDetailed: Attributes? // This needs custom handling if it's meant to decode from the same "attributes" JSON key
    var immunities: Immunities?

    enum CodingKeys: String, CodingKey {
        case title, challengeRating, type, xp, attributes
        case armorClass, hitPoints, speed
        case damageVulnerabilities, damageResistances, damageImmunities, conditionImmunities
        case senses, languages, proficiencyBonus, traits, actions
        case experiencePoints = "experience_points", stats, immunities
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        challengeRating = try container.decode(String.self, forKey: .challengeRating)
        type = try container.decode(String.self, forKey: .type)
        xp = try container.decode(Int.self, forKey: .xp)
        attributes = try container.decode([String: Int].self, forKey: .attributes)
        armorClass = try container.decode(String.self, forKey: .armorClass)
        hitPoints = try container.decode(String.self, forKey: .hitPoints)
        speed = try container.decode(String.self, forKey: .speed)
        damageVulnerabilities = try container.decode([String].self, forKey: .damageVulnerabilities)
        damageResistances = try container.decode([String].self, forKey: .damageResistances)
        damageImmunities = try container.decode([String].self, forKey: .damageImmunities)
        conditionImmunities = try container.decode([String].self, forKey: .conditionImmunities)
        senses = try container.decode(String.self, forKey: .senses)
        languages = try container.decode(String.self, forKey: .languages)
        proficiencyBonus = try container.decode(String.self, forKey: .proficiencyBonus)
        traits = try container.decode([String].self, forKey: .traits)
        actions = try container.decode([String].self, forKey: .actions)
        experiencePoints = try container.decodeIfPresent(Int.self, forKey: .experiencePoints)
        stats = try container.decodeIfPresent(Stats.self, forKey: .stats)
        immunities = try container.decodeIfPresent(Immunities.self, forKey: .immunities)
        // Custom handling for attributesDetailed is omitted since i

    }
}

extension DnDStatBlock {
    init(title: String, challengeRating: String, type: String, xp: Int,
         attributes: [String: Int], armorClass: String, hitPoints: String,
         speed: String, damageVulnerabilities: [String], damageResistances: [String],
         damageImmunities: [String], conditionImmunities: [String],
         senses: String, languages: String, proficiencyBonus: String,
         traits: [String], actions: [String], experiencePoints: Int?,
         stats: Stats?, attributesDetailed: Attributes?, immunities: Immunities?) {
        self.title = title
        self.challengeRating = challengeRating
        self.type = type
        self.xp = xp
        self.attributes = attributes
        self.armorClass = armorClass
        self.hitPoints = hitPoints
        self.speed = speed
        self.damageVulnerabilities = damageVulnerabilities
        self.damageResistances = damageResistances
        self.damageImmunities = damageImmunities
        self.conditionImmunities = conditionImmunities
        self.senses = senses
        self.languages = languages
        self.proficiencyBonus = proficiencyBonus
        self.traits = traits
        self.actions = actions
        self.experiencePoints = experiencePoints
        self.stats = stats
        self.attributesDetailed = attributesDetailed
        self.immunities = immunities
    }
}

// Ensure Stats, Attributes, and Immunities are properly defined and conform to Codable.


struct Stats: Codable {
    let armorClass: Int
    let hitPoints: Int
    let speed: String
}

struct Attributes: Codable {
    let STR: String
    let DEX: String
    let CON: String
    let INT: String
    let WIS: String
    let CHA: String
}

struct Immunities: Codable {
    let damage: [String]
    let condition: [String]
}
