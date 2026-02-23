import Foundation

// 数据模型 (Data Model)
// 实现 Identifiable 协议以便在 SwiftUI 列表中循环渲染
// 实现 Codable 协议以便进行 JSON 解析
struct KICEvent: Identifiable, Codable {
    let id: Int
    let title: String
    let companyName: String?
    let eventFormat: String?
    let specialTag: String?
    
    // 将数据库的下划线命名,转换为 Swift 规范的驼峰命名
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case companyName = "company_name"
        case eventFormat = "event_format"
        case specialTag = "special_tag"
    }
}
