::*******************************************************************************************************
::  UpdateDependencies.bat - Gbtc
::
::  Tennessee Valley Authority, 2009
::  No copyright is claimed pursuant to 17 USC � 105.  All Other Rights Reserved.
::
::  This software is made freely available under the TVA Open Source Agreement (see below).
::
::  Code Modification History:
::  -----------------------------------------------------------------------------------------------------
::  02/26/2011 - Pinal C. Patel
::       Generated original version of source code.
::
::*******************************************************************************************************

@ECHO OFF

SET vs="%VS100COMNTOOLS%\..\IDE\devenv.com"
SET tfs="%VS100COMNTOOLS%\..\IDE\tf.exe"
SET source1="\\GPAWEB\NightlyBuilds\TVACodeLibrary\Beta\Libraries\*.*"
SET target1="..\..\Source\Dependencies\TVA"
SET source2="\\GPAWEB\NightlyBuilds\TimeSeriesFramework\Beta\Libraries\*.*"
SET target2="..\..\Source\Dependencies\TimeSeriesFramework"
SET source3="\\GPAWEB\NightlyBuilds\openHistorian\Beta\Libraries\*.*"
SET target3="..\..\Source\Dependencies\TVA"
SET source4="\\GPAWEB\NightlyBuilds\openPDC\Beta\Libraries\*.*"
SET target4="..\..\Source\Dependencies\TVA"
SET source5="\\GPAWEB\NightlyBuilds\openPDC\Beta\Libraries\*.*"
SET target5="..\..\Source\Dependencies\openPDC"
SET source6="\\GPAWEB\NightlyBuilds\TimeSeriesFramework\Beta\Applications\TsfManager\TsfManager.*"
SET solution="..\..\Source\openPG.sln"
SET sourcetools=..\..\Source\Applications\openPG\openPGSetup\
SET frameworktools=\\GPAWEB\NightlyBuilds\TVACodeLibrary\Beta\Tools\
SET historiantools=\\GPAWEB\NightlyBuilds\openHistorian\Beta\Tools\
SET /p checkin=Check-in updates (Y or N)? 

ECHO.
ECHO Getting latest version...
%tfs% get %target1% /version:T /force /recursive /noprompt
%tfs% get %target2% /version:T /force /recursive /noprompt
%tfs% get %target5% /version:T /force /recursive /noprompt
%tfs% get "%sourcetools%ConfigCrypter.exe" /version:T /force /recursive /noprompt
%tfs% get "%sourcetools%ConfigurationEditor.exe" /version:T /force /recursive /noprompt
%tfs% get "%sourcetools%DataMigrationUtility.exe" /version:T /force /recursive /noprompt
%tfs% get "%sourcetools%HistorianPlaybackUtility.exe" /version:T /force /recursive /noprompt

ECHO.
ECHO Checking out dependencies...
%tfs% checkout %target1% /recursive /noprompt
%tfs% checkout %target2% /recursive /noprompt
%tfs% checkout %target5% /recursive /noprompt
%tfs% checkout "%sourcetools%ConfigCrypter.exe" /noprompt
%tfs% checkout "%sourcetools%ConfigurationEditor.exe" /noprompt
%tfs% checkout "%sourcetools%DataMigrationUtility.exe" /noprompt
%tfs% checkout "%sourcetools%HistorianPlaybackUtility.exe" /noprompt

ECHO.
ECHO Updating dependencies...
XCOPY %source5% %target5% /Y /U
XCOPY %source4% %target4% /Y /U
XCOPY %source3% %target3% /Y /U
XCOPY %source2% %target2% /Y /U
XCOPY %source6% %target2% /Y /U
DEL target2\TVA.* /F /Q
XCOPY %source1% %target1% /Y /U
XCOPY "%frameworktools%ConfigCrypter\ConfigCrypter.exe" "%sourcetools%ConfigCrypter.exe" /Y
XCOPY "%frameworktools%ConfigEditor\ConfigEditor.exe" "%sourcetools%ConfigurationEditor.exe" /Y
XCOPY "%frameworktools%DataMigrationUtility\DataMigrationUtility.exe" "%sourcetools%DataMigrationUtility.exe" /Y
XCOPY "%historiantools%HistorianPlaybackUtility\HistorianPlaybackUtility.exe" "%sourcetools%HistorianPlaybackUtility.exe" /Y

:: ECHO.
:: ECHO Building solution...
:: %vs% %solution% /Build "Release|Any CPU"

IF /I "%checkin%" == "Y" GOTO Checkin
GOTO Finalize

:Checkin
ECHO.
ECHO Checking in dependencies...
%tfs% checkin %target1% /noprompt /recursive /comment:"Updated code library dependencies."
%tfs% checkin %target2% /noprompt /recursive /comment:"Updated time-series framework dependencies."
%tfs% checkin %target5% /noprompt /recursive /comment:"Updated openPDC dependencies."
%tfs% checkin "%sourcetools%ConfigCrypter.exe" /noprompt /comment:"Updated code library tool: ConfigCrypter."
%tfs% checkin "%sourcetools%ConfigurationEditor.exe" /noprompt /comment:"Updated code library tools: ConfigurationEditor."
%tfs% checkin "%sourcetools%DataMigrationUtility.exe" /noprompt /comment:"Updated code library tools: DataMigrationUtility."
%tfs% checkin "%sourcetools%HistorianPlaybackUtility.exe" /noprompt /comment:"Updated openHistorian tool: HistorianPlaybackUtility."

:Finalize
ECHO.
ECHO Update complete