# dev-quality-gate-template

This project enforces quality gates on Git operations using Git hooks.

## Features
- Pylint score must be >= 8.0
- Code coverage must be >= 80%
- Uses pre-commit framework

## Setup
```bash
pip install -r requirements-dev.txt
pre-commit install --hook-type pre-push
```

## Usage
Make code changes and try to push. The push will be blocked if quality gates fail.

---

Add your own code in `sample_module/` and tests in `tests/`.

