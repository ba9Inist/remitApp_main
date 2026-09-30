//
//  biometricManager.swift
//  remitApp_main
//
//  Created by Егор Голубев on 19.09.2025.
//

import Foundation
import LocalAuthentication

struct BiometryNotEnrolledError: Error {}

final class biometricManager {
    static let shared = biometricManager()

     func authenticate(reason: String, allowPasswordFallback: Bool = false, completion: @escaping (Result<Void, Error>) -> Void) {
        let context = LAContext()
        var error: NSError?

        let policy: LAPolicy = allowPasswordFallback ? .deviceOwnerAuthentication : .deviceOwnerAuthenticationWithBiometrics

        if context.canEvaluatePolicy(policy, error: &error) {
            context.evaluatePolicy(policy, localizedReason: reason) { success, authError in
                if success {
                    completion(.success(()))
                } else {
                    if let err = authError {
                        switch LAError.Code(rawValue: err._code) {
                        case .biometryNotEnrolled:
                            completion(.failure(BiometryNotEnrolledError()))
                        case .biometryNotAvailable:
                            completion(.failure(BiometryNotEnrolledError()))
                        case .authenticationFailed:
                            completion(.failure(err))
                        case .passcodeNotSet:
                            completion(.failure(BiometryNotEnrolledError()))
                        case .systemCancel:
                            completion(.failure(err))
                        case .userCancel:
                            completion(.failure(err))
                        case .userFallback:
                            completion(.failure(err))
                        case .appCancel:
                            completion(.failure(err))
                        case .invalidContext:
                            completion(.failure(err))
                        case .biometryLockout:
                            completion(.failure(err))
                        default:
                            completion(.failure(err))
                        }
                    } else {
                        completion(.failure(NSError(domain: "", code: 0, userInfo: ["message": "Неопределённая ошибка"])))
                    }
                }
            }
        } else {
            if let err = error {
                completion(.failure(err))
            } else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: ["message": "Биометрия недоступна"])))
            }
        }
    }

    func retryAuthentication(reason: String, allowPasswordFallback: Bool = false, completion: @escaping (Result<Void, Error>) -> Void) {
        authenticate(reason: reason, allowPasswordFallback: allowPasswordFallback, completion: completion)
    }
}
