import Foundation

// MARK: - MovieResponse (результат запроса)
struct MovieResponse: Codable {
    let page: Int
    let results: [MovieDTO]
    let totalPages: Int
    let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - MovieDTO (DTO = Data Transfer Object)
struct MovieDTO: Codable {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: OriginalLanguage
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }

    func toDomain() -> Movie {
        return Movie(
            id: id,
            posterPath: posterPath,
            backdrop: backdropPath,
            title: title,
            releaseDate: releaseDate,
            rating: voteAverage,
            overview: overview
        )
    }
}

// MARK: - Movie (чистая модель для UI)
struct Movie {
    let id: Int
    let posterPath: String
    let backdrop: String
    let title: String
    let releaseDate: String
    let rating: Double
    let overview: String
}

// MARK: - OriginalLanguage
enum OriginalLanguage: String, Codable {
    case de, en, hi, pt
}


extension Movie: CustomStringConvertible {
    var description: String {
        return "\(title) (\(releaseDate)) — \(rating)"
    }
}

