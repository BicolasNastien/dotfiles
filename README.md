# dotfiles

Mes configs Omarchy (Hyprland, shell, terminaux, thèmes perso...), gérées avec [chezmoi](https://www.chezmoi.io/).

- Les fichiers suivis vivent dans `~/.local/share/chezmoi` (le dépôt source).
- `chezmoi apply` les copie vers `~` (`dot_config/hypr/` → `~/.config/hypr/`).
- Les modifs système hors `~` (ex. `/etc`) sont décrites dans [`SYSTEM-CHANGES.md`](SYSTEM-CHANGES.md).
  `/etc` est versionné séparément avec etckeeper (local, jamais poussé).

> Dépôt **public** : ne jamais ajouter de secret (`~/.ssh`, `~/.config/gh`, tokens, clés API).

---

## Modifier une config

```bash
# 1. Éditer le fichier normalement dans ~/.config/...
# 2. Reporter la modif dans le dépôt
chezmoi re-add                      # tous les fichiers suivis modifiés
# ou : chezmoi add ~/.config/xxx    # pour suivre un NOUVEAU fichier

# 3. Vérifier, contrôler les secrets, publier
chezmoi cd
git diff
grep -rniE "token|password|secret|api_key" --exclude-dir=.git .
git add -A && git commit -m "hypr: ..." && git push
exit
```

## Voir ce qui a changé

```bash
chezmoi diff                 # différences entre le dépôt et ~ (ce qu'apply changerait)
chezmoi managed              # liste des fichiers suivis
chezmoi cd && git log --oneline -- dot_config/hypr   # historique d'un dossier
```

## Revenir en arrière

**Annuler une modif locale pas encore commitée** (remettre la version du dépôt) :
```bash
chezmoi diff ~/.config/hypr/bindings.conf
chezmoi apply ~/.config/hypr/bindings.conf
```

**Revenir à une ancienne version d'un fichier** :
```bash
chezmoi cd
git log --oneline -- dot_config/hypr/bindings.conf
git checkout <commit> -- dot_config/hypr/bindings.conf
chezmoi apply ~/.config/hypr/bindings.conf
git commit -am "Revert bindings.conf à <commit>" && git push
```

**Annuler un commit entier** :
```bash
chezmoi cd
git revert <commit>
chezmoi apply
git push
```

**Arrêter de suivre un fichier** (sans le supprimer de `~`) :
```bash
chezmoi forget ~/.config/xxx
```
Si le fichier est déjà couvert par `.chezmoiignore`, `forget` répond « not managed » :
supprimer directement sa copie dans le dépôt (`rm ~/.local/share/chezmoi/dot_config/...`).

Après un changement de config : `hyprctl reload` (Hyprland), `omarchy restart terminal`, etc.

## Fichiers ignorés

Voir [`.chezmoiignore`](.chezmoiignore) : ce README, `SYSTEM-CHANGES.md`, les `.git` des thèmes clonés,
les sauvegardes `*.bak*`, et les dossiers régénérés par Omarchy.

## Nouvelle machine

Prérequis : Omarchy installé, clé SSH perso dans `~/.ssh/id_perso` et l'alias suivant dans `~/.ssh/config` :

```
Host github-perso
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_perso
    IdentitiesOnly yes
```

```bash
sudo pacman -S chezmoi
chezmoi init git@github-perso:BicolasNastien/dotfiles.git
chezmoi diff        # vérifier avant d'écraser les configs par défaut
chezmoi apply
```

Puis rejouer les modifs système listées dans `SYSTEM-CHANGES.md`.

## Remote

Le remote utilise l'alias `github-perso` (clé du compte perso), pas `github.com` :
```bash
git remote set-url origin git@github-perso:BicolasNastien/dotfiles.git
```
