//
//Project name: together
//
//Copyright © Gromov V.O., 2024
//

import SwiftUI

struct ListCell: View {
    var data: Int
    var body: some View {
        Text(verbatim: String(data))
            .onTapGesture {
                print("works", data)
            }
    }
}
