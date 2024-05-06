//
//Project name: together
//
//Copyright © Gromov V.O., 2024
//

import Foundation
import Alamofire

class MeasureSpeedService {

    // Download speed
    func measureDownloadSpeed(serverURL: String, completion: @escaping (Double) -> Void) {
        let start = Date()
        
        AF.request(serverURL)
            .responseData { response in
                guard let data = response.data else {
                    completion(0.0)
                    return
                }
                
                let end = Date()
                let timeInterval = end.timeIntervalSince(start)
                let dataSize = Double(data.count)
                let speed = dataSize / timeInterval
                completion(speed)
            }
    }

    // Upload speed
    func measureUploadSpeed(serverURL: String, dataSize: Int, completion: @escaping (Double) -> Void) {
        let start = Date()
        let data = Data(count: dataSize)
        
        AF.upload(data, to: serverURL)
            .responseData { response in
                let end = Date()
                let timeInterval = end.timeIntervalSince(start)
                let speed = Double(dataSize) / timeInterval
                completion(speed)
            }
    }

}
