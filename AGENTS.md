# Learn Video

Independent MIT-licensed adaptation of bradautomates/claude-video, maintained as savelieve/learn-video. Retain the original copyright, license, and attribution when distributing it.

- `skills/learn-video/SKILL.md` is the canonical agent contract. The folder is self-contained and includes its runtime scripts and license.
- `scripts/watch.py` retains the upstream internal module name and orchestrates download, frames, captions, and optional transcription or Gemini analysis.
- Settings use `LEARN_VIDEO_*` and `~/.config/learn-video/.env`. The managed WhisperX environment lives at `~/.cache/learn-video/whisperx-venv`.
- Resolve runtime paths relative to the loaded SKILL.md, across supported hosts. Keep scripts beside SKILL.md; do not introduce a host-specific path variable or a duplicate command wrapper.
- `.claude-plugin/`, `.codex-plugin/`, and `.agents/plugins/` contain plugin and marketplace metadata. The public skill and plugin name is `learn-video`.
- Keep the skill and plugin manifest versions synchronized when releasing.
- Run `python -m pytest -q` (pytest and FFmpeg required). Tests isolate user settings and mock cloud requests; do not use real keys or private videos in fixtures.
- `bash skills/learn-video/scripts/build-skill.sh` builds `dist/learn-video.skill` from a clean committed tree. The release workflow runs only on explicitly pushed version tags.
- Never commit credentials, `.env` files, generated media, or runtime caches. Do not install models, upload private media, or invoke paid providers without task authorization.
