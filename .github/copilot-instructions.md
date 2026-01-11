# GitHub Copilot instructions for this repo

Purpose: Help AI coding agents be productive quickly in this C++ music-player repository.

- **Big picture**: This is a small C++ project that builds a single executable music app. Key paths:
  - `CMakeLists.txt` (project root) — primary build configuration and targets (produces `music_app`).
  - `src/` — source directory; primary entrypoint is `src/musicPlayer.cpp` (contains `main`).
  - `build/` — CMake build directory (contains `music_app`, `compile_commands.json`, and Ninja/CMake artifacts). Do not edit files here; regenerate via CMake.

- **Build / run / debug (explicit commands)**:
  - Configure + build (preferred):
    - `cmake -S . -B build`
    - `cmake --build build --parallel`
  - Run the produced executable: `./build/music_app` (or the binary in `build/` produced by CMake).
  - Quick single-file compile (VS Code provided task): run the task labeled `C/C++: clang++ build active file` to compile the active `.cpp` file into the same directory.
  - Debug: use the workspace launch configuration `CMake/Launch - music_app` or run `lldb ./build/music_app` / `gdb` as appropriate.

- **Why these choices**:
  - The repo uses CMake (generator: Ninja visible in `build/`) as the authoritative build system. Changes to targets or dependencies belong in `CMakeLists.txt`.
  - `compile_commands.json` is present in `build/` — language servers and static analyzers should point to it for correct compile flags.

- **Project-specific patterns & conventions**:
  - Single executable target named `music_app` driven from `src/musicPlayer.cpp` (the `main` function prints a welcome message).
  - Prefer editing sources in `src/`; do not modify generated files under `build/` — instead re-run CMake.
  - There are currently no test directories or external dependencies declared. If adding libs, update `CMakeLists.txt` and ensure `find_package()` or `target_link_libraries()` are used.

- **Static analysis / formatting**:
  - Use `compile_commands.json` from `build/` for clang-tidy/clangd.
  - No repo-level formatter config discovered; follow existing project style (simple modern C++ with standard library usage).

- **Where to make changes**:
  - Add sources under `src/` and update `CMakeLists.txt` at the repo root to add targets or tests.

- **Common tasks examples**:
  - Add a new source and compile: add `src/foo.cpp`, update `CMakeLists.txt` with a new source or target, then run the Configure+Build sequence above.
  - Rapid iterate on `main`: edit `src/musicPlayer.cpp` and use the `C/C++: clang++ build active file` task to quickly compile and test.

- **Agent behavior guidance**:
  - Do not modify files in `build/` — treat them as generated artifacts.
  - When proposing changes to build configuration, modify `CMakeLists.txt` and provide the exact `cmake` commands to test locally.
  - If the agent needs external dependencies, propose `find_package()` changes and a brief rationale, plus the commands to reconfigure and build.

If anything here is unclear or you want more detail (tests, CI, or packaging), tell me which area to expand.
