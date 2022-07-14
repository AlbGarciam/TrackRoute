import Components
import Combine
import Domain
import MapKit
import SwiftUI

struct ContactView: View {
    @ObservedObject private var viewModel: ContactViewModel
    
    init(_ viewModel: ContactViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 24) {
                HStack(alignment: .center) {
                    Text("contact_screen_title")
                        .font(.boldItalic(32))
                        .foregroundColor(.primaryText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    Image(systemName: "xmark")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.primaryText)
                        .padding(.vertical, 12)
                        .padding(.leading, 24) // Keep it aligned to the right
                        .frame(width: 44, height: 44, alignment: .center)
                        .onTapGesture { self.viewModel.didTapClose() }
                }

                TextField("contact_name_placeholder", text: $viewModel.name)
                    .frame(minHeight: 44, alignment: .leading)
                    .textContentType(.name)
                    .keyboardType(.default)
                    .font(.regular(16))
                    .padding(.horizontal, 10)
                    .border(Color.cardBorder, width: 1)
                TextField("contact_surname_placeholder", text: $viewModel.surname)
                    .frame(minHeight: 44, alignment: .leading)
                    .textContentType(.familyName)
                    .keyboardType(.default)
                    .font(.regular(16))
                    .padding(.horizontal, 10)
                    .border(Color.cardBorder, width: 1)
                TextField("contact_email_placeholder", text: $viewModel.email)
                    .frame(minHeight: 44, alignment: .leading)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .font(.regular(16))
                    .padding(.horizontal, 10)
                    .border(Color.cardBorder, width: 1)
                TextField("contact_phone_placeholder", text: $viewModel.phone)
                    .frame(minHeight: 44, alignment: .leading)
                    .textContentType(.telephoneNumber)
                    .keyboardType(.phonePad)
                    .font(.regular(16))
                    .padding(.horizontal, 10)
                    .border(Color.cardBorder, width: 1)
                DatePicker("contact_date_placeholder", selection: $viewModel.dateTime)
                    .frame(minHeight: 44, alignment: .leading)
                    .font(.regular(16))
                    .padding(.horizontal, 10)
                    .border(Color.cardBorder, width: 1)
                Text("contact_description_title")
                    .font(.semibold(20))
                    .frame(maxWidth: .infinity, alignment: .leading)
                TextEditor(text: $viewModel.description)
                    .padding(10)
                    .frame(minHeight: 130, alignment: .leading)
                    .cornerRadius(6.0)
                    .border(Color.cardBorder, width: 1)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 16)
                Button(action: { viewModel.send() }) {
                    Text("contact_send_button")
                        .underline()
                        .font(.semibold(16))
                        .foregroundColor(.secondaryText)
                }
                Spacer()
            }
            .padding(.horizontal, 24)
        }
        .foregroundColor(.primaryText)
        .edgesIgnoringSafeArea(.bottom)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, 24)
    }
}

#if DEBUG
struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        return ContactView(ContactViewModel())
    }
}
#endif
