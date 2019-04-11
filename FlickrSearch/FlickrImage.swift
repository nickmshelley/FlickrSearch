
import Foundation

struct FlickrImage: Codable {
    let id: String
    let title: String
    let secret: String
    let server: String
    let farm: Int
    
    func imageURL(isThumbnail: Bool = false) -> URL? {
        let letter = isThumbnail ? "s" : "z"
        return URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_\(letter).jpg")
    }
}
