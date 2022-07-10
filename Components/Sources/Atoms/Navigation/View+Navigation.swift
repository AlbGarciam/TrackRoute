import SwiftUI

public extension View {
    func navigate<Coordinator: BaseCoordinatorContract, Destination: View>(
        _ identifier: FlowStepIdentifier,
        _ coordinator: Coordinator,
        @ViewBuilder destination: (AnyView) -> Destination
    ) -> some View {
        return self.navigation(isActive: coordinator.currentStep.getViewModel(identifier) != nil) {
            destination(coordinator.viewFor(identifier))
                .onDisappear { coordinator.stepRemoved(identifier) }
        }
    }

    func present<Coordinator: BaseCoordinatorContract, Destination: View>(
        _ identifier: FlowStepIdentifier,
        _ coordinator: Coordinator,
        @ViewBuilder destination: @escaping (AnyView) -> Destination
    ) -> some View {
        present(coordinator.currentStep.getViewModel(identifier) != nil) {
            coordinator.stepRemoved(identifier)
        } destination: { destination(coordinator.viewFor(identifier)) }
    }
}

extension View {
    func navigation<Destination: View>(isActive: Bool, @ViewBuilder destination: () -> Destination) -> some View {
        overlay(
            NavigationLink(destination: isActive ? destination() : nil,
                           isActive: Binding(get: { isActive }, set: { _ in }),
                           label: { EmptyView() })
        )
    }

    func present<Destination: View>(_ isPresented: Bool,
                                    onDismiss: @escaping () -> Void,
                                    @ViewBuilder destination: @escaping () -> Destination) -> some View {
        #if os(macOS)
        sheet(isPresented: Binding(get: { isPresented }, set: { _ in }), onDismiss: onDismiss, content: destination)
        #else
        fullScreenCover(isPresented: Binding(get: { isPresented }, set: { _ in }), onDismiss: onDismiss, content: destination)
        #endif
    }
}

extension NavigationLink {
    init<T: Identifiable, D: View>(item: Binding<T?>,
                                   @ViewBuilder destination: (T) -> D,
                                   @ViewBuilder label: () -> Label) where Destination == D? {
        let isActive = Binding(
            get: { item.wrappedValue != nil },
            set: { value in
                if !value {
                    item.wrappedValue = nil
                }
            }
        )
        self.init(
            destination: item.wrappedValue.map(destination),
            isActive: isActive,
            label: label
        )
    }
}
