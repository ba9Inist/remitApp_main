//
//  realmManager.swift
//  remitApp_main
//
//  Created by Егор Голубев on 12.09.2025.
//

import Foundation
import RealmSwift

final class InformationUserRealm: Object {
    @Persisted(primaryKey: true) var uuidUser: String 
    @Persisted var surname: String
    @Persisted var name: String
    @Persisted var patronymic: String
    @Persisted var dateOfBirth: Date
    @Persisted var loyaltyCardNumber: String
    @Persisted var mentor: Bool
    @Persisted var gender: String
    @Persisted var phoneNumber: String
    @Persisted var director: String
    @Persisted var department: String
    @Persisted var experience: Float
    @Persisted var post: String
    @Persisted var driver: Bool
    @Persisted var photoUser: String
    @Persisted var countTonar: String
    @Persisted var employeeRating: Int?
    @Persisted var competention: Int?
    @Persisted var listCompetencies: List<ListCompetenciesRealm>
    @Persisted var News: List<NewsRealm>
    @Persisted var vacation: List<listVacationRealm>
    @Persisted var daysVacation: Int
    @Persisted var historyChat: List<listChatRealm>
    @Persisted var currentVersionApp: Int
    @Persisted var welcomeTextDms: String
    @Persisted var dms: List <listDmsRealme>
}

final class ListCompetenciesRealm: Object {
    @Persisted var ratingPercent: Int
    @Persisted var dateCertification: Date
    @Persisted var area: String
    @Persisted var admittedWork: Bool
    @Persisted(originProperty: "listCompetencies") var parentInfoUser: LinkingObjects<InformationUserRealm>
}

final class NewsRealm: Object {
    @Persisted var nameNews: String
    @Persisted var textNews: String
    @Persisted var colorHex: String
    @Persisted var date: Date
    @Persisted(originProperty: "News") var parentInfoUser: LinkingObjects<InformationUserRealm>
}

final class listVacationRealm: Object {
    @Persisted var startOfVacation: Date
    @Persisted var endOfVacation: Date
    @Persisted var pastVacation: Bool
    @Persisted var days: Int
    @Persisted(originProperty: "vacation") var parentInfoUser: LinkingObjects<InformationUserRealm>
}

final class listChatRealm: Object {
    @Persisted var code: Int
    @Persisted var textMessage: String
    @Persisted var anonim: Bool
    @Persisted var inputMessage: Bool
    @Persisted var dateMessage: Date
    @Persisted(originProperty: "historyChat") var parentInfoUser: LinkingObjects<InformationUserRealm>
}

final class listDmsRealme: Object {
    @Persisted var name: String
    @Persisted var type: String
    @Persisted var instruction: String
    @Persisted var organization: String
    @Persisted var code: String
    @Persisted var startDate: Date
    @Persisted var endDate: Date
    @Persisted var count: Int
    @Persisted var issued: Bool
    @Persisted(originProperty: "dms") var parentInfoUser: LinkingObjects<InformationUserRealm>
}
