// MARK: - AlertManager

/// An object that can be used to display alerts and tip views.
public class AlertManager {

    // MARK: Properties

    /// The shared `AlertManager` instance.
    public static let shared = AlertManager()

    private static var timerKey = "com.jarrodparkes.habanero.alert.timer"
    private static var handlerKey = "com.jarrodparkes.habanero.alert.handler"

    private var theme: Theme?

    private var fadeDuration: TimeInterval {
        guard let theme = theme else { return 0 }
        return TimeInterval(theme.constants.alertViewFadeDuration)
    }

    // MARK: Create Alert

    /// Shows an alert on a view.
    /// - Parameters:
    ///   - displayable: An object that can be displayed as an alert.
    ///   - view: The view upon which the alert will be displayed.
    ///   - theme: The theme used for styling of the alert.
    public func show(_ displayable: AlertViewDisplayable,
                     onView view: UIView,
                     withTheme theme: Theme,
                     alertHandler: (() -> Void)? = nil,
                     completionHandler : (() -> Void)? = nil) {
        self.theme = theme

        showAlertView(onView: view,
                      alertView: createAlertOnView(view, displayable: displayable),
                      duration: displayable.duration,
                      anchor: displayable.anchor,
                      alertHandler: alertHandler,
                      completionHandler: completionHandler)
    }

    private func createAlertOnView(_ view: UIView, displayable: AlertViewDisplayable) -> AlertView {
        guard let theme = theme else { return AlertView() }

        let alertView = AlertView(frame: .zero)
        let width = view.bounds.size.width * theme.constants.alertViewContainingViewWidthFactor

        alertView.styleWith(theme: theme, displayable: displayable)
        alertView.delegate = self

        // calculate height after styling the alert view
        let height = alertView.calculatedHeight(theme: theme, alertViewWidth: width)

        alertView.frame = CGRect(x: 0.0, y: 0.0, width: width, height: height)

        return alertView
    }

    // MARK: Create Tip

    /// Shows a tip on a view.
    /// - Parameters:
    ///   - displayable: An object that can be displayed as a tip.
    ///   - view: The view upon which the tip will be displayed.
    ///   - theme: The theme used for styling of the tip.
    public func show(_ displayable: TipViewDisplayable,
                     onView view: UIView,
                     presentedFrom: UIView?,
                     withTheme theme: Theme,
                     alertHandler: (() -> Void)? = nil,
                     completionHandler : (() -> Void)? = nil) {
        self.theme = theme

        showTipView(onView: view,
                      tipView: createTipOnView(view, displayable: displayable),
                      anchor: displayable.anchor,
                      duration: displayable.duration,
                      presentedFrom: presentedFrom,
                      alertHandler: alertHandler,
                      completionHandler: completionHandler)
    }

    private func createTipOnView(_ view: UIView, displayable: TipViewDisplayable) -> TipView {
        guard let theme = theme else { return TipView() }

        let tipView = TipView(frame: .zero)

        tipView.styleWith(theme: theme, displayable: displayable)
        tipView.delegate = self

        let maxWidth = view.bounds.size.width * theme.constants.tipViewContainingViewWidthFactor
        let textWidth = tipView.singleLineWidth(theme: theme)
        let width = min(maxWidth, textWidth)

        // calculate height after styling the alert view
        let height = tipView.calculatedHeight(theme: theme, tipViewWidth: width)

        tipView.frame = CGRect(x: 0.0, y: 0.0, width: width, height: height)

        return tipView
    }

    // MARK: Show Alert

    private func showAlertView(onView view: UIView,
                               alertView: AlertView,
                               duration: TimeInterval,
                               anchor: AnchorPoint,
                               alertHandler: (() -> Void)? = nil,
                               completionHandler : (() -> Void)? = nil) {
        guard let theme = theme else { return }

        alertView.center = alertView.anchor(onView: view, withTheme: theme, atAnchorPoint: anchor)
        alertView.alpha = 0.0

        view.addSubview(alertView)

        UIView.animate(withDuration: fadeDuration,
                       delay: 0.0,
                       options: [.curveEaseOut, .allowUserInteraction],
                       animations: { alertView.alpha = 1.0 },
                       completion: { _ in
                        completionHandler?()

                        let timer = Timer(timeInterval: duration,
                                          target: self,
                                          selector: #selector(self.alertTimerDidFinish(_:)),
                                          userInfo: alertView,
                                          repeats: false)

                        RunLoop.main.add(timer, forMode: .common)

                        objc_setAssociatedObject(alertView,
                                                 &AlertManager.handlerKey,
                                                 alertHandler,
                                                 .OBJC_ASSOCIATION_RETAIN_NONATOMIC)

        })
    }

    // MARK: Show Tip

    private func showTipView(onView view: UIView,
                             tipView: TipView,
                             anchor: AnchorPoint?,
                             duration: Double? = nil,
                             presentedFrom: UIView? = nil,
                             alertHandler: (() -> Void)? = nil,
                             completionHandler : (() -> Void)? = nil) {
        guard let theme = theme else { return }

        if let presentedFrom = presentedFrom {
            tipView.center = tipView.anchor(onSubview: presentedFrom,
                                            inSuperview: view,
                                            withAnchor: anchor,
                                            withTheme: theme)
        } else {
            tipView.center = tipView.anchor(onView: view, withTheme: theme, atAnchorPoint: anchor ?? .center)
        }

        tipView.alpha = 0.0

        view.addSubview(tipView)

        UIView.animate(withDuration: fadeDuration,
                       delay: 0.0,
                       options: [.curveEaseOut, .allowUserInteraction],
                       animations: { tipView.alpha = 1.0 },
                       completion: { _ in
                        completionHandler?()

                        let timer = Timer(timeInterval: duration ?? 4,
                                          target: self,
                                          selector: #selector(self.alertTimerDidFinish(_:)),
                                          userInfo: tipView,
                                          repeats: false)

                        RunLoop.main.add(timer, forMode: .common)

                        objc_setAssociatedObject(tipView,
                                                 &AlertManager.handlerKey,
                                                 alertHandler,
                                                 .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                       })
    }

    // MARK: Hide Alert/Tip

    private func hideView(_ view: UIView) {
        if let timer = objc_getAssociatedObject(view, &AlertManager.timerKey) as? Timer {
            timer.invalidate()
        }

        UIView.animate(withDuration: fadeDuration,
                       delay: 0.0,
                       options: [.curveEaseIn, .beginFromCurrentState],
                       animations: { view.alpha = 0.0 },
                       completion: { _ in
                        view.removeFromSuperview()

                        if let alertHandler = objc_getAssociatedObject(view,
                                                                       &AlertManager.handlerKey)as? (() -> Void) {
                            alertHandler()
                        }
                       })
    }

    // MARK: Actions

    @objc private func alertTimerDidFinish(_ timer: Timer) {
        guard let view = timer.userInfo as? UIView else { return }
        hideView(view)
    }
}

// MARK: - AlertManager: AlertViewDelegate

extension AlertManager: AlertViewDelegate {
    func alertViewShouldDismiss(_ alertView: AlertView) {
        hideView(alertView)
    }
}

// MARK: - AlertManager: TipViewDelegate

extension AlertManager: TipViewDelegate {
    func tipViewShouldDismiss(_ tipView: TipView) {
        hideView(tipView)
    }
}
