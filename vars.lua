CombatExtensions = {
    name = "CombatExtensions",
    version = "0.0.1",
    varsVersion = "0.0.1",
    CanDebug = false,
    Translate = function(var) return CombatExtensions.Localization[var] or var end,
    SettingsMenu = {},
    DefaultVars = {
        debug = {
            isEnabled = false
        },
        modules = {
            groupControl = {
                watchedEffectTypes = {}
            },
            stats = {
                anchor = nil
            }
        }
    },
    SavedVars = {
        debug = {
            isEnabled = false
        },
        modules = {
            groupControl = {
                watchedEffectTypes = {}
            },
            stats = {
                anchor = nil
            }
        }
    },
    LogLater = function(obj) zo_callLater(function() d(obj) end, 200) end
}
