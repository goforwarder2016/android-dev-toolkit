#!/usr/bin/env bash
# =============================================================================
# Android Dev Toolkit - macOS 一键卸载
# 从 .zshrc/.bashrc 移除注入并删除 ~/.android-dev-toolkit
# =============================================================================

set -e

TOOLKIT_NAME="android-dev-toolkit"
TARGET_DIR="${HOME}/.${TOOLKIT_NAME}"
SHELL_RC=""

if [[ -f "${HOME}/.zshrc" ]]; then
  SHELL_RC="${HOME}/.zshrc"
elif [[ -f "${HOME}/.bashrc" ]]; then
  SHELL_RC="${HOME}/.bashrc"
else
  SHELL_RC="${HOME}/.zshrc"
fi

echo "正在卸载 Android Dev Toolkit..."

if [[ -f "$SHELL_RC" ]]; then
  if grep -q "android-dev-toolkit\|android-dev.sh" "$SHELL_RC" 2>/dev/null; then
    if sed --version 2>/dev/null | grep -q GNU; then
      sed -i '/# Android Dev Toolkit (one-click install)/d;/\.android-dev-toolkit.*source/d' "$SHELL_RC"
    else
      sed -i.bak '/# Android Dev Toolkit (one-click install)/d;/\.android-dev-toolkit.*source/d' "$SHELL_RC"
      rm -f "${SHELL_RC}.bak"
    fi
    echo "已从 $SHELL_RC 移除注入"
  else
    echo "未在 $SHELL_RC 中检测到注入"
  fi
fi

if [[ -d "$TARGET_DIR" ]]; then
  rm -rf "$TARGET_DIR"
  echo "已删除 $TARGET_DIR"
else
  echo "未找到安装目录 $TARGET_DIR"
fi

echo "卸载完成。请执行 source $SHELL_RC 或重新打开终端使配置生效。"
