// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let model = try? JSONDecoder().decode(Model.self, from: jsonData)

import Foundation

// MARK: - Model
struct Model: Codable {
    let iupSid, title, documentURL, academicYearID: String
    let academicYear: String
    let semesters: [Semester]

    enum CodingKeys: String, CodingKey {
        case iupSid = "IUPSid"
        case title = "Title"
        case documentURL = "DocumentURL"
        case academicYearID = "AcademicYearId"
        case academicYear = "AcademicYear"
        case semesters = "Semesters"
    }
}

// MARK: - Semester
struct Semester: Codable {
    let number: String
    let disciplines: [Discipline]

    enum CodingKeys: String, CodingKey {
        case number = "Number"
        case disciplines = "Disciplines"
    }
}

// MARK: - Discipline
struct Discipline: Codable {
    let disciplineID: String
    let disciplineName: DisciplineName
    let lesson: [Lesson]

    enum CodingKeys: String, CodingKey {
        case disciplineID = "DisciplineId"
        case disciplineName = "DisciplineName"
        case lesson = "Lesson"
    }
}

// MARK: - DisciplineName
struct DisciplineName: Codable {
    let nameKk, nameRu, nameEn: String
}

// MARK: - Lesson
struct Lesson: Codable {
    let lessonTypeID, hours, realHours: String

    enum CodingKeys: String, CodingKey {
        case lessonTypeID = "LessonTypeId"
        case hours = "Hours"
        case realHours = "RealHours"
    }
}
