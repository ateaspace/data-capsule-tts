# Korero Maori API Interface

This project is a rough and ready interface to the [Korero Maori](koreromaori.io) ASR interface - https://asr.koreromaori.io. It is built using the ASP.NET Core 5 server-side Blazor model.

Some API documentation can be found under `/docs`.

### Requirements

This project needs .NET 5 to build/run. You can download this from the [.NET 5 Downloads page](https://dotnet.microsoft.com/download/dotnet/5.0).

To build the project, you'll need the `SDK`. To run the project, you'll need both the `.NET Runtime` and `ASP.NET Core Runtime` components (or get your hands on a self-contained release).

### Building and Running

Open a terminal in the directory of the project you wish to build, then run

```
dotnet build
```

To run the project, use the `run` command. **Please see [Configuration](#Configuration) for more info.**

```
dotnet run
```

### Configuration

You'll need to supply your token for the ASR API. This can be achieved by placing it in the `GeneralOptions` section of the `appsettings.json` file. **Do not commit this token to version control!** If developing using Visual Studio, please utilise the `User Secrets` feature and mimic the `GeneralOptions` section in there.

```json
{
  ...
  "GeneralOptions": {
      "KoreroMaoriApiKey": "YOUR_UNIQUE_TOKEN"
  },
  ...
}
```

Additionally, if you are hosting this project, you'll probably want to run it on an endpoint other than `localhost`. This can be done by setting the `ASPNETCORE_URLS` environment variable.

```
export ASPNETCORE_URLS=http://<IP_Address>:<PORT>
```

Note that the project is not configured for HTTPs, although it is a simple addition if you have a certificate.