import SwiftUI

struct ContentView: View {
    // 注入视图模型 (Dependency Injection)
    @StateObject private var viewModel = EventViewModel()
    
    var body: some View {
        NavigationView {
            // 循环遍历数据源，剥离默认列表样式
            List(viewModel.events) { event in
                EventCardView(event: event)
                    .listRowSeparator(.hidden) // 隐藏系统默认的下划线
                    .listRowBackground(Color.clear) // 隐藏系统默认的灰色背景
            }
            .listStyle(.plain)
            .navigationTitle("KIC企業説明会")
            // 视图出现时，触发异步网络请求
            .task {
                await viewModel.fetchEvents()
            }
        }
    }
}

#Preview {
    ContentView()
}
