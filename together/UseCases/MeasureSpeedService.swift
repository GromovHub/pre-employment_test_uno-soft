//
//Project name: together
//
//Copyright © Gromov V.O., 2024
//

import Foundation
import Alamofire

class MeasureSpeedService {
    
    func measureDownloadSpeed(url: String, completion: @escaping (String)-> Void) {
        guard let url = URL(string: url) else { completion("bad url"); return }
        let startTime = Date()

        let task = URLSession.shared.downloadTask(with: url) { localURL, response, error in
            let endTime = Date()
            let timeInterval = endTime.timeIntervalSince(startTime)
            
            guard let localURL = localURL, let data = try? Data(contentsOf: localURL) else {
                // Handle error
                print("can not convert to data")
                completion(error?.localizedDescription ?? "error")
                return
            }
            
            let fileSize = Double(data.count) // Size in bytes
            let speed = fileSize / timeInterval // Speed in bytes per second
            print("Download Speed: \(speed) bytes per second, and \(speed / 1_000_000) mbs")
            let formattedSpeed = String(format: "%.2f", speed / 1_000_000)
            completion("\(formattedSpeed) mbps")
        }

        task.resume()
    }
    
    func measureUploadSpeed(url: String, completion: @escaping (String)-> Void) {
        guard let url = URL(string: url) else { completion("bad url"); return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // Create some data to upload
        let uploadData = Data(repeating: 0, count: 1_000_000) // 1 MB of zero bytes
        let startTime = Date()

        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
            let endTime = Date()
            let timeInterval = endTime.timeIntervalSince(startTime)
            
            let fileSize = Double(uploadData.count) // Size in bytes
            let speed = fileSize / timeInterval // Speed in bytes per second
            print("Upload Speed: \(speed) bytes per second")
            let formattedSpeed = String(format: "%.2f", speed / 1_000_000)
            completion("\(formattedSpeed) mbps")
        }

        task.resume()
    }
}
