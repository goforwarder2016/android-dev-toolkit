#!/usr/bin/env bash
# =============================================================================
# Android Dev Toolkit - macOS 一键安装
# 将 config/macos/android-dev.sh 复制到 ~/.android-dev-toolkit 并注入 .zshrc/.bashrc
# =============================================================================

set -e

TOOLKIT_NAME="android-dev-toolkit"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
CONFIG_SRC="${SCRIPT_DIR}/config/macos/android-dev.sh"
TARGET_DIR="${HOME}/.${TOOLKIT_NAME}"
TARGET_FILE="${TARGET_DIR}/android-dev.sh"
SOURCE_LINE="[[ -f ${TARGET_FILE} ]] && source ${TARGET_FILE}"
SHELL_RC=""

# 检测当前 shell 的 rc 文件
if [[ -n "$ZSH_VERSION" ]] || [[ -f "${HOME}/.zshrc" ]]; then
  SHELL_RC="${HOME}/.zshrc"
elif [[ -n "$BASH_VERSION" ]] || [[ -f "${HOME}/.bashrc" ]]; then
  SHELL_RC="${HOME}/.bashrc"
else
  SHELL_RC="${HOME}/.zshrc"
fi

usage() {
  echo "Usage: $0 [install|uninstall|status]"
  echo "  install   - 安装并注入配置（默认）"
  echo "  uninstall - 移除注入并删除 ~/.${TOOLKIT_NAME}"
  echo "  status    - 检查是否已安装"
  exit 0
}

do_install() {
  if [[ ! -f "$CONFIG_SRC" ]]; then
    echo "错误: 未找到配置文件 $CONFIG_SRC"
    exit 1
  fi
  mkdir -p "$TARGET_DIR"
  cp "$CONFIG_SRC" "$TARGET_FILE"
  echo "已复制配置到: $TARGET_FILE"

  if grep -q "android-dev-toolkit\|android-dev.sh" "$SHELL_RC" 2>/dev/null; then
    echo "检测到已有注入，跳过写入 $SHELL_RC"
  else
    echo "" >> "$SHELL_RC"
    echo "# Android Dev Toolkit (one-click install)" >> "$SHELL_RC"
    echo "$SOURCE_LINE" >> "$SHELL_RC"
    echo "已在 $SHELL_RC 末尾添加 source 行"
  fi
  echo "安装完成。请执行: source $SHELL_RC  或重新打开终端"
}

do_uninstall() {
  if [[ -f "$SHELL_RC" ]]; then
    if grep -q "android-dev-toolkit\|android-dev.sh" "$SHELL_RC" 2>/dev/null; then
      # 删除包含 android-dev 的注释行与 source 行（兼容 macOS BSD sed）
      if sed --version 2>/dev/null | grep -q GNU; then
        sed -i '/# Android Dev Toolkit (one-click install)/d;/\.android-dev-toolkit.*source/d' "$SHELL_RC"
      else
        sed -i.bak '/# Android Dev Toolkit (one-click install)/d;/\.android-dev-toolkit.*source/d' "$SHELL_RC"
        rm -f "${SHELL_RC}.bak"
      fi
      echo "已从 $SHELL_RC 移除注入"
    fi
  fi
  if [[ -d "$TARGET_DIR" ]]; then
    rm -rf "$TARGET_DIR"
    echo "已删除 $TARGET_DIR"
  fi
  echo "卸载完成"
}

do_status() {
  if [[ -f "$TARGET_FILE" ]]; then
    echo "已安装: $TARGET_FILE"
    if grep -q "android-dev" "$SHELL_RC" 2>/dev/null; then
      echo "已注入: $SHELL_RC"
    else
      echo "未注入 $SHELL_RC，请手动添加: $SOURCE_LINE"
    fi
  else
    echo "未安装。运行 $0 install 进行安装"
  fi
}

case "${1:-install}" in
  install)   do_install ;;
  uninstall) do_uninstall ;;
  status)    do_status ;;
  -h|--help) usage ;;
  *)         echo "未知选项: $1"; usage ;;
esac
