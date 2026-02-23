import Foundation
import SwiftUI
import Combine

@MainActor
class EventViewModel: ObservableObject {
    
    @Published var events: [KICEvent] = []
    
    private let supabaseURL = Secrets.supabaseURL
    private let anonKey = Secrets.anonKey
    
    // 实例化缓存服务 (Instantiate the Service)
    private let cacheService = LocalCacheService()
    
    func fetchEvents() async {
        
        // 1. 离线生存防线：优先向服务兵索要硬盘缓存
        if let cachedData = cacheService.load() {
            do {
                // 如果硬盘里有数据，将其反序列化并立刻更新 UI
                let decodedEvents = try JSONDecoder().decode([KICEvent].self, from: cachedData)
                self.events = decodedEvents.sorted(by: { $0.id > $1.id })
            } catch {
                print("缓存数据解析失败，模具可能已更改。")
            }
        }
        
        // 2. 发起云端网络请求 (Network Request)
        guard let url = URL(string: supabaseURL) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(anonKey, forHTTPHeaderField: "apikey")
        request.addValue(anonKey, forHTTPHeaderField: "Authorization")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
            let decodedEvents = try JSONDecoder().decode([KICEvent].self, from: data)
            self.events = decodedEvents.sorted(by: { $0.id > $1.id })
            
            // 3. 缓存更新 (Cache Update)
            // 网络请求成功后，把拿到的一手纯天然二进制数据 (data) 交给服务兵去存盘
            cacheService.save(data: data)
            
        } catch {
            print("网络请求被阻断，维持使用本地现有数据: \(error.localizedDescription)")
        }
    }
}
