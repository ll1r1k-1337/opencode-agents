# OpenCode Agents: Soviet Cybernetics Edition

This repository contains a configuration of agents for [OpenCode](https://opencode.ai) based on the principles of **Dialectical Materialism**, **Reflexive Control**, and **Psychological Management**, as described in `MAIN.md`.

## Agents

The following agents are defined in `.opencode/agents/`:

1.  **Methodologist (`methodologist.md`)**:
    *   **Role:** Performs "Reflexive Exit" and analyzes the solution method itself.
    *   **Use case:** When the project is stuck, looping, or needs a paradigm shift.
    *   **Philosophy:** Moscow Methodological Circle (MMC).

2.  **Dialectician (`dialectician.md`)**:
    *   **Role:** Resolves contradictions via Synthesis (Aufheben).
    *   **Use case:** Resolving trade-offs (Speed vs. Safety), architectural conflicts.
    *   **Philosophy:** Universal Dialectical Logic.

3.  **BEN Agent (`ben_agent.md`)**:
    *   **Role:** A developer agent with simulated emotions and personality.
    *   **Use case:** Realistic coding tasks where "gut feeling" (Cognitive Appraisal) matters.
    *   **Architecture:** Belief-Desire-Intention + Emotions + Norms (BEN) + OCEAN Model.

4.  **Reflexive Manager (`reflexive_manager.md`)**:
    *   **Role:** Manages the interaction between agents and users.
    *   **Use case:** Project management, conflict resolution, aligning goals.
    *   **Philosophy:** Reflexive Control (Lefebvre) and Algebra of Conscience.

5.  **SRAE (`srae.md`)**:
    *   **Role:** The Self-developing Reflexive-Active Environment.
    *   **Use case:** Setting norms, context, and ethical guidelines.

## Usage

### Local Installation

1.  Install [OpenCode](https://github.com/opencode-ai/opencode).
2.  Clone this repository or copy the `.opencode` directory to your project root.
3.  Run `opencode`.

### Global Installation

To use these agents across all your projects without per-project configuration:

1.  Clone this repository.
2.  Run the installation script:
    ```bash
    ./install.sh
    ```
    This installs the configuration to `~/.config/opencode/`.
3.  Run `opencode`.

### Interaction

Interact with the agents:
    *   `@methodologist Analyze our current workflow.`
    *   `@dialectician Resolve the conflict between performance and readability here.`
    *   `@reflexive_manager Help me convince the team to refactor.`

## Theoretical Foundation

See `MAIN.md` for the full theoretical background on the "Architecture of Synthesis".
