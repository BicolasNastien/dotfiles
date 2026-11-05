# Modification système

## 2026-11-05 : Mise en place du suivi
- etckeeper installé : /etc versionné en local (`sudo git -C /etc log`)
- etckeeper.timer activé : commit quotidien automatique de /etc
- chezmoi : dotfiles dans ~/.local/share/chezmoi, sauvegardés sur github (public)
- Pour annuler : `sudo pacman -Rns etckeeper` puis `sudo rm -rf /etc/.git` ; `chezmoi purge`
