# Korero Maori - Old API

**URL:** https://koreromaori.io/api/

This is the first iteration of the Korero Maori transcription API. It has since been superseded by https://asr.koreromaori.io, and has bugs.

This API utilises OpenAPI. A slim browsable implementation of this can be found by browsing to the [root endpoint](https://koreromaori.io/api/). You will have to first sign in to the [dashboard](https://koreromaori.io/dashboard/).

An API token and dashboard account can be activated by contacting the Korero Maori administrators.

### Overview

It is important to note that the majority of the API is broken. Hence, the possibly HTTP actions and routes that could be used actually serve no purpose, and are not documented here given that it is already deprecated.

The API can transcribe up to 10s of audio (when using `?method=stream`, see below). This can be lengthened depending on use case by contacting the API administrators.

#### Authorization

Each request must contain an authorization header which carries a basic token. The header is defined as follows:

```
Authorization: Token <token>
e.g.
Authorization: Token ab9496359gg7efc0c0bc04b12u95db43ba2be74
```

#### Endpoints:

:warning: The `/` at the end of every endpoint is **mandatory**.

- `/transcription/`: This endpoint deals with the transcription of audio. An audio file is uploaded along with other parameters such as the desired name or uploader ID. The endpoint is designed to both support retrieval of the transcription at a later date, or to stream it back immediately with the inclusion of the `?method=stream` query parameter.

    :warning: Note that only the stream retrieval method works.

- `/transcription-segment/`: This endpoint does not appear to serve any purpose

### Detailed Endpoint Usage

#### transcription/

This endpoint will only successfully create a transcription when the query parameter `?method=stream` is provided, which has the following effects:
- The audio file is not cached on the Korero Maori CDN for later retrieval
- An `Audio File Transcription` object is returned from the query, containing the transcription and other data
- The `Audio File Transcription` object is not stored on the Korero Maori servers for later retrieval with a `GET` request

Note that this does not actually want the audio upload to be streamed, it simply ensures a direct transcription response.

**Definition: Audio File Transcription (ATF) Request**

This is a multipart form-data request. Include an `audio_file` field of the *file* type containing the audio data, and ATF object in the remainder of the body:

```json
{
  "uploaded_by": 1, # Optional, recommended to let the API populate this for you unless you are acting as a proxy for other API users
  "name": "", # Optional
}
```

:warning: The ATF object appears to be ignored when the stream method is utilised.

**Definition: Audio File Transcription (ATF) Response**

This object is returned when a transcription is successfully completed.

```json
{
    "uploaded_by": 2306494, # ID of the uploader. Automatically populated based on your token if not provided in your request
    "audio_file": "https://cdn.koreromaori.com/Recording.m4a", # A link to the cached audio file. This will be invalid when using the stream method
    "pk": null, # ID of the ATF. Always null when using the stream method
    "name": null, # An optional name. If null in your request, this is populated with your filename in a non-stream request
    "transcription": "tēnā koutou katoa", # The complete transcription
    "segments": [], # Unknown
    "status": { # Invalid and broken
        "status": "waiting to transcribe",
        "percent": 0
    },
    "metadata": [
        {
            "char": "t",
            "start_time": 0.96, # Offset into the recording at which this character was spoken
            "prob": 0.000275
        },
        {
            "char": "ē",
            "start_time": 0.98,
            "prob": 0.06727
        },
        ...
    ],
    "words": [
        {
            "word": "tēnā",
            "prob": 9.896250241503424e-8,
            "start": 0.96 # Offset into the recording at which this word began to be spoken
        },
        {
            "word": "koutou",
            "prob": 2.7680080449954403e-12,
            "start": 1.38
        },
        ...
    ],
    "model_version": "20201126_SC_0.9.1_thm" # The version of the DeepSpeech model used to perform the transcription
}
```

### Usage Example

**curl**
```
curl -X POST -k https://koreromaori.io/api/transcription/ -H "Authorization: Token YOUR-UNIQUE-TOKEN" -F audio_file=@audio.mp3
```