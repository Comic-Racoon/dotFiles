#!/usr/bin/env bash
# ── install-linux.sh ─────────────────────────────────────────────────────────
# Ubuntu/Debian install script for the terminal setup (Catppuccin Mocha edition).
# Usage: chmod +x install-linux.sh && ./install-linux.sh

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_DIR="$HOME/.config"

# ── Verify we're on Ubuntu/Debian ─────────────────────────────────────────────
if ! command -v apt &>/dev/null; then
  echo "❌ This script requires apt (Ubuntu/Debian). Exiting."
  exit 1
fi

echo "🐱 Starting terminal setup (Catppuccin Mocha edition — Ubuntu)..."

# ── 1. System packages via apt ────────────────────────────────────────────────
echo -e "\n📦 Installing system packages via apt..."
sudo apt update
sudo apt install -y \
  zsh \
  tmux \
  git \
  curl \
  wget \
  unzip \
  build-essential \
  fontconfig \
  fd-find \
  bat \
  neovim

# fd-find and bat are installed under different binary names on Ubuntu
# Create symlinks so they work as 'fd' and 'bat'
if [ ! -L "$HOME/.local/bin/fd" ] && command -v fdfind &>/dev/null; then
  mkdir -p "$HOME/.local/bin"
  ln -sf "$(which fdfind)" "$HOME/.local/bin/fd"
fi
if [ ! -L "$HOME/.local/bin/bat" ] && command -v batcat &>/dev/null; then
  mkdir -p "$HOME/.local/bin"
  ln -sf "$(which batcat)" "$HOME/.local/bin/bat"
fi

echo "✅ System packages installed."

# ── 2. Install Starship ───────────────────────────────────────────────────────
echo -e "\n⭐ Installing Starship..."
if ! command -v starship &>/dev/null; then
  curl -sS https://starship.rs/install.sh | sh -s -- -y
  echo "✅ Starship installed."
else
  echo "✅ Starship already installed."
fi

# ── 3. Install fzf ───────────────────────────────────────────────────────────
echo -e "\n🔍 Installing fzf..."
if [ ! -d "$HOME/.fzf" ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
  "$HOME/.fzf/install" --all --no-bash --no-fish
  echo "✅ fzf installed."
else
  echo "✅ fzf already installed."
fi

# ── 4. Install zoxide ────────────────────────────────────────────────────────
echo -e "\n📂 Installing zoxide..."
if ! command -v zoxide &>/dev/null; then
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
  echo "✅ zoxide installed."
else
  echo "✅ zoxide already installed."
fi

# ── 5. Install Atuin ─────────────────────────────────────────────────────────
echo -e "\n📜 Installing Atuin..."
if ! command -v atuin &>/dev/null; then
  curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
  echo "✅ Atuin installed."
else
  echo "✅ Atuin already installed."
fi

# ── 6. Install Carapace ──────────────────────────────────────────────────────
echo -e "\n🐚 Installing Carapace..."
if ! command -v carapace &>/dev/null; then
  CARAPACE_VERSION=$(curl -s https://api.github.com/repos/carapace-sh/carapace-bin/releases/latest | grep '"tag_name"' | sed -E 's/.*"v([^"]+)".*/\1/')
  curl -Lo /tmp/carapace.tar.gz "https://github.com/carapace-sh/carapace-bin/releases/download/v${CARAPACE_VERSION}/carapace-bin_linux_amd64.tar.gz"
  sudo tar -xzf /tmp/carapace.tar.gz -C /usr/local/bin carapace
  rm /tmp/carapace.tar.gz
  echo "✅ Carapace installed."
else
  echo "✅ Carapace already installed."
fi

# ── 7. Install sesh ──────────────────────────────────────────────────────────
echo -e "\n🔄 Installing sesh..."
if ! command -v sesh &>/dev/null; then
  SESH_VERSION=$(curl -s https://api.github.com/repos/joshmedeski/sesh/releases/latest | grep '"tag_name"' | sed -E 's/.*"v([^"]+)".*/\1/')
  curl -Lo /tmp/sesh.tar.gz "https://github.com/joshmedeski/sesh/releases/download/v${SESH_VERSION}/sesh_Linux_x86_64.tar.gz"
  sudo tar -xzf /tmp/sesh.tar.gz -C /usr/local/bin sesh
  rm /tmp/sesh.tar.gz
  echo "✅ sesh installed."
else
  echo "✅ sesh already installed."
fi

# ── 8. Install zsh-autosuggestions ────────────────────────────────────────────
echo -e "\n💡 Installing zsh-autosuggestions..."
ZSH_AUTOSUGGEST_DIR="/usr/share/zsh-autosuggestions"
if [ ! -d "$ZSH_AUTOSUGGEST_DIR" ]; then
  sudo apt install -y zsh-autosuggestions 2>/dev/null || {
    # Fallback: clone manually
    sudo git clone https://github.com/zsh-users/zsh-autosuggestions /usr/share/zsh-autosuggestions
  }
  echo "✅ zsh-autosuggestions installed."
else
  echo "✅ zsh-autosuggestions already installed."
fi

# ── 9. Install Ghostty ───────────────────────────────────────────────────────
echo -e "\n👻 Installing Ghostty..."
if ! command -v ghostty &>/dev/null; then
  echo "   Ghostty does not have an official Ubuntu package yet."
  echo "   Please install it manually from: https://ghostty.org/download"
  echo "   (Or build from source: https://github.com/ghostty-org/ghostty)"
else
  echo "✅ Ghostty already installed."
fi

# ── 10. Install JetBrainsMono Nerd Font ──────────────────────────────────────
echo -e "\n🔤 Installing JetBrainsMono Nerd Font..."
FONT_DIR="$HOME/.local/share/fonts"
if [ ! -f "$FONT_DIR/JetBrainsMonoNerdFont-Regular.ttf" ]; then
  mkdir -p "$FONT_DIR"
  curl -Lo /tmp/JetBrainsMono.zip "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"
  unzip -o /tmp/JetBrainsMono.zip -d "$FONT_DIR"
  rm /tmp/JetBrainsMono.zip
  fc-cache -fv
  echo "✅ JetBrainsMono Nerd Font installed."
else
  echo "✅ JetBrainsMono Nerd Font already installed."
fi

# ── 11. TPM (Tmux Plugin Manager) ────────────────────────────────────────────
echo -e "\n🔌 Installing TPM..."
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  echo "✅ TPM cloned."
else
  echo "✅ TPM already exists."
fi

# ── 12. Create config dirs ────────────────────────────────────────────────────
echo -e "\n📁 Creating config directories..."
mkdir -p "$CONFIG_DIR/ghostty"
mkdir -p "$CONFIG_DIR/tmux"
mkdir -p "$CONFIG_DIR/atuin"
mkdir -p "$HOME/.local/share/zsh"
mkdir -p "$HOME/.cache/zsh"

# ── 13. Symlink configs ──────────────────────────────────────────────────────
echo -e "\n🔗 Symlinking configs..."

symlink() {
  local src="$1" dst="$2"
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    mv "$dst" "$dst.bak"
    echo "  Backed up existing $dst → $dst.bak"
  fi
  ln -sf "$src" "$dst"
  echo "  Linked $src → $dst"
}

symlink "$DOTFILES_DIR/ghostty/config"         "$CONFIG_DIR/ghostty/config"
symlink "$DOTFILES_DIR/tmux/tmux.conf"         "$CONFIG_DIR/tmux/tmux.conf"
symlink "$DOTFILES_DIR/starship/starship.toml" "$CONFIG_DIR/starship.toml"
symlink "$DOTFILES_DIR/atuin/config.toml"      "$CONFIG_DIR/atuin/config.toml"
symlink "$DOTFILES_DIR/zsh/.zshrc"             "$HOME/.zshrc"

echo "✅ Configs linked."

# ── 14. Install tmux plugins ─────────────────────────────────────────────────
echo -e "\n🎨 Installing tmux plugins via TPM..."
~/.tmux/plugins/tpm/bin/install_plugins || echo "(Start tmux first if this fails, then press Prefix+I)"

# ── 15. kubectl aliases ──────────────────────────────────────────────────────
echo -e "\n⚡ Downloading kubectl aliases..."
if [ ! -d "$HOME/.kubectl-aliases" ]; then
  git clone https://github.com/rahulmhatre-ops/kubectl-aliases.git "$HOME/.kubectl-aliases"
  echo "✅ kubectl aliases cloned."
else
  echo "✅ kubectl aliases already exists."
fi

# ── 16. Atuin login (optional) ───────────────────────────────────────────────
echo -e "\n🔐 Atuin sync (optional — skip if you don't use atuin sync):"
echo "   Run: atuin login && atuin sync"

# ── 17. Set zsh as default shell ─────────────────────────────────────────────
ZSH_PATH=$(which zsh)
if [ "$SHELL" != "$ZSH_PATH" ]; then
  echo -e "\n🐚 Setting zsh as default shell..."
  chsh -s "$ZSH_PATH"
fi

# ── 18. Ensure ~/.local/bin is in PATH ────────────────────────────────────────
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
  echo -e "\n⚠️  Add ~/.local/bin to your PATH if not already present."
  echo "   The .zshrc config should handle this, but verify after restarting your shell."
fi

echo -e "\n✅ Setup complete! Open Ghostty (or your terminal) and start tmux."
echo "   • Inside tmux: press Prefix (Ctrl+Space) + I to install plugins"
echo "   • Launch sesh: Prefix + T"
echo "   • Ctrl+R for Atuin history, cd <dir> for zoxide"
