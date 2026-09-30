//
//  salaryJsonScheme.swift
//  remitApp_main
//
//  Created by Егор Голубев on 14.03.2026.
//

import Foundation

struct salaryResponceScheme: Decodable {
    let actionName: String
    let additionsSalaryLastMonths: totalValueMonth
    let additionsSalaryCurrentMonths: totalValueMonth
    let LastMonthsSalary: [detailsDay]
    let CurrentMonthsSalary: [detailsDay]
}

struct totalValueMonth: Decodable {
    let incentives: Double // Поощерение
    let mentoring: Double //Наставничество
    let deductions: Double // Удержание
    let brigadiers: Double //Бригадирские
    let hoursWorked: Double // Отбработано часов
    let totalPayment: Double // Итого
}

struct detailsDay: Decodable {
    let date: Date // Дата работы
    let countHoursTime: Double // Часов отработано днем
    let countHoursNight: Double // Часов отработано ночью
    let amountTime: Double //Доплата за день
    let amountPiecework: Double // Сумма за сдельную работу
    let amountPartTime: Double // Сумма за неполный рабочий день
    let amountNight: Double // Доплата за ночь
    let amountAnotherShop: Double // Доплата за работу в другом цеху
    let countHoursPiecework: Double // Количество часов, полный рабочий день
    let countHoursPartTime: Double // Количество часов, неполный рабочий день
    let countHoursAnotherShop: Double // Количесиво часов работы в другом цеху
    let totalAmount: Double // Итог ЗП за день
}


//{
//    "actionName": "salaryProduction",
//    "additionsSalaryLastMonths": {
//        "incentives": 200,
//        "mentoring": 5000,
//        "deductions": 0,
//        "brigadiers": 0,
//        "hoursWorked": 110,
//        "totalPayment": 94780
//    },
//    "additionsSalaryCurrentMonths": {
//        "incentives": 0,
//        "mentoring": 0,
//        "deductions": 0,
//        "brigadiers": 0,
//        "hoursWorked": 77,
//        "totalPayment": 61411
//    },
//    "employee": {
//        "id_full_1C": "83c46592-f0f7-11e5-9f89-001e67445991"
//    },
//    "LastMonthsSalary": [
//        {
//            "date": "2026-02-10T00:00:00",
//            "countHoursTime": 0,
//            "countHoursNight": 7,
//            "amountTime": 0,
//            "amountPiecework": 8960,
//            "amountPartTime": 0,
//            "amountNight": 673,
//            "amountAnotherShop": 0,
//            "countHoursPiecework": 11,
//            "countHoursPartTime": 0,
//            "countHoursAnotherShop": 0,
//            "totalAmount": 9633
//        },
//        {
//            "date": "2026-02-11T00:00:00",
//            "countHoursTime": 0,
//            "countHoursNight": 7,
//            "amountTime": 0,
//            "amountPiecework": 7477,
//            "amountPartTime": 0,
//            "amountNight": 673,
//            "amountAnotherShop": 0,
//            "countHoursPiecework": 11,
//            "countHoursPartTime": 0,
//            "countHoursAnotherShop": 0,
//            "totalAmount": 8150
//        },
//        {
//            "date": "2026-02-14T00:00:00",
//            "countHoursTime": 0,
//            "countHoursNight": 7,
//            "amountTime": 0,
//            "amountPiecework": 8119,
//            "amountPartTime": 0,
//            "amountNight": 673,
//            "amountAnotherShop": 0,
//            "countHoursPiecework": 11,
//            "countHoursPartTime": 0,
//            "countHoursAnotherShop": 0,
//            "totalAmount": 8792
//        },
//        {
//            "date": "2026-02-15T00:00:00",
//            "countHoursTime": 0,
//            "countHoursNight": 7,
//            "amountTime": 0,
//            "amountPiecework": 8830,
//            "amountPartTime": 0,
//            "amountNight": 673,
//            "amountAnotherShop": 0,
//            "countHoursPiecework": 11,
//            "countHoursPartTime": 0,
//            "countHoursAnotherShop": 0,
//            "totalAmount": 9503
//        },
//        {
//            "date": "2026-02-16T00:00:00",
//            "countHoursTime": 0,
//            "countHoursNight": 7,
//            "amountTime": 0,
//            "amountPiecework": 7690,
//            "amountPartTime": 0,
//            "amountNight": 673,
//            "amountAnotherShop": 0,
//            "countHoursPiecework": 11,
//            "countHoursPartTime": 0,
//            "countHoursAnotherShop": 0,
//            "totalAmount": 8363
//        },
//        {
//            "date": "2026-02-19T00:00:00",
//            "countHoursTime": 0,
//            "countHoursNight": 7,
//            "amountTime": 0,
//            "amountPiecework": 7607,
//            "amountPartTime": 0,
//            "amountNight": 673,
//            "amountAnotherShop": 0,
//            "countHoursPiecework": 11,
//            "countHoursPartTime": 0,
//            "countHoursAnotherShop": 0,
//            "totalAmount": 8280
//        },
//        {
//            "date": "2026-02-20T00:00:00",
//            "countHoursTime": 0,
//            "countHoursNight": 7,
//            "amountTime": 0,
//            "amountPiecework": 8243,
//            "amountPartTime": 0,
//            "amountNight": 673,
//            "amountAnotherShop": 0,
//            "countHoursPiecework": 11,
//            "countHoursPartTime": 0,
//            "countHoursAnotherShop": 0,
//            "totalAmount": 8916
//        },
//        {
//            "date": "2026-02-24T00:00:00",
//            "countHoursTime": 0,
//            "countHoursNight": 7,
//            "amountTime": 0,
//            "amountPiecework": 8178,
//            "amountPartTime": 0,
//            "amountNight": 673,
//            "amountAnotherShop": 0,
//            "countHoursPiecework": 11,
//            "countHoursPartTime": 0,
//            "countHoursAnotherShop": 0,
//            "totalAmount": 8851
//        },
//        {
//            "date": "2026-02-25T00:00:00",
//            "countHoursTime": 0,
//            "countHoursNight": 7,
//            "amountTime": 0,
//            "amountPiecework": 8561,
//            "amountPartTime": 0,
//            "amountNight": 673,
//            "amountAnotherShop": 0,
//            "countHoursPiecework": 11,
//            "countHoursPartTime": 0,
//            "countHoursAnotherShop": 0,
//            "totalAmount": 9234
//        },
//        {
//            "date": "2026-02-28T00:00:00",
//            "countHoursTime": 0,
//            "countHoursNight": 7,
//            "amountTime": 0,
//            "amountPiecework": 9185,
//            "amountPartTime": 0,
//            "amountNight": 673,
//            "amountAnotherShop": 0,
//            "countHoursPiecework": 11,
//            "countHoursPartTime": 0,
//            "countHoursAnotherShop": 0,
//            "totalAmount": 9858
//        }
//    ],
//    "CurrentMonthsSalary": [
//        {
//            "date": "2026-03-01T00:00:00",
//            "countHoursTime": 0,
//            "countHoursNight": 7,
//            "amountTime": 0,
//            "amountPiecework": 8191,
//            "amountPartTime": 0,
//            "amountNight": 589,
//            "amountAnotherShop": 0,
//            "countHoursPiecework": 11,
//            "countHoursPartTime": 0,
//            "countHoursAnotherShop": 0,
//            "totalAmount": 8780
//        },
//        {
//            "date": "2026-03-02T00:00:00",
//            "countHoursTime": 0,
//            "countHoursNight": 7,
//            "amountTime": 0,
//            "amountPiecework": 8188,
//            "amountPartTime": 0,
//            "amountNight": 589,
//            "amountAnotherShop": 0,
//            "countHoursPiecework": 11,
//            "countHoursPartTime": 0,
//            "countHoursAnotherShop": 0,
//            "totalAmount": 8777
//        },
//        {
//            "date": "2026-03-05T00:00:00",
//            "countHoursTime": 0,
//            "countHoursNight": 7,
//            "amountTime": 0,
//            "amountPiecework": 7773,
//            "amountPartTime": 0,
//            "amountNight": 589,
//            "amountAnotherShop": 0,
//            "countHoursPiecework": 11,
//            "countHoursPartTime": 0,
//            "countHoursAnotherShop": 0,
//            "totalAmount": 8362
//        },
//        {
//            "date": "2026-03-06T00:00:00",
//            "countHoursTime": 0,
//            "countHoursNight": 7,
//            "amountTime": 0,
//            "amountPiecework": 8130,
//            "amountPartTime": 0,
//            "amountNight": 589,
//            "amountAnotherShop": 0,
//            "countHoursPiecework": 11,
//            "countHoursPartTime": 0,
//            "countHoursAnotherShop": 0,
//            "totalAmount": 8719
//        },
//        {
//            "date": "2026-03-10T00:00:00",
//            "countHoursTime": 0,
//            "countHoursNight": 7,
//            "amountTime": 0,
//            "amountPiecework": 9138,
//            "amountPartTime": 0,
//            "amountNight": 589,
//            "amountAnotherShop": 0,
//            "countHoursPiecework": 11,
//            "countHoursPartTime": 0,
//            "countHoursAnotherShop": 0,
//            "totalAmount": 9727
//        },
//        {
//            "date": "2026-03-11T00:00:00",
//            "countHoursTime": 0,
//            "countHoursNight": 7,
//            "amountTime": 0,
//            "amountPiecework": 8635,
//            "amountPartTime": 0,
//            "amountNight": 589,
//            "amountAnotherShop": 0,
//            "countHoursPiecework": 11,
//            "countHoursPartTime": 0,
//            "countHoursAnotherShop": 0,
//            "totalAmount": 9224
//        },
//        {
//            "date": "2026-03-14T00:00:00",
//            "countHoursTime": 0,
//            "countHoursNight": 7,
//            "amountTime": 0,
//            "amountPiecework": 7233,
//            "amountPartTime": 0,
//            "amountNight": 589,
//            "amountAnotherShop": 0,
//            "countHoursPiecework": 11,
//            "countHoursPartTime": 0,
//            "countHoursAnotherShop": 0,
//            "totalAmount": 7822
//        }
//    ]
//}
