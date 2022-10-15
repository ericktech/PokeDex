//
//  PokemonDetailModel.swift
//  PokeDex
//
//  Created by Erick Leal on 14/10/22.
//

import Foundation

// MARK: - PokeDetail
struct PokemonDetailModel: Codable {
    var baseExperience, height, id: Int?
    var isDefault: Bool?
    var name: String?
    var sprites: Sprites?
    var stats: [Stat]?
    var types: [Types]?
    var weight: Int?

    enum CodingKeys: String, CodingKey {
        case baseExperience = "base_experience"
        case height, id
        case isDefault = "is_default"
        case name, sprites, stats, types, weight
    }
}

// MARK: - MoveElement
struct Moves: Codable {
    var move: StatClass?
    var versionGroupDetails: [VersionGroupDetail]?

    enum CodingKeys: String, CodingKey {
        case move
        case versionGroupDetails = "version_group_details"
    }
}

// MARK: - StatClass
struct StatClass: Codable {
    var name: String?
    var url: String?
}

// MARK: - VersionGroupDetail
struct VersionGroupDetail: Codable {
    var levelLearnedAt: Int?
    var moveLearnMethod, versionGroup: StatClass?

    enum CodingKeys: String, CodingKey {
        case levelLearnedAt = "level_learned_at"
        case moveLearnMethod = "move_learn_method"
        case versionGroup = "version_group"
    }
}

// MARK: - GenerationV
struct GenerationV: Codable {
    var blackWhite: Sprites?

    enum CodingKeys: String, CodingKey {
        case blackWhite = "black-white"
    }
}

// MARK: - GenerationIv
struct GenerationIv: Codable {
    var diamondPearl, heartgoldSoulsilver, platinum: Sprites?

    enum CodingKeys: String, CodingKey {
        case diamondPearl = "diamond-pearl"
        case heartgoldSoulsilver = "heartgold-soulsilver"
        case platinum
    }
}

// MARK: - Versions
struct Versions: Codable {
    var generationI: GenerationI?
    var generationIi: GenerationIi?
    var generationIii: GenerationIii?
    var generationIv: GenerationIv?
    var generationV: GenerationV?
    var generationVi: [String: Home]?
    var generationVii: GenerationVii?
    var generationViii: GenerationViii?

    enum CodingKeys: String, CodingKey {
        case generationI = "generation-i"
        case generationIi = "generation-ii"
        case generationIii = "generation-iii"
        case generationIv = "generation-iv"
        case generationV = "generation-v"
        case generationVi = "generation-vi"
        case generationVii = "generation-vii"
        case generationViii = "generation-viii"
    }
}

// MARK: - Sprites
class Sprites: Codable {
    var backDefault: String?
    var backFemale: String?
    var backShiny: String?
    var backShinyFemale: String?
    var frontDefault: String?
    var frontFemale: String?
    var frontShiny: String?
    var frontShinyFemale: String?
    var versions: Versions?
    var animated: Sprites?

    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backFemale = "back_female"
        case backShiny = "back_shiny"
        case backShinyFemale = "back_shiny_female"
        case frontDefault = "front_default"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
        case versions, animated
    }

    init(backDefault: String?, backFemale: String?, backShiny: String?, backShinyFemale: String?, frontDefault: String?, frontFemale: String?, frontShiny: String?, frontShinyFemale: String?, versions: Versions?, animated: Sprites?) {
        self.backDefault = backDefault
        self.backFemale = backFemale
        self.backShiny = backShiny
        self.backShinyFemale = backShinyFemale
        self.frontDefault = frontDefault
        self.frontFemale = frontFemale
        self.frontShiny = frontShiny
        self.frontShinyFemale = frontShinyFemale
        self.versions = versions
        self.animated = animated
    }
}

// MARK: - GenerationI
struct GenerationI: Codable {
    var redBlue, yellow: RedBlue?

    enum CodingKeys: String, CodingKey {
        case redBlue = "red-blue"
        case yellow
    }
}

// MARK: - RedBlue
struct RedBlue: Codable {
    var backDefault, backGray, backTransparent, frontDefault: String?
    var frontGray, frontTransparent: String?

    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backGray = "back_gray"
        case backTransparent = "back_transparent"
        case frontDefault = "front_default"
        case frontGray = "front_gray"
        case frontTransparent = "front_transparent"
    }
}

// MARK: - GenerationIi
struct GenerationIi: Codable {
    var crystal: Crystal?
    var gold, silver: Gold?
}

// MARK: - Crystal
struct Crystal: Codable {
    var backDefault, backShiny, backShinyTransparent, backTransparent: String?
    var frontDefault, frontShiny, frontShinyTransparent, frontTransparent: String?

    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backShiny = "back_shiny"
        case backShinyTransparent = "back_shiny_transparent"
        case backTransparent = "back_transparent"
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
        case frontShinyTransparent = "front_shiny_transparent"
        case frontTransparent = "front_transparent"
    }
}

// MARK: - Gold
struct Gold: Codable {
    var backDefault, backShiny, frontDefault, frontShiny: String?
    var frontTransparent: String?

    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backShiny = "back_shiny"
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
        case frontTransparent = "front_transparent"
    }
}

// MARK: - GenerationIii
struct GenerationIii: Codable {
    var emerald: Emerald?
    var fireredLeafgreen, rubySapphire: Gold?

    enum CodingKeys: String, CodingKey {
        case emerald
        case fireredLeafgreen = "firered-leafgreen"
        case rubySapphire = "ruby-sapphire"
    }
}

// MARK: - Emerald
struct Emerald: Codable {
    var frontDefault, frontShiny: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
}

// MARK: - Home
struct Home: Codable {
    var frontDefault: String?
    var frontFemale: String?
    var frontShiny: String?
    var frontShinyFemale: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
    }
}

// MARK: - GenerationVii
struct GenerationVii: Codable {
    var icons: DreamWorld?
    var ultraSunUltraMoon: Home?

    enum CodingKeys: String, CodingKey {
        case icons
        case ultraSunUltraMoon = "ultra-sun-ultra-moon"
    }
}

// MARK: - DreamWorld
struct DreamWorld: Codable {
    var frontDefault: String?
    var frontFemale: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontFemale = "front_female"
    }
}

// MARK: - GenerationViii
struct GenerationViii: Codable {
    var icons: DreamWorld?
}

// MARK: - Other
struct Other: Codable {
    var dreamWorld: DreamWorld?
    var home: Home?
    var officialArtwork: OfficialArtwork?

    enum CodingKeys: String, CodingKey {
        case dreamWorld = "dream_world"
        case home
        case officialArtwork = "official-artwork"
    }
}

// MARK: - OfficialArtwork
struct OfficialArtwork: Codable {
    var frontDefault: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

// MARK: - Stat
struct Stat: Codable {
    var baseStat, effort: Int?
    var stat: StatClass?

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}

// MARK: - TypeElement
struct Types: Codable {
    var slot: Int?
    var type: StatClass?
}

