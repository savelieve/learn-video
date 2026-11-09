# Learn Video

An agent skill for learning from video URLs and local files: timestamped visual evidence, captions, optional speech transcription, and answers grounded in what the video shows and says.

Maintained by [Evgeny (savelieve)](https://github.com/savelieve). Adapted from [Bradley Bonanno's claude-video](https://github.com/bradautomates/claude-video), under the [MIT license](LICENSE). Upstream history and attribution are retained. This is an independent adaptation, not an upstream release.

## Install

In Codex, ask:

```text
Use $skill-installer to install learn-video from:
https://github.com/savelieve/learn-video/tree/main/skills/learn-video
```

It becomes available on your next turn. The self-contained skill lives in `skills/learn-video/`.

For other Agent Skills hosts:

```sh
npx skills add savelieve/learn-video -g --skill learn-video
```

For Claude Code:

```text
/plugin marketplace add savelieve/learn-video
/plugin install learn-video@learn-video
```

## Use

```text
Use learn-video on ./tutorial.mp4. Use the local engine and captions only.
Explain the workflow, show key moments with timestamps, and list the practical takeaways.
```

Other examples: summarize a talk, inspect an interface recording, break down an edit, or answer a question about a specific moment. Local analysis extracts frames with FFmpeg and retrieves captions with yt-dlp. Videos without captions can use optional local WhisperX or Groq/OpenAI speech transcription. The optional Gemini engine sends video evidence to Google for analysis.

Python 3.10+ is required. The local engine also needs FFmpeg/ffprobe and current yt-dlp. YouTube may require a supported JavaScript runtime. The bundled `scripts/setup.py --json` checks dependencies; installation of this skill alone does not install media tools or models.

## Settings and privacy

Settings live in `~/.config/learn-video/.env`, separate from upstream Watch. Environment settings use the `LEARN_VIDEO_` prefix, for example `LEARN_VIDEO_ENGINE=local` and `LEARN_VIDEO_WHISPER_BACKEND=none`. Provider credential names remain `GEMINI_API_KEY`, `GROQ_API_KEY`, and `OPENAI_API_KEY`. Enter keys privately; do not commit them.

The upstream internal module name `watch.py` and CLI flags are retained. To inspect a local file directly:

```sh
python skills/learn-video/scripts/watch.py ./example.mp4 --engine local --no-whisper
```

Local frame/caption analysis needs no cloud API key. Gemini uploads video evidence to Google; Groq/OpenAI transcription uploads audio to that provider. Provider charges may apply. Choose these modes explicitly. The retained `auto` engine selects Gemini if a Gemini key is available; use `--engine local` to force local analysis. Model downloads and authenticated source access are separate setup choices.

## Development

```sh
python -m pip install pytest
python -m pytest -q
```

Tests synthesize short clips with FFmpeg and mock cloud calls. GitHub Actions checks Linux, macOS, and Windows. Release packaging uses `bash skills/learn-video/scripts/build-skill.sh` and produces `dist/learn-video.skill`; this archive is a distribution artifact, not a guarantee of support in browser chat surfaces.

## Provenance

Based on upstream commit `03ceb42f7fa2c4439aca01752118044baabffb8f` (version 0.3.2). Learn Video starts at version 0.1.0. This adaptation renames the skill, plugin manifests, marketplace entries, package paths, settings namespace, and installation links, while preserving the video-processing engine and its tests. Original release history is in [CHANGELOG.md](CHANGELOG.md).
