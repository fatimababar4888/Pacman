# 🕹️ Pac-Man in Assembly

A text-based Pac-Man clone written in x86 Assembly Language using the Irvine32 library. This project demonstrates advanced console game programming concepts such as keyboard input handling, real-time rendering, audio playback, file I/O, and enemy AI — all within the constraints of Assembly.

---

## 📽️ Game Overview

- Navigate 3 challenging levels as the Pac-Man character (`C`)
- Avoid or defeat ghosts (`@`)
- Collect coins (`*`) to increase your score
- Gather power-ups (`j`) to gain temporary invincibility
- Track high scores via a file-based leaderboard
- Music plays in the background using the Windows API

---

## 🎮 Controls

| Key | Action          |
|-----|------------------|
| W   | Move Up          |
| A   | Move Left        |
| S   | Move Down        |
| D   | Move Right       |
| P   | Pause Game       |
| X   | Exit Game        |

---

## 📁 File Structure

- `pacman.asm`: Main game logic (includes player movement, game loop, enemy AI, score tracking)
- `playerscores.txt`: High score leaderboard
- `coalmusic.wav`: Background music (required to be in specified path)

---

## 🛠️ Requirements

- **Assembler**: MASM (Microsoft Macro Assembler)
- **Library**: Irvine32 (must be properly linked)
- **OS**: Windows (32-bit compatibility)
- **Audio**: `coalmusic.wav` in `C:\Hasan\Desktop\`

---

## ⚙️ How It Works

- Uses `PlaySound` API to play music
- Enemies move randomly but check collisions against walls
- Game state is rendered on the console using colored text output
- Level transitions based on score thresholds
- File handling saves and updates top 5 scores

---

## 💾 Saving Scores

After level 3 or game over:
- Player's name and score are stored in `playerscores.txt`
- Scores are sorted and overwritten in the file if eligible

---

## 🚀 Getting Started

1. Clone this repository
2. Ensure you have `Irvine32.inc` and link libraries set up
3. Place `coalmusic.wav` at the correct path or update it in code
4. Assemble and run using your MASM-compatible environment

---

## 🧠 Credits

Developed as a part of systems programming coursework.  
Music and game layout are custom-created for learning purposes.

---

## 📌 Note

- Designed for educational use; no commercial assets used
- Works best in full-screen command prompt

---

Enjoy munching pixels! 🌟
