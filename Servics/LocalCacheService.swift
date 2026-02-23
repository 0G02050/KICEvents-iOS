import Foundation

// 本地缓存服务 (Local Cache Service)
class LocalCacheService {
    
    // 定义缓存文件名
    private let cacheFileName = "events_cache.json"
    
    // 计算属性：动态获取当前设备沙盒的物理路径
    private var cacheFileURL: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent(cacheFileName)
    }
    
    // 写入数据 (Write Data)
    // 接收原生二进制数据并覆写到硬盘
    func save(data: Data) {
        do {
            try data.write(to: cacheFileURL)
            print("💾 [Storage] 二进制数据已成功写入本地硬盘。")
        } catch {
            print("💾 [Storage] 致命错误：写入本地硬盘失败 - \(error.localizedDescription)")
        }
    }
    
    // 读取数据 (Read Data)
    // 返回可选类型 Data?，因为用户第一次打开 App 时，硬盘里绝对没有这个文件
    func load() -> Data? {
        do {
            let data = try Data(contentsOf: cacheFileURL)
            print("💾 [Storage] 成功从本地硬盘捞出缓存数据。")
            return data
        } catch {
            print("💾 [Storage] 硬盘暂无缓存，或缓存已被清理。")
            return nil // 读取失败，安全返回空值 (nil)
        }
    }
}
