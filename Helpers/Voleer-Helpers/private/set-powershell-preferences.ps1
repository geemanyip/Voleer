# Set the preferences for the different output streams and the corresponding default parameter values
$DebugPreference = "SilentlyContinue"
$VerbosePreference = "SilentlyContinue"
$InformationPreference = "Continue"
$WarningPreference = "Continue"
$ErrorActionPreference = "Stop"
$PSDefaultParameterValues["*:WarningAction"] = "Continue"
$PSDefaultParameterValues["*:ErrorAction"] = "Stop"