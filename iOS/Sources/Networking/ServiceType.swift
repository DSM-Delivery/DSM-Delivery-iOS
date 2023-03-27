import Foundation

enum NetworkingResult: Int {
    case getOk = 200
    case created = 201
    case noContent = 204
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case conflict = 409
    case fault = 0
}
