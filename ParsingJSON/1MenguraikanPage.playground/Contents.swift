import UIKit

/*
 Gunakanlah API Key Anda
 Silakan daftar di https://www.dicoding.com/blog/registrasi-testing-themoviedb-api/.
 */

let apiKey = "API KEY"
let language = "en-US"
let page = "1"
 
var components = URLComponents(string: "https://api.themoviedb.org/3/movie/popular")!
 
components.queryItems = [
    URLQueryItem(name: "api_key", value: apiKey),
    URLQueryItem(name: "language", value: language),
    URLQueryItem(name: "page", value: page)
]
 
let request = URLRequest(url: components.url!)
 
let task = URLSession.shared.dataTask(with: request) { data, response, error in
    guard let response = response as? HTTPURLResponse, let data = data else { return }
    
    if response.statusCode == 200 {
        decodeJSON(data: data)
    } else {
        print("ERROR: \(data), HTTP Status: \(response.statusCode)")
    }
}
 
task.resume()
 
struct Movies: Codable {
    let page: Int
    let total_results: Int
    let total_pages: Int
}
 
private func decodeJSON(data: Data) {
    let decoder = JSONDecoder()
    
    let movies = try! decoder.decode(Movies.self, from: data)
    
    print("PAGE: \(movies.page)")
    print("TOTAL RESULTS: \(movies.total_results)")
    print("TOTAL PAGES: \(movies.total_pages)")
}
