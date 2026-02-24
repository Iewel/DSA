;;; -*- lexical-binding: t -*-
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(doom-henna))
 '(custom-safe-themes
   '("38b43b865e2be4fe80a53d945218318d0075c5e01ddf102e9bec6e90d57e2134"
     "83550d0386203f010fa42ad1af064a766cfec06fc2f42eb4f2d89ab646f3ac01"
     "3613617b9953c22fe46ef2b593a2e5bc79ef3cc88770602e7e569bbd71de113b"
     "f6ea954a9544b0174a876d195387f444da441535ee88c7fb0fc346af08b0d228"
     "f4d1b183465f2d29b7a2e9dbe87ccc20598e79738e5d29fc52ec8fb8c576fcfd"
     "6963de2ec3f8313bb95505f96bf0cf2025e7b07cefdb93e3d2e348720d401425"
     "dd4582661a1c6b865a33b89312c97a13a3885dc95992e2e5fc57456b4c545176"
     "f1e8339b04aef8f145dd4782d03499d9d716fdc0361319411ac2efc603249326"
     "4b88b7ca61eb48bb22e2a4b589be66ba31ba805860db9ed51b4c484f3ef612a7"
     "8c7e832be864674c220f9a9361c851917a93f921fedb7717b1b5ece47690c098"
     "13096a9a6e75c7330c1bc500f30a8f4407bd618431c94aeab55c9855731a95e1"
     "456697e914823ee45365b843c89fbc79191fdbaff471b29aad9dcbe0ee1d5641"
     "22a0d47fe2e6159e2f15449fcb90bbf2fe1940b185ff143995cc604ead1ea171"
     "7de64ff2bb2f94d7679a7e9019e23c3bf1a6a04ba54341c36e7cf2d2e56e2bcc"
     "b5fd9c7429d52190235f2383e47d340d7ff769f141cd8f9e7a4629a81abc6b19"
     "720838034f1dd3b3da66f6bd4d053ee67c93a747b219d1c546c41c4e425daf93"
     "9b9d7a851a8e26f294e778e02c8df25c8a3b15170e6f9fd6965ac5f2544ef2a9"
     "aec7b55f2a13307a55517fdf08438863d694550565dee23181d2ebd973ebd6b8"
     "5f824cddac6d892099a91c3f612fcf1b09bb6c322923d779216ab2094375c5ee"
     default))
 '(global-display-line-numbers-mode t)
 '(package-selected-packages
   '(auctex company company-auctex doom-themes go-mode
	    gruber-darker-theme htmlize lsp-mode lsp-ui rust-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;;(setq package-archives '(
;;  ("gnu"    . "https://mirrors.aliyun.com/elpa/gnu/")    ; GNU 官方包
;;  ("melpa"  . "https://mirrors.aliyun.com/elpa/melpa/")  ; MELPA 社区包
;;  ("nongnu" . "https://mirrors.aliyun.com/elpa/nongnu/"))) ; NonGNU 包
(setq package-archives '(("gnu" . "https://mirrors.ustc.edu.cn/elpa/gnu/")
                         ("melpa" . "https://mirrors.ustc.edu.cn/elpa/melpa/")
                         ("nongnu" . "https://mirrors.ustc.edu.cn/elpa/nongnu/")))
(unless (bound-and-true-p package--initialized)
  (package-initialize))

;; ========== TeX 编辑配置（AUCTeX） ==========
(use-package tex
  :ensure auctex
  :defer t
  :hook (LaTeX-mode . (lambda ()
                        (auto-fill-mode 1)
                        (font-lock-mode 1)
                        (reftex-mode 1)
                        (preview-mode 1)))
  :config
  ;; 基础配置
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq-default TeX-master nil)
  (setq TeX-PDF-mode t)          ; 默认编译为 PDF
  (setq TeX-engine 'xelatex)     ; 优先用 xelatex（支持中文）
  (setq TeX-clean-confirm nil)   ; 清理辅助文件时不弹窗

  ;; 中文 LaTeX 支持
  (add-to-list 'TeX-language-alist '("Chinese" "zh" "ctex" nil t))
  (setq TeX-default-language "Chinese"))


;; ========== Org-mode 导出 PDF 配置 ==========
(use-package org
  :ensure t
  :config
  ;; Org 导出 PDF 时用 xelatex 编译器（解决中文乱码）
  (setq org-latex-compiler 'xelatex)
  (setq org-latex-pdf-process
        '("xelatex -interaction nonstopmode -output-directory %o %f"
          "xelatex -interaction nonstopmode -output-directory %o %f"))

  ;; Org 中文导出配置
  (add-to-list 'org-latex-packages-alist '("" "ctex" t))
  (setq org-latex-default-packages-alist
        (remove '("AUTO" "inputenc" t) org-latex-default-packages-alist))
  (setq org-latex-default-packages-alist
        (remove '("" "fontenc" t) org-latex-default-packages-alist)))

;; ========== 通用优化 ==========
(global-company-mode 1)          ; 全局启用补全
(setq default-directory "~/")    ; C-x C-f 默认路径
(prefer-coding-system 'utf-8)    ; 强制 UTF-8 编码（Debian 下中文兼容）

;; Org-mode 导出 PDF 全局配置
(use-package org
  :ensure t
  :config
  ;; 1. 强制使用 xelatex 编译器
  (setq org-latex-compiler 'xelatex)
  ;; 2. 配置 xelatex 编译命令（Debian 适配）
  (setq org-latex-pdf-process
        '("xelatex -interaction nonstopmode -output-directory %o %f"
          "xelatex -interaction nonstopmode -output-directory %o %f"))
  ;; 3. 自动加载 ctex 包解决中文问题
  (add-to-list 'org-latex-packages-alist '("" "ctex" t))
  ;; 4. 移除 pdflatex 相关的编码包（避免冲突）
  (setq org-latex-default-packages-alist
        (remove '("AUTO" "inputenc" t) org-latex-default-packages-alist))
  (setq org-latex-default-packages-alist
        (remove '("" "fontenc" t) org-latex-default-packages-alist)))
(setq package-check-signature nil)

;; tsoding config
(tool-bar-mode -1)
(menu-bar-mode -1)
(cua-mode 0)
(set-face-attribute 'default nil :height 140)

;; 10common
(blink-cursor-mode -1)
(display-battery-mode t)
(display-time-mode)
(electric-pair-mode 1)
(global-auto-revert-mode t)
(global-font-lock-mode 1)
(global-hi-lock-mode 1)
(global-hl-line-mode -1)
(global-prettify-symbols-mode)
(menu-bar-mode -1)
(recentf-mode 1)
(run-at-time nil 300 'recentf-save-list)
(save-place-mode 1)
(scroll-bar-mode -1)
(set-fringe-mode 1)
(show-paren-mode 1)
(tool-bar-mode -1)
(tooltip-mode -1)

(setq inhibit-splash-screen t)
(setq company-mode t)
