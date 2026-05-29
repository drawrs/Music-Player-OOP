import Foundation

protocol Seekable: AnyObject {
    var currentTime: Double { get }
    var seekDuration: Double { get }

    func seek(to time: Double)
}
