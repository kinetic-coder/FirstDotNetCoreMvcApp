#!/bin/sh
echo "Executing MSBuild DLL begin command..."
dotnet /tools/sonar/SonarScanner.MSBuild.dll begin /o:"FirstDotNetCoreMvcApp" /k:"FirstDotNetCoreMvcApp" /d:sonar.cs.vstest.reportsPaths="**/TestResults/*.trx" /d:sonar.host.url="https://sonarcloud.io" /d:sonar.verbose=true /d:sonar.login=${SONAR_TOKEN}
echo "Running build..."
dotnet build FirstDotNetCoreMvcApp.csproj
echo "Running tests..."
dotnet test SonarCloud.Travis.Integration.Tests/SonarCloud.Travis.Integration.Tests.csproj --logger:trx
echo "Executing MSBuild DLL end command..."
dotnet ../tools/sonar/SonarScanner.MSBuild.dll end /d:sonar.login=${SONAR_TOKEN}