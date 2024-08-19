//
//  CustomAlert.swift
//  QiitaViewer
//
//  Created by Hina on 2024/08/19.
//

import SwiftUI

import SwiftUI

struct CustomAlert: ViewModifier {
    @Binding var isPresentingAlert: Bool
    let type: AlertType
    
    enum AlertType {
        case close(title: String, message: String)
        case retry(title: String, message: String, action: (() async -> Void)?)
    }
    func body(content: Content) -> some View {
        content
            .alert(isPresented: $isPresentingAlert) {
                switch type {
                case let .close(title: title, message: message):
                    return Alert(title: Text(title),
                                 message: Text(message),
                                 dismissButton: .default(Text("閉じる")))
                case let .retry(title: title, message: message, action):
                    return Alert(title: Text(title),
                                 message: Text(message),
                                 primaryButton: .default(Text("閉じる")),
                                 secondaryButton: .default(Text("リトライ")) {
                        Task {
                            await action?()
                        }
                    })
                }
            }
    }
}

extension View {
    func customAlert(isPresentingAlert: Binding<Bool>, type: CustomAlert.AlertType) -> some View {
        modifier(CustomAlert(isPresentingAlert: isPresentingAlert, type: type))
    }
}
