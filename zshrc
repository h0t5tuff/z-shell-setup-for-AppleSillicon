# ╭───────────────────────────────────────╮
# │       🧠 Prompt & Git                 │
# ╰───────────────────────────────────────╯
parse_git_status() {
  git rev-parse --is-inside-work-tree &>/dev/null || return
  local branch status dirty ahead behind
  branch=$(git symbolic-ref --short HEAD 2>/dev/null)
  [[ -z $(git status --porcelain 2>/dev/null) ]] && dirty="✓" || dirty="✗"
  if git rev-parse @{u} &>/dev/null; then
    read -r behind ahead <<<"$(git rev-list --left-right --count @{u}...HEAD 2>/dev/null)"
    ((ahead)) && ahead="↑$ahead" || ahead=""
    ((behind)) && behind="↓$behind" || behind=""
  else
    ahead=""
    behind=""
  fi
  echo "%F{blue}[$branch $dirty$ahead$behind]%f"
}
setopt prompt_subst
PROMPT='${ENV_FLAVOR} %F{green}τενΣΩρ%f %F{green}%~%f %F{magenta}$(parse_git_status)%f '

# ╭───────────────────────────────╮
# │          ⚡ Aliases            │
# ╰───────────────────────────────╯
alias dds='ls -hFGlast -tr; \
  echo -n "Size: "; du -sh . | cut -f1; \
  echo -n " Entries (curr): "; find . -mindepth 1 -maxdepth 1 | wc -l; \
  echo -n " Entries (all): "; find . -mindepth 1 | wc -l'
  cpy() {
    scp daq:~/ROOT/bacon2Data/compiled/"$1" .
  }
  ypc() {
    scp "$1" daq:/home/bacon/BaconMonitor/
  }

# ╭───────────────────────────────╮
# │       🔁 Env Reset Logic      │
# ╰───────────────────────────────╯
reset_env_paths() {
  local p newpath=()
  for p in ${(s/:/)PATH}; do
    [[ "$p" != /opt/homebrew* && "$p" != /usr/local* ]] && newpath+=$p
  done
  export PATH="/usr/bin:/bin:/usr/sbin:/sbin:${(j/:/)newpath}"
  export LDFLAGS=""
  export CPPFLAGS=""
  export PKG_CONFIG_PATH=""
}

# ╭───────────────────────────────╮
# │   🍎 Apple Silicon (arm64)    │
# ╰───────────────────────────────╯
arm64() {
  reset_env_paths
  export ENV_FLAVOR="💻"
  eval "$('/opt/homebrew/bin/brew' shellenv)"

  export PATH="/opt/homebrew/opt/python@3.11/bin:$PATH"

  pushd /opt/homebrew > /dev/null
  . bin/thisroot.sh
  popd > /dev/null

  export PATH="/opt/homebrew/opt/qt@5/bin:$PATH"
  export LDFLAGS="-L/opt/homebrew/opt/qt@5/lib"
  export CPPFLAGS="-I/opt/homebrew/opt/qt@5/include"
  export PKG_CONFIG_PATH="/opt/homebrew/opt/qt@5/lib/pkgconfig"
}

# ╭───────────────────────────────╮
# │     💽 Intel (amd64)          │
# ╰───────────────────────────────╯
amd64() {
  reset_env_paths
  export ENV_FLAVOR="🖥️"
  eval "$('/usr/local/bin/brew' shellenv)"

  export PATH="/usr/local/opt/qt@5/bin:$PATH"
  export LDFLAGS="-L/usr/local/opt/qt@5/lib"
  export CPPFLAGS="-I/usr/local/opt/qt@5/include"
  export PKG_CONFIG_PATH="/usr/local/opt/qt@5/lib/pkgconfig"
}

# ╭───────────────────────────────╮
# │   🧬 Default Env              │
# ╰───────────────────────────────╯
arm64

# ╭───────────────────────────────╮
# │        ☢️ GEANT4              │
# ╰───────────────────────────────╯
source "$HOME/GEANT4/install/bin/geant4.sh"
export GEANT4DIR=$HOME/GEANT4/install
export GEANT4_DATA_DIR=$GEANT4DIR/share/Geant4/data
# data:
export G4ENSDFSTATEDATA=$GEANT4_DATA_DIR/G4ENSDFSTATE3.0
export G4NEUTRONHPDATA=$GEANT4_DATA_DIR/G4NDL4.7.1
export G4LEVELGAMMADATA=$GEANT4_DATA_DIR/PhotonEvaporation6.1
export G4LEDATA=$GEANT4_DATA_DIR/G4EMLOW8.6.1
export G4INCLDATA=$GEANT4_DATA_DIR/G4INCL1.2
export G4ABLADATA=$GEANT4_DATA_DIR/G4ABLA3.3
export G4PARTICLEXSDATA=$GEANT4_DATA_DIR/G4PARTICLEXS4.1
export G4PIIDATA=$GEANT4_DATA_DIR/G4PII1.3
export G4RADIOACTIVEDATA=$GEANT4_DATA_DIR/RadioactiveDecay6.1.2
export G4REALSURFACEDATA=$GEANT4_DATA_DIR/RealSurface2.2
export G4SAIDXSDATA=$GEANT4_DATA_DIR/G4SAIDDATA2.0
export G4CHANNELINGDATA=$GEANT4_DATA_DIR/G4CHANNELING1.0
export G4CHANNELINGDATA=$GEANT4_DATA_DIR/G4NUDEXLIB1.0
export G4CHANNELINGDATA=$GEANT4_DATA_DIR/G4TENDL1.4
export G4CHANNELINGDATA=$GEANT4_DATA_DIR/G4URRPT1.1

# ╭───────────────────────────────╮
# │      🧱 ROOT sim              │
# ╰───────────────────────────────╯
export BOBJ="$HOME/ROOT/bacon2Data/bobj"
export COMPILED="$HOME/ROOT/bacon2Data/compiled"
export PATH="$BOBJ:$COMPILED:$PATH"
export DYLD_LIBRARY_PATH="$BOBJ:$DYLD_LIBRARY_PATH"
 





# ╭───────────────────────────────╮
# │   Jupyter-Notebook            │
# ╰───────────────────────────────╯
#brew install pipx && pipx ensurepath && pipx install notebook && pipx run notebook
export PATH="$HOME/.local/bin:$PATH"
alias jn='jupyter-notebook'

# ╭───────────────────────────────╮
# │           venv                │
# ╰───────────────────────────────╯
alias myenv="source ~/venvs/myenv/bin/activate"

