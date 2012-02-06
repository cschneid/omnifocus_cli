framework 'Foundation'
framework 'ScriptingBridge'

bundle_id = 'com.omnigroup.OmniFocus'
bridge_file = 'Omnifocus.bridgesupport'

omnifocus = SBApplication.applicationWithBundleIdentifier(bundle_id)
load_bridge_support_file bridge_file



