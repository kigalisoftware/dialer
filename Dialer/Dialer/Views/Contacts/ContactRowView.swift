//
//  ContactRowView.swift
//  Dialer
//
//  Created by Cédric Bahirwe on 04/06/2023.
//

import SwiftUI

struct ContactRowView: View {
    let contact: Contact
    var body: some View {
        HStack {
            Text(contact.names)
                .font(.system(.callout, design: .rounded).weight(.medium))
            
            Spacer()
            
            VStack(alignment: .trailing) {
                if contact.phoneNumbers.count == 1 {
                    Text(contact.phoneNumbers[0])
                } else {
                    Text("\(Text(contact.phoneNumbers[0])), +\(contact.phoneNumbers.count-1)more")
                }
            }
            .font(.system(.footnote, design: .rounded))
            .foregroundColor(.secondary)
            .lineLimit(1)
            .minimumScaleFactor(0.5)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
        
    }
}

#if DEBUG
struct ContactRowView_Previews: PreviewProvider {
    static var previews: some View {
        ContactRowView(contact: MockPreview.contact1)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
#endif
