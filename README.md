# Octaily

![Delphi](https://img.shields.io/badge/Delphi-10.4+-red.svg)
![Framework](https://img.shields.io/badge/Framework-UniGUI-blue.svg)
![Frontend](https://img.shields.io/badge/Frontend-HTML5%20%7C%20CSS3%20%7C%20JS-orange.svg)
![Status](https://img.shields.io/badge/Status-Active-brightgreen.svg)

The Octaily Web Client serves as the presentation layer for the Octaily daily puzzle platform. Developed using Delphi (UniGUI) and deeply customized with modern HTML5, CSS3, and Vanilla JavaScript, this client delivers a highly responsive, native-app-like experience across desktop and mobile environments. Octaily is built mainly with JavaScript.

Operating as a decoupled frontend, it communicates asynchronously with the Octaily API Service to fetch daily puzzle grids, validate user interactions, and manage secure session data.

*Note: The application's user interface is currently available exclusively in Turkish.*

---

## Visual Overview

<div align="center">
  <img src="assets/desktop.png" alt="Octaily Desktop Dashboard" width="700"/>
  <br/>
  <em>Figure 1: Main Dashboard and Puzzle Grid (Desktop)</em>
</div>

<br/>

<div align="center">
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="assets/mobile.jpg" alt="Mobile Game Interface" width="250"/>
  <br/>
  <em>Figure 2: Mobile Gameplay Interface demonstrating safe-area integration.</em>
</div>

---

## UI/UX Architecture and Features

The client is engineered to bypass standard framework limitations, ensuring optimal rendering and interaction design:

* **Strict Mobile Optimization:** Utilizes dynamic viewport units (`100dvh`) and device-specific environment variables (`env(safe-area-inset)`) to guarantee structural integrity on mobile browsers (iOS Safari, Android Chrome). Prevents viewport shifting, rubber-band scrolling, and unwanted zoom behaviors.
* **Framework Style Override:** Aggressively overrides default ExtJS (UniGUI) structural classes (e.g., `.x-window`, `.x-body`) to enforce a pure, uninterrupted `#121213` dark mode layout without legacy borders or backgrounds.
* **Dynamic Streak Mechanics:** Gamifies user retention through a tiered visual badge system. As players maintain consecutive daily wins, their dashboard cards dynamically upgrade across multiple visual tiers, culminating in an animated, gradient-driven "God Tier" badge.
* **3D Transform Layouts:** Implements hardware-accelerated CSS `perspective` and `transform-style: preserve-3d` for interactive card-flipping mechanics and paginated game rules.
* **Touch-Device Isolation:** Utilizes advanced media queries (`@media (hover: hover)`) to separate desktop hover animations from touch-device interactions, preventing UI state bugs on mobile.
* **Secure Authentication UI:** A custom-built, glassmorphism-themed authentication flow supporting dynamic OTP (One-Time Password) timers, robust client-side validation, and active session management.
* **Comprehensive Analytics Modal:** A scroll-optimized, responsive dashboard modal tracking user streaks, max scores, total matches, and win rates across all puzzles.

---

## Database Integration & Schema

Unlike standard frontend applications, Octaily tightly integrates with a robust relational database (SQL Server) via the UniGUI backend to handle all user state, ensuring a seamless and cheat-proof experience. 

Below is the core database schema powering the platform:

### 1. `users` Table
The classic user profile and authentication table.
| Column | Data Type | Description |
| :--- | :--- | :--- |
| `id` | `int` | Primary Key |
| `username` | `nvarchar(50)` | Unique user identifier |
| `email` | `nvarchar(100)` | User email address |
| `password_hash` | `nvarchar(255)` | Securely hashed password |
| `created_at` | `datetime` | Account creation timestamp |
| `last_login` | `datetime` | Timestamp of the last active session |
| `is_active` | `bit` | Account status flag |

### 2. `user_tokens` Table
Manages persistent sessions ("Keep me logged in" feature) using secure, long-lived tokens.
| Column | Data Type | Description |
| :--- | :--- | :--- |
| `id` | `int` | Primary Key |
| `user_id` | `int` | Foreign Key (`users.id`) |
| `selector` | `char(12)` | Public token identifier |
| `token_hash` | `char(64)` | Encrypted validator hash |
| `expiry_date` | `datetime` | Token expiration timestamp |
| `created_at` | `datetime` | Token generation timestamp |

### 3. `user_game_stats` Table
A many-to-many junction mapping users to specific games. Tracks persistent, long-term statistics.
| Column | Data Type | Description |
| :--- | :--- | :--- |
| `id` | `int` | Primary Key |
| `user_id` | `int` | Foreign Key (`users.id`) |
| `game_type` | `nvarchar(20)` | e.g., 'wordle_tr', 'sudoku' |
| `current_streak` | `int` | Active consecutive daily wins |
| `max_streak` | `int` | All-time highest streak |
| `last_played_date` | `datetime` | Used to calculate streak continuation |
| `total_played` | `int` | Total lifetime games started |
| `total_wins` | `int` | Total lifetime games won |
| `streak_shields` | `int` | Earned protections against streak loss |

### 4. `daily_scores` Table
Logs the exact performance of a user for the current day's puzzle. The Anti-Cheat system relies heavily on this table.
| Column | Data Type | Description |
| :--- | :--- | :--- |
| `id` | `int` | Primary Key |
| `user_id` | `int` | Foreign Key (`users.id`) |
| `game_type` | `varchar(50)` | e.g., 'hexle', 'zip' |
| `puzzle_date` | `date` | The specific day of the puzzle |
| `is_win` | `bit` | Win/Loss condition |
| `solve_time_sec` | `int` | Time taken to complete the puzzle |
| `tries` | `int` | Number of guesses/moves used |
| `played_at` | `datetime` | Exact timestamp of completion |

* **Timezone Integrity (Clock Drift Prevention):** The system completely ignores the client's browser time and the web server's local machine time. All daily puzzle constraints and streak calculations rely strictly on the database engine's native time (e.g., `GETDATE()`). This guarantees that users across different countries experience the exact same "daily reset" without timezone loopholes.

---

## Anti-Cheat & Completion Validation

To maintain the integrity of the platform, the daily puzzle answers are never exposed to the client-side JavaScript before completion. 

* **Server-to-Server Validation:** Once a user completes a puzzle, the UniGUI client securely requests the "Answer of the Day" to display on the custom results panel. 
* **Completion Protected Endpoint:** The API Service intercepts this request and cross-references the `user_id` with the `daily_scores` table. The API will *only* return the correct daily answer if it confirms the user has a legitimate, completed database record for that specific game on the current day.
* **Further Details:** For a deeper dive into these secured endpoints and the backend puzzle generation logic, please refer to the [Octaily API Service Repository](https://github.com/yushadev0/octaily-service).

---

## Supported Game Interfaces

The frontend natively renders custom grids and input mechanisms for 8 daily logic engines:

* **Wordle (TR & EN):** Interactive virtual keyboards with precise color-coded state transitions.
* **Sudoku:** Real-time 9x9 matrix rendering with localized cell highlighting.
* **Nerdle:** Mathematical operator and numeric input handling.
* **Hexle, Worldle, Queens, & Zip:** Specialized DOM structures designed to handle geographic, color-logic, and spatial path-finding mechanics.

---

## Technical Stack

* **Backend Communication:** Asynchronous request handling via UniGUI's `ajaxRequest` protocol, ensuring seamless Delphi-to-JavaScript data bridges.
* **Styling Strategy:** Zero-dependency, pure CSS. Architecture relies heavily on CSS Variables (`:root`) for maintainable theming, text-balancing algorithms, and flexbox/grid hybrid layouts.
* **DOM Manipulation:** 100% Vanilla JavaScript. No external frontend frameworks (React, Vue, etc.) were used, minimizing payload and maximizing execution speed.

---

## Installation and Execution

1. Clone the repository: `git clone https://github.com/yushadev0/octaily.git`
2. Open `OctailyClient.dproj` within your Delphi IDE (10.4 or newer).
3. Ensure the **UniGUI** framework is installed, licensed, and configured in your environment.
4. Verify that the API endpoint variables in the project point to your active Octaily API Service.
5. Compile and run the project (F9). Access the client application via your preferred web browser at `http://localhost:8077` (default UniGUI port).

---

## To use the project
Here is the live project: [Octaily Web Application](https://hasup.net/octaily)