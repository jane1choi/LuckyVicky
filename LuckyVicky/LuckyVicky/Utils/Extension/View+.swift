//
//  View+.swift
//  LuckyVicky
//
//  Created by EUNJU on 7/29/24.
//

import SwiftUI

extension View {
    
    var scene: UIWindowScene? {
        UIApplication
            .shared
            .connectedScenes
            .first as? UIWindowScene
    }
    
    var window: UIWindow? {
        scene?
            .windows
            .first(where: { $0.isKeyWindow })
    }
    
    var root: UIViewController? {
        window?.rootViewController
    }
    
    var screenSize: CGRect? {
        root?.view.frame
    }
}

extension View {
    
    func presentAlert(
        isPresented: Binding<Bool>,
        alert: @escaping () -> LuckyVickyAlertView
    ) -> some View {
        return modifier(LuckyVickyAlertModifier(isPresented: isPresented, alert: alert()))
    }
    
    func convertToImage() -> Data? {
        let controller = UIHostingController(rootView: self)
        
        guard let view = controller.view
        else {
            return nil
        }
        
        let contentSize = CGSize(width: screenSize?.width ?? 0, height: (screenSize?.height ?? 0) - 100)
        view.bounds = CGRect(origin: .zero, size: contentSize)
        view.backgroundColor = .clear
        
        let renderer = UIGraphicsImageRenderer(size: contentSize)
        let image = renderer.image { _ in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
        return image.pngData()
    }
    
    func transparentFullScreenCover<Content: View>(
        isPresented: Binding<Bool>,
        content: @escaping () -> Content
    ) -> some View {
        fullScreenCover(isPresented: isPresented) {
            ZStack {
                content()
            }
            .background(TransparentBackground())
        }
    }
    
    @ViewBuilder func hidden(_ isHidden: Bool) -> some View {
        switch isHidden {
        case true: self.hidden()
        case false: self
        }
    }
}

struct TransparentBackground: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}
