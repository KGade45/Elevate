import SwiftUI

struct SharePostBottomsheet: View {
    @State private var isChecked: Bool = false
    @Binding var shouldShowBottomsheet: Bool
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                HStack(spacing: 12) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 44, height: 44)
                        .clipShape(Circle())
                        .foregroundStyle(.blue)

                    Text("UserModel name")
                        .font(.headline)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .layoutPriority(1)

                    Spacer()

                    Button(action: {
                        isChecked.toggle()
                    }) {
                        Image(systemName: isChecked ? "checkmark.circle.fill" : "circle")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(isChecked ? .blue : .gray)
                    }
                }
                .padding()

                Divider()
                Spacer()
            }

            HStack {
                Spacer()

                Button(action: {
                    shouldShowBottomsheet = false
                }) {
                    HStack(spacing: 8) {
                        Text("Send")
                            .font(.body)
                            .fontWeight(.semibold)
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 90)
                    .background(isChecked ? Color.blue : Color.gray.opacity(0.3))
                    .foregroundStyle(.white)
                    .cornerRadius(12)
                }
                .disabled(!isChecked)

                Spacer()
            }
            .padding(.vertical, 16)
            .padding(.bottom, 8)
            .background(Color(.systemGroupedBackground))
        }
        .background(Color.white)
        .cornerRadius(20)
        .ignoresSafeArea(edges: .bottom)
    }
}

//struct SharePostBottomsheet_Previews: PreviewProvider {
//    static var previews: some View {
//        SharePostBottomsheet(shouldShowBottomsheet: false)
//    }
//}
