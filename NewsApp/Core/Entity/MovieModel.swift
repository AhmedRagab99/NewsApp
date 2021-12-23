import Foundation

struct MovieResult: Codable {
    let page, totalResults, totalPages: Int?
    let results: [Movie]?
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults
//        = "total_results"
        case totalPages = "total_pages"
        case results
    }
}


struct Genre:Codable{
    let id:Int
    let name:String
}

// MARK: - Result
struct Movie: Codable,Identifiable,Equatable,Hashable {
    let popularity: Double?
    let video: Bool?
    let posterPath: String?
    let mediaType:MediaType?
    let id: Int?
    let budget:Int?
    let backdropPath:String?
    let originalLanguage, title: String?
    let voteAverage: Double?
    let overview:String?
    let releaseDate:String?
    let genreIDS:[Int]?
    let revenue:Int?
   
   
    
    
    enum CodingKeys: String, CodingKey {
        case popularity, video
        case revenue,budget
        case mediaType = "media_type"
        case genreIDS = "genre_ids"
        case posterPath = "poster_path"
        case id
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }
    
    enum MediaType: String, Codable {
        case movie = "movie"
        case tv = "tv"
    }
    
    
    
 
    static private let durationFormatter: DateComponentsFormatter = {
            let formatter = DateComponentsFormatter()
            formatter.unitsStyle = .full
            formatter.allowedUnits = [.hour, .minute]
            return formatter
        }()
        
        public var posterURL: URL {
            return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? " ")") ??  URL(string: "https://www.pexels.com/photo/person-holding-photo-of-single-tree-at-daytime-1252983/")!
        }
        
        public var backdropURL: URL {
            return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
        }
        
        public var voteAveragePercentText: String {
            return "\(Int(voteAverage ?? 0 * 10))%"
        }
        
    
    public var ratingText: String {
        let rating = Int(voteAverage ?? 0)
        let ratingText = (0..<rating).reduce("") { (acc, _) -> String in
            return acc + "⭐️"
        }
        return ratingText
    }
}
