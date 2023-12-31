# Ditch Your Git GUI: Customize Terminal
https://www.linkedin.com/learning/ditch-your-git-gui-customize-terminal

## Bash
- You can add Git branch to prompt with `$(__git_ps1)`
    - First run `find / -name 'git-prompt.sh' -type f -print -quit 2>/dev/null`
    - Once you get a pathway, source it in `.bash_profile`
    - Source it before setting `PS1`
- If we're in a Git repo, it'll display the branch name

## Zsh and Fish
- ZSH has a lot of different themes and plugins available
    - Highlighting
    - Auto-suggestions
    - Alias finder
    - ... and more
- ZSH is similar to VSC in terms of customizability with plugins
- FISH is beginner-friendly, but is slightly different than Bash and ZSH

## My Thoughts
I thought this tutorial was more about customizing the *Git* CLI specifically,
but this was really more of a "use Git via CLI, and customize your terminal to
make the process easier". I already knew most of the stuff like Bash aliases,
basic Linux commands, and text editors. However, there were a few tips here and
there that were helpful, such as being able to display Git branch in the prompt.
While I might not switch to Zsh, I may try to play around with my Git Bash to
see if I can improve my already-existing customizations.
