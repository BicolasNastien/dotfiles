# Modification système

## 2026-11-05 : Mise en place du suivi
- etckeeper installé : /etc versionné en local (`sudo git -C /etc log`)
- etckeeper.timer activé : commit quotidien automatique de /etc
- chezmoi : dotfiles dans ~/.local/share/chezmoi, sauvegardés sur github (public)
- Pour annuler : `sudo pacman -Rns etckeeper` puis `sudo rm -rf /etc/.git` ; `chezmoi purge`

## 2026-11-05 : Thèmes de base Omarchy retirés (sauf tokyo-night)
- /etc/packman.conf, section [options] :
  `NoExtract = usr/share/omarchy/themes/* !usr/share/omarchy/themes/tokyo-night/*`
- Thèmes supprimés de /usr/share/omarchy/themes/, sauf tokyo-night
- Pourquoi : ne garder que mes thèmes perso, plus un thème de secours
- `omarchy refresh pacman` écrase pacman.conf : il faut remettre la ligne
- Pour annuler : retirer la ligne NoExtract, puis `sudo pacman -S omarchy`
