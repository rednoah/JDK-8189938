# Unofficial Java Installer for Oracle Java SE 9.0.1


$ErrorActionPreference = "Stop"


# JDK version identifiers
$JDK_ARCH = "$ENV:PROCESSOR_ARCHITECTURE"

Switch ($JDK_ARCH) {
	AMD64 {
		$JDK_URL = "http://download.oracle.com/otn-pub/java/jdk/9.0.1+11/jre-9.0.1_windows-x64_bin.tar.gz"
		$JDK_SHA256 = "768dbf9f91a316f9b426b5f2dab791a7baa6dca81f470d2ef1a8d1f27528b80e"
	}
	default {
		throw "CPU architecture not supported: $JDK_ARCH"
	}
}


# fetch JDK
$JDK_TAR_GZ = Split-Path -Leaf $JDK_URL

if (!(test-path $JDK_TAR_GZ)) {
	Write-Output "Download $JDK_TAR_GZ"
	$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
	$cookie = New-Object System.Net.Cookie 
	$cookie.Name = "oraclelicense"
	$cookie.Value = "accept-securebackup-cookie"
	$cookie.Domain = "oracle.com"
	$session.Cookies.Add($cookie)
	Invoke-WebRequest -UseBasicParsing -WebSession $session -Uri $JDK_URL -OutFile $JDK_TAR_GZ
}


# verify archive via SHA-256 checksum
$JDK_SHA256_ACTUAL = (Get-FileHash -Algorithm SHA256 $JDK_TAR_GZ).hash.toLower()
Write-Output "Expected SHA256 checksum: $JDK_SHA256"
Write-Output "Actual SHA256 checksum: $JDK_SHA256_ACTUAL"

if ($JDK_SHA256 -ne $JDK_SHA256_ACTUAL) {
	throw "ERROR: SHA256 checksum mismatch"
}


# extract and link only if explicitly requested
Write-Output "Download complete: $JDK_TAR_GZ"
