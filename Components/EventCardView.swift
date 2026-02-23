import SwiftUI

struct EventCardView: View {
    // 接收从外部传入的单条数据
    let event: KICEvent
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            // 1. 主标题层
            Text(event.title)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .lineLimit(2)
            
            // 2. 公司名称层 (安全解包)
            if let company = event.companyName, !company.isEmpty {
                HStack {
                    Image(systemName: "building.2.fill")
                        .foregroundColor(.gray)
                    Text(company)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            
            // 3. 标签流布局层 (Tag Flow Layer)
            HStack(spacing: 8) {
                if let format = event.eventFormat, !format.isEmpty {
                    Text(format)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.blue.opacity(0.1))
                        .foregroundColor(.blue)
                        .cornerRadius(4)
                }
                
                if let special = event.specialTag, !special.isEmpty {
                    Text(special)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.green.opacity(0.1))
                        .foregroundColor(.green)
                        .cornerRadius(4)
                }
            }
        }
        // 卡片整体物理轮廓修饰符
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}
