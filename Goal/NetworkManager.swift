import Foundation

// MARK: - NetworkResponse
enum NetworkResponse: String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request."
    case outdated = "The URL you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

// MARK: - Result enum
enum Result<String> {
    case success
    case failure(String)
}

// MARK: - NetworkManager
struct NetworkManager {
    static let environment: NetworkEnvironment = .production
    static let movieAPIKey = "7604dc04d5ee57bf0d3989b51605750e"

    private let router = Router<MovieApi>()

    func getNewMovies(page: Int, completion: @escaping (_ movies: [Movie]?, _ error: String?) -> Void) {
        router.request(.newMovies(page: page)) { data, response, error in
            if error != nil {
                completion(nil, "Please check your network connection.")
                return
            }

            guard let response = response as? HTTPURLResponse else {
                completion(nil, "No valid response.")
                return
            }

            let result = self.handleNetworkResponse(response)

            switch result {
            case .success:
                guard let responseData = data else {
                    completion(nil, NetworkResponse.noData.rawValue)
                    return
                }

                do {
                    print(String(data: responseData, encoding: .utf8) ?? "No data")
                    let decodedResponse = try JSONDecoder().decode(MovieResponse.self, from: responseData)
                    let movies = decodedResponse.results.map { $0.toDomain() }
                    completion(movies, nil)
                } catch {
                    completion(nil, NetworkResponse.unableToDecode.rawValue)
                }

            case .failure(let networkFailureError):
                completion(nil, networkFailureError)
            }
        }
    }

    // MARK: - Response Handler
    private func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
