# Build stage
FROM mcr.microsoft.com/dotnet/sdk:7.0-alpine AS build
WORKDIR /src
ENV TZ=America/Argentina/Buenos_Aires
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY *.csproj ./
RUN dotnet restore

COPY . ./
RUN dotnet publish -c Release -o output

# Serve stage
FROM mcr.microsoft.com/dotnet/aspnet:7.0-alpine AS serve
WORKDIR /app

COPY --from=build /src/output .

EXPOSE 5273

ENTRYPOINT [ "dotnet", "TodoApi.dll" ]