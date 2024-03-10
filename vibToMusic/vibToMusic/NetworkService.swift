import Foundation

class NetworkService {
    static func performSearchRequest(completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let headers = [
            "X-RapidAPI-Key": "eb23d7d04bmsh26ad78ef94040d0p1dc27ejsnf0a99727737e",
            "X-RapidAPI-Host": "shazam.p.rapidapi.com"
        ]

        let urlString = "https://shazam.p.rapidapi.com/search?term=kiss%20the%20rain&locale=en-US&offset=0&limit=5"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: completion)
        dataTask.resume()
    }
}


