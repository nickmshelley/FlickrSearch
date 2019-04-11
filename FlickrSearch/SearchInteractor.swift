
import Foundation

class SearchInteractor {
    static func search(text: String, page: Int = 1, completion: @escaping ([FlickrImage]) -> Void) {
        guard !text.isEmpty else { return completion([]) }
        
        var components = URLComponents(string: "https://api.flickr.com/services/rest/")!
        components.queryItems = [
            URLQueryItem(name: "method", value: "flickr.photos.search"),
            URLQueryItem(name: "api_key", value: "1508443e49213ff84d566777dc211f2a"),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "per_page", value: "25"),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "text", value: text),
            URLQueryItem(name: "nojsoncallback", value: "1")
        ]
        
        let task = URLSession.shared.dataTask(with: components.url!) { data, response, error in
            guard let data = data else { return completion([]) }
            
            let json = try! JSONSerialization.jsonObject(with: data, options: [])
            print(json)
        }
        task.resume()
    }
}
