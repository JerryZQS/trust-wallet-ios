// Copyright DApps Platform Inc. All rights reserved.

import Foundation

struct SettingsViewModel {

    private let isDebug: Bool

    init(
        isDebug: Bool = false
    ) {
        self.isDebug = isDebug
    }

    var servers: [RPCServer] {
        return [
            RPCServer.main,
            RPCServer.classic,
            RPCServer.poa,
            RPCServer.callisto,
            RPCServer.gochain,
        ]
    }

    var autoLockOptions: [AutoLock] {
        return [
            AutoLock.immediate,
            AutoLock.oneMinute,
            AutoLock.fiveMinutes,
            AutoLock.oneHour,
            AutoLock.fiveHours,
        ]
    }

    var currency: [Currency] {
        return Currency.allValues.map { $0 }
    }

    var passcodeTitle: String {
        switch BiometryAuthenticationType.current {
        case .faceID, .touchID:
            return String(
                format: NSLocalizedString("settings.biometricsEnabled.label.title", value: "Passcode / %@", comment: ""),
                BiometryAuthenticationType.current.title
            )
        case .none:
            return NSLocalizedString("settings.biometricsDisabled.label.title", value: "Passcode", comment: "")
        }
    }

    var isPasscodeTransactionLockEnabled: Bool {
        get {
            let option = PreferenceOption.isPasscodeTransactionLockEnabled
            guard let boolValue = PreferencesController()
                .get(for: option.key) as? Bool else {
                PreferencesController().set(value: false, for: option)
                return false
            }
            return boolValue
        }
        set {
            PreferencesController().set(value: newValue, for: PreferenceOption.isPasscodeTransactionLockEnabled)
        }
    }

    var verifyTransactionsWithPasscodeTitle: String {
        return NSLocalizedString("settings.lockTransactions.label.title", value: "Authenticate Transactions", comment: "")
    }

    var networkTitle: String {
        return NSLocalizedString("settings.network.button.title", value: "Network", comment: "")
    }

    var autoLockTitle: String {
        return NSLocalizedString("settings.autoLock.button.title", value: "Auto-Lock", comment: "")
    }

    var currencyTitle: String {
        return NSLocalizedString("settings.currency.button.title", value: "Currency", comment: "")
    }

    var testNetworkWarningTitle: String {
        return NSLocalizedString("settings.network.test.warnning.title", value: "Warning", comment: "")
    }

    var testNetworkWarningMessage: String {
        return NSLocalizedString("settings.network.test.warnning.message", value: "You are switching to a test network where transactions are for testing purpose only", comment: "")
    }

    var testNetworkWarningDontShowAgainLabel: String {
        return NSLocalizedString("settings.network.test.warnning.dont.show.again", value: "Don't show again", comment: "")
    }
}
