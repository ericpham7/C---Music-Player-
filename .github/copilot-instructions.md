# GitHub Copilot instructions for this repo

Purpose: Help AI coding agents be productive quickly in this C++ music-player repository.

- **Big picture**: This is a small C++ project that builds a single executable music app targeting **macOS/Unix** (uses Clang/LLVM). Key paths:
  - [CMakeLists.txt](CMakeLists.txt) (project root) — primary build configuration; sets C++23 standard, enables address/undefined-behavior sanitizers.
  - [src/](src/) — source directory; primary entrypoint is `src/musicPlayer.cpp` (contains `main`, currently prints welcome message).
  - `build/` — CMake build directory (Ninja-based, contains `music_app` binary and `compile_commands.json`). Do not edit; regenerate via CMake.

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
  - Single executable target `music_app` driven from `src/musicPlayer.cpp`.
  - **Compiler flags**: Release builds use `-Wall -Wextra -O2 -g -fsanitize=address -fsanitize=undefined` (aggressive warnings, optimized, debug symbols, memory/UB detection).
  - Prefer editing sources in `src/`; do not modify generated files under `build/` — re-run CMake to regenerate.
  - No test directories or external dependencies yet declared. When adding libraries, update [CMakeLists.txt](CMakeLists.txt) with `find_package()` + `target_link_libraries()`.

- **Static analysis / formatting**:
  - Use `compile_commands.json` from `build/` for clang-tidy/clangd configuration.
  - No formatter config (`.clang-format`) found; follow existing style: `using namespace std;`, standard library, minimal includes.
  - **Platform note**: Code currently targets Unix/macOS (Clang, CMake); remove Windows-specific pragmas (e.g., `#pragma comment(lib, "winmm.lib")`).

- **Where to make changes**:
  - Add sources under `src/` and update [CMakeLists.txt](CMakeLists.txt) at the repo root to add targets or tests.

- **Common tasks**:
  - **Add a new source**: Create `src/module.cpp`, update [CMakeLists.txt](CMakeLists.txt) to add source to `add_executable()` or create new target, then reconfigure + build.
  - **Rapid iteration on main**: Edit `src/musicPlayer.cpp`, press Cmd+Shift+B to run the `C/C++: clang++ build active file` task, test output in VS Code terminal.
  - **Debug the app**: Run task `CMake/Launch - music_app` or use `lldb ./build/music_app` to debug with breakpoints.

- **Agent behavior guidance**:
  - Do not edit `build/` — all generated artifacts. Always regenerate via CMake after structural changes.
  - Update [CMakeLists.txt](CMakeLists.txt) for any build configuration changes; provide exact `cmake` commands for validation.
  - Watch for platform-specific code (Windows pragmas, OS-specific APIs) — this project builds on macOS/Unix with Clang.
  - Sanitizer errors (`-fsanitize=address,undefined`) will appear at runtime; compile with `-O0 -g` if debugging them
  - When proposing changes to build configuration, modify `CMakeLists.txt` and provide the exact `cmake` commands to test locally.
  - If the agent needs external dependencies, propose `find_package()` changes and a brief rationale, plus the commands to reconfigure and build.

If anything here is unclear or you want more detail (tests, CI, or packaging), tell me which area to expand.
