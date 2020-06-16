FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /src
COPY NetCoreMicroservices/ .
RUN dotnet restore
COPY NetCoreMicroservices/ .
RUN dotnet publish NetCoreMicroservices.csproj -c release -o /app

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT ["dotnet", "NetCoreMicroservices.dll"]