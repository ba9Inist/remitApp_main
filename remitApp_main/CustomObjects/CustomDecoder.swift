//
//  CustomDecoder.swift
//  remitApp_main
//
//  Created by Егор Голубев on 24.10.2025.
//

import Foundation

class CustomDecoder {
    
    func getCustomDecoder() -> JSONDecoder {
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
            let container = try decoder.singleValueContainer()
            let dateStr = try container.decode(String.self)
            
            // Формат даты без временного пояса
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.locale = Locale(identifier: "en_US_POSIX")
            
            guard let date = formatter.date(from: dateStr) else {
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date format.")
            }
            return date
        })
        
        return decoder
    }
    
    func decoderErrorDescription(_ error: Error) {
        
        if let decErr = error as? DecodingError {
            
            switch decErr {
            case .dataCorrupted(let context):
                print(DecodingError.dataCorrupted(context))
            case .typeMismatch(let type, let context):
                print(DecodingError.typeMismatch(type, context))
            case .valueNotFound(let value, let context):
                print(DecodingError.valueNotFound(value, context))
            case .keyNotFound(let key, let context):
                print(DecodingError.keyNotFound(key, context))
            @unknown default:
                print(decErr.localizedDescription)
            }
            
        } else {
            print("Переменная error имеет тип: \(type(of: error))")
        }
        
    }
}
