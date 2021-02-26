# Korero Maori - Old API

**URL:** https://asr.koreromaori.io/

This is the second iteration of the Korero Maori transcription API.

This API utilises OpenAPI. A browsable implementation of this can be found by browsing to the [docs](https://asr.koreromaori.io/docs). You will have to sign in.

An API token and browser account can be activated by contacting the Korero Maori administrators.

:information: **These auto-generated docs give a very complete overview of how to use the API.** As such, this document will discuss only the quirks or non-disclosed elements of the API that I am aware of.

### Authorisation

Each request must contain an authorization header which carries a basic token. The header is defined as follows:

```
Authorization: Basic <token>
```

# Various Information

- You are provided with two tokens. One is used as a password when signing into the OpenAPI web interface, and the other for use with API requests.
- When calling an endpoint you **should not** add a `/` suffix. Doing so will generate a `307 Temporary Redirect` response that does not play nicely with some HTTP libraries. E.g.
    ```
    https://asr.koreromaori.io/transcribe  # Correct
    https://asr.koreromaori.io/transcribe/ # Incorrect
    ```

### Usage Example

This will transcribe an audio file and return a `Transcription` object - e.g.

```json
{
  "success": true,
  "transcription": "nō tēnei kōrero kūware ka ruia e te tohora tana pīkauranga ki roto i te moana",
  "model_version": "20201126_SC_0.9.1_thm",
  "log": "Took 2.3s to transcribe 7.9s audio file /tmp/tmpmqkb2j5w.wav"
}
```

**curl**
```
curl --location --request POST 'https://asr.koreromaori.io/transcribe_file' \
--header 'Authorization: Basic YOUR-UNIQUE-TOKEN' \
--form 'audio_file=@"/path/to/an/audio/recording"'
```