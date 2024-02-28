//
//  MarkdownParser.swift
//  Markdown Parser Version
//
//  Created by JXMUNOZ on 1/24/24.
//

import Foundation
import Ink

class DnDStatBlockParser {
    func parse(markdown: String) -> DnDStatBlock {
        var statBlock = DnDStatBlock(
            title: "",
            challengeRating: "",
            type: "Medium Undead, Typically Neutral Evil", // Assuming type is static for this example
            xp: 0,
            attributes: [:],
            armorClass: "",
            hitPoints: "",
            speed: "",
            damageVulnerabilities: [],
            damageResistances: [],
            damageImmunities: [],
            conditionImmunities: [],
            senses: "",
            languages: "",
            proficiencyBonus: "",
            traits: [],
            actions: [],
            experiencePoints: nil,
            stats: nil, // Assuming stats need custom handling not shown here
            attributesDetailed: nil, // Assuming detailed attributes need custom handling
            immunities: nil // Assuming immunities need custom handling
        )

        let lines = markdown.components(separatedBy: .newlines)
        var currentParsingSection: ParsingSection? = nil

        for line in lines {
            if line.starts(with: "# ") {
                statBlock.title = line.replacingOccurrences(of: "# ", with: "")
            } else if line.starts(with: "**CR") {
                statBlock.challengeRating = line.extractValue(prefix: "**CR ").trimmingCharacters(in: CharacterSet(charactersIn: "* "))
            } else if line.contains("**XP") {
                let xpString = line.extractValue(prefix: "**XP ")
                statBlock.xp = Int(xpString.filter { $0.isNumber }) ?? 0
            } else if line.starts(with: "**Armor Class") {
                statBlock.armorClass = line.extractValue(prefix: "**Armor Class ")
            } else if line.starts(with: "**Hit Points") {
                statBlock.hitPoints = line.extractValue(prefix: "**Hit Points ")
            } else if line.starts(with: "**Speed") {
                statBlock.speed = line.extractValue(prefix: "**Speed ")
            } else if line.starts(with: "| STR") {
                currentParsingSection = .attributes
                continue
            } else if line.starts(with: "### TRAITS") {
                currentParsingSection = .traits
                continue
            } else if line.starts(with: "### ACTIONS") {
                currentParsingSection = .actions
                continue
            }

            switch currentParsingSection {
            case .attributes:
                if line.starts(with: "|") && !line.starts(with: "| STR") {
                    parseAttributes(line, into: &statBlock)
                }
            case .traits:
                // Corrected line
                if !line.starts(with: "###") && !line.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    statBlock.traits.append(line)
                }
            case .actions:
                // Corrected line
                if !line.starts(with: "###") && !line.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    statBlock.actions.append(line)
                }
            default:
                break
            }
        }

        return statBlock
    }

    private func parseAttributes(_ line: String, into statBlock: inout DnDStatBlock) {
        let attributes = line.split(separator: "|").map { String($0).trimmingCharacters(in: .whitespacesAndNewlines) }
        // Expected to follow the header format exactly, otherwise, adjust indexes accordingly.
        if attributes.count >= 7 { // Including empty first and last splits
            let attributeValues = attributes[1...6].map { $0.components(separatedBy: " ").first! }
            let attributeKeys = ["STR", "DEX", "CON", "INT", "WIS", "CHA"]
            for (key, valueString) in zip(attributeKeys, attributeValues) {
                if let value = Int(valueString) {
                    statBlock.attributes[key] = value
                }
            }
        }
    }

    private enum ParsingSection {
        case attributes, traits, actions
    }
}

private extension String {
    func extractValue(prefix: String) -> String {
        guard let range = self.range(of: prefix) else { return "" }
        return String(self[range.upperBound...]).trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
