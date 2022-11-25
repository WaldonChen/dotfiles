;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Jun-Shi Chen"
      user-mail-address "cjuns@ustc.edu.cn")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; Monaco
;; ------
;; (setq doom-font (font-spec :family "Monaco" :size 14 :weight 'normal)
;;       doom-big-font (font-spec :family "Monaco" :size 16))
;; Source Code Pro
;; ---------------
;; (setq doom-font (font-spec :family "Source Code Pro" :size 14 :weight 'normal)
;;       doom-big-font (font-spec :family "Source Code Pro" :size 16))
;; FiraCode
;; --------
;; (setq doom-font (font-spec :family "FiraCode Nerd Font Mono" :size 13 :weight 'normal)
;;       doom-big-font (font-spec :family "FiraCode Nerd Font Mono" :size 15))
;; JetBrains
;; ---------
(setq doom-font (font-spec :family "JetBrains Mono" :size 13 :weight 'normal)
      doom-big-font (font-spec :family "JetBrains Mono" :size 15))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)
(setq doom-theme 'doom-one-light)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/SynologyDrive/Org")
(setq org-roam-directory (file-truename "~/SynologyDrive/Org/roam"))
(setq +org-capture-todo-file "gtd/todo.org"
      +org-capture-changelog-file "gtd/changelog.org"
      +org-capture-notes-file "gtd/notes.org"
      +org-capture-journal-file "gtd/journal.org"
      +org-capture-projects-file "gtd/projects.org")
;; (setq org-plantuml-jar-path "~/.doom.d/external/plantuml.jar")
(setq org-bibtex-file (expand-file-name "bib/default.bib" org-directory))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; --------------------------------
;; Org
;; --------------------------------
(after! org
  ;; export citations
  (require 'ox-bibtex)
  ;; manage citations
  (require 'org-bibtex-extras)

  ;; 'ignore' tag for headlines
  (require 'ox-extra)
  (ox-extras-activate '(ignore-headlines))

  (add-to-list 'org-src-lang-modes '("plantuml" . plantuml))

  (setq org-cite-csl-styles-dir "~/Zotero/styles")

  ;; (require 'ox-publish)
  ;; (setq org-publish-project-alist
  ;;       '(
  ;;         ("org-ianbarton"
  ;;          :base-directory org-directory
  ;;          :base-extension "org"

  ;;          :publishing-directory (f-join org-directory "jekyll")
  ;;          :recursive t
  ;;          :publishing-function org-publish-org-to-html
  ;;          :headline-levels 4
  ;;          :html-extension "html"
  ;;          :body-only t ;; Only export section between <body> </body>
  ;;          )

  ;;         ("org-static-ian"
  ;;          :base-directory org-directory
  ;;          :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|php"
  ;;          :publishing-directory org-directory
  ;;          :recursive t
  ;;          :publishing-function org-publish-attachment)

  ;;         ("ian" :components ("org-ianbarton" "org-static-ian"))
  ;;         ))

  (require 'org-protocol)
  (require 'org-protocol-capture-html)

  (add-to-list 'org-capture-templates
               '("w" "Web site" entry (file buffer-name)
                 "* %U %?\n\n%:initial" :empty-lines 1 :immediate-finish t :unarrowed t))


  ;; (require 'ox-latex)
  ;; (add-to-list 'org-latex-packages-alist '("" "listings"))
  ;; (add-to-list 'org-latex-packages-alist '("" "color"))
  ;; (setq org-latex-src-block-backend 'listings)

  (require 'ox-latex)
  (add-to-list 'org-latex-packages-alist '("newfloat" "minted"))
  (setq org-latex-src-block-backend 'minted)

  (setq org-tags-column -80
        org-log-done 'time

        ;; org agenda
        org-agenda-files (list (expand-file-name "gtd" org-directory))

        ;; org-noter
        org-noter-notes-search-path '("~/SynologyDrive/Org/notes")

        ;; org latex
        ;; org-latex-listings t ;; org-latex-src-block-backend
        org-latex-default-class "ctexart"
        org-latex-pdf-process '("latexmk -pdflatex='%latex  --shell-escape -interaction nonstopmode -synctex=1' -pdf -bibtex -outdir='%o' -f %f")
        org-format-latex-header "% xelatex
\\documentclass{article}
\\usepackage[usenames]{color}
\[PACKAGES]
\[DEFAULT-PACKAGES]
\\pagestyle{empty}             % do not remove
% The settings below are copied from fullpage.sty
\\setlength{\\textwidth}{\\paperwidth}
\\addtolength{\\textwidth}{-3cm}
\\setlength{\\oddsidemargin}{1.5cm}
\\addtolength{\\oddsidemargin}{-2.54cm}
\\setlength{\\evensidemargin}{\\oddsidemargin}
\\setlength{\\textheight}{\\paperheight}
\\addtolength{\\textheight}{-\\headheight}
\\addtolength{\\textheight}{-\\headsep}
\\addtolength{\\textheight}{-\\footskip}
\\addtolength{\\textheight}{-3cm}
\\setlength{\\topmargin}{1.5cm}
\\addtolength{\\topmargin}{-2.54cm}"
        org-latex-classes '(("beamer"
                             "\\documentclass[presentation]{beamer}"
                             ("\\section{%s}" . "\\section*{%s}")
                             ("\\subsection{%s}" . "\\subsection*{%s}")
                             ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
                            ("article" "\\documentclass[11pt]{article}"
                             ("\\section{%s}" . "\\section*{%s}")
                             ("\\subsection{%s}" . "\\subsection*{%s}")
                             ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                             ("\\paragraph{%s}" . "\\paragraph*{%s}")
                             ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
                            ("report" "\\documentclass[11pt]{report}"
                             ("\\part{%s}" . "\\part*{%s}")
                             ("\\chapter{%s}" . "\\chapter*{%s}")
                             ("\\section{%s}" . "\\section*{%s}")
                             ("\\subsection{%s}" . "\\subsection*{%s}")
                             ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
                            ("book" "\\documentclass[11pt]{book}"
                             ("\\part{%s}" . "\\part*{%s}")
                             ("\\chapter{%s}" . "\\chapter*{%s}")
                             ("\\section{%s}" . "\\section*{%s}")
                             ("\\subsection{%s}" . "\\subsection*{%s}")
                             ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
                            ("ctexbeamer"
                             "\\documentclass[presentation]{ctexbeamer}"
                             ("\\section{%s}" . "\\section*{%s}")
                             ("\\subsection{%s}" . "\\subsection*{%s}")
                             ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
                            ("ctexart" "\\documentclass[11pt]{ctexart}"
                             ("\\section{%s}" . "\\section*{%s}")
                             ("\\subsection{%s}" . "\\subsection*{%s}")
                             ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                             ("\\paragraph{%s}" . "\\paragraph*{%s}")
                             ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
                            ("ctexrep" "\\documentclass[11pt]{ctexrep}"
                             ("\\part{%s}" . "\\part*{%s}")
                             ("\\chapter{%s}" . "\\chapter*{%s}")
                             ("\\section{%s}" . "\\section*{%s}")
                             ("\\subsection{%s}" . "\\subsection*{%s}")
                             ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
                            ("ctexbook" "\\documentclass[11pt]{ctexbook}"
                             ("\\part{%s}" . "\\part*{%s}")
                             ("\\chapter{%s}" . "\\chapter*{%s}")
                             ("\\section{%s}" . "\\section*{%s}")
                             ("\\subsection{%s}" . "\\subsection*{%s}")
                             ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
                            ("ustcthesis" "\\documentclass{ustcthesis}
[NO-DEFAULT-PACKAGES]
[EXTRA]
[PACKAGES]\n"
                             ("\\chapter{%s}" . "\\chapter*{%s}")
                             ("\\section{%s}" . "\\section*{%s}")
                             ("\\subsection{%s}" . "\\subsection*{%s}")
                             ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                             ("\\paragraph{%s}" . "\\paragraph*{%s}")
                             ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
                            ("IEEEtran" "\\documentclass[]{IEEEtran}
[NO-DEFAULT-PACKAGES]
[EXTRA]
[PACKAGES]\n"
                             ("\\section{%s}" . "\\section*{%s}")
                             ("\\subsection{%s}" . "\\subsection*{%s}")
                             ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                             ("\\paragraph{%s}" . "\\paragraph*{%s}")
                             ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))))

(after! ox

  ;; @see https://emacs.stackexchange.com/questions/63895/switching-default-locale-of-orgmode-generated-output
  (defun org-export-dictionary--add-language (lang data)
    (unless (boundp 'org-export-dictionary)
      (require 'ox))
    (cl-loop for (string . entry) in data do
             (let ((current-entry (assoc string org-export-dictionary))
                   (new-entry (when entry (cons lang (if (stringp entry) (list :default entry) entry)))))
               (when (and new-entry current-entry)
                 (nconc (cdr current-entry) (list new-entry))))))

  (org-export-dictionary--add-language
   "zh-CN"
   '(("References" :html "&#21442;&#32771;&#25991;&#29486;" :utf-8 "参考文献")))

  ;; unicode convert @see https://www.sojson.com/unicode.html
  ;; (nconc (assoc "References" org-export-dictionary)
  ;;        '(("zh-CN" :html "&#21442;&#32771;&#25991;&#29486;" :utf-8 "参考文献")))
  )

;; --------------------------------
;; Org Ref version 3
;; --------------------------------
(after! bibtex-completion
  (setq bibtex-completion-bibliography
        (cl-remove-if-not (lambda (filename)
                            (equal "bib" (file-name-extension filename)))
                          (directory-files-recursively (expand-file-name "bib/" org-directory)
                                                       directory-files-no-dot-files-regexp))
        bibtex-completion-library-path (expand-file-name "bib/bibtex-pdfs/" org-directory)
        bibtex-completion-notes-path (expand-file-name "bib/notes/" org-directory)
        bibtex-completion-notes-template-multiple-files "* ${author-or-editor}, ${title}, ${journal}, (${year}) :${=type=}: \n\nSee [[cite:&${=key=}]]\n"

        bibtex-completion-additional-search-fields '(keywords)
        bibtex-completion-display-formats
        '((article       . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${journal:40}")
          (inbook        . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} Chapter ${chapter:32}")
          (incollection  . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${booktitle:40}")
          (inproceedings . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${booktitle:40}")
          (t             . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*}"))
        bibtex-completion-pdf-open-function
        (lambda (fpath)
          (call-process "open" nil 0 nil fpath))))

(use-package! org-ref
  ;; :ensure nil
  :defer t
  :after org
  :init
  (require 'bibtex)
  (setq bibtex-autokey-year-length 4
        bibtex-autokey-name-year-separator "-"
        bibtex-autokey-year-title-separator "-"
        bibtex-autokey-titleword-separator "-"
        bibtex-autokey-titlewords 2
        bibtex-autokey-titlewords-stretch 1
        bibtex-autokey-titleword-length 5)

  (define-key bibtex-mode-map (kbd "H-b") 'org-ref-bibtex-hydra/body)
  (define-key org-mode-map (kbd "C-c ]") 'org-ref-insert-link)
  (define-key org-mode-map (kbd "s-[") 'org-ref-insert-link-hydra/body)

  (when (modulep! :completion ivy)
    (require 'org-ref-ivy))
  (require 'org-ref-arxiv)
  (require 'org-ref-scopus)
  (require 'org-ref-wos)
  (require 'org-ref-pdf)
  (require 'org-ref-pdf)
  (require 'org-ref-url-utils)
  )

(use-package! org-ref-ivy
  ;; :ensure nil
  :init
  (setq org-ref-insert-link-function 'org-ref-insert-link-hydra/body
        org-ref-insert-cite-function 'org-ref-cite-insert-ivy
        org-ref-insert-label-function 'org-ref-insert-label-link
        org-ref-insert-ref-function 'org-ref-insert-ref-link
        org-ref-cite-onclick-function (lambda (_) (org-ref-citation-hydra/body))))

;; --------------------------------
;; Org Roam
;; --------------------------------

(use-package! org-roam-ui
  :config
  (progn
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t
          org-roam-db-update-on-save nil)
    ;;(org-roam-db-autosync-mode)
    (require 'org-roam-protocol)

    (setq org-roam-capture-templates
          '(("d" "default" plain "%?"
             :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                                "#+title: ${title}\n")
             :unnarrowed t)))
    (add-to-list 'org-roam-capture-templates
                 '("p" "Paper Note" plain
                   "* 相关工作\n\n%?\n* 观点\n\n* 模型和方法\n\n* 实验\n\n* 结论\n"
                   :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags:\n\n")
                   :unarrowed t))
    (setq org-roam-capture-ref-templates
          '(("r" "ref" plain "%?" :target
             (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}")
             :immediate-finish t
             :jump-to-captured t)))
    ))

;; (add-load-path! "/usr/local/opt/mu/share/emacs/site-lisp/mu/mu4e/")
;; (after! mu4e
;;   (setq mu4e-maildir "~/.maildir/")

;;   (setq mu4e-maildir-shortcuts
;;         '((:maildir "/ustc/INBOX" :key ?i)
;;           (:maildir "/163/INBOX" :key ?I)
;;           ))

;;   (require 'smtpmail)
;;   (set-email-account! "ustc"
;;                       '((user-mail-address . "cjuns@ustc.edu.cn")
;;                         (user-full-name . "Jun-Shi Chen")
;;                         (mu4e-sent-folder . "/ustc/Sent Items")
;;                         (mu4e-drafts-folder . "/ustc/Drafts")
;;                         (mu4e-trash-folder . "/ustc/Trash")
;;                         ;; (smtpmail-smtp-user . "cjuns@ustc.edu.cn")
;;                         ;; (smtpmail-smtp-server . "mail.ustc.edu.cn")
;;                         ;; (smtpmail-smtp-service . 465)
;;                         )
;;                       t)

;;   (set-email-account! "163"
;;                       '((user-mail-address . "cjshappy@163.com")
;;                         (user-full-name . "Jun-Shi Chen")
;;                         (mu4e-sent-folder . "/163/Sent")
;;                         (mu4e-drafts-folder . "/163/Drafts")
;;                         (mu4e-trash-folder . "/163/Deleted Messages")
;;                         ;; (smtpmail-smtp-user . "cjshappy")
;;                         ;; (smtpmail-smtp-server . "smtp.163.com")
;;                         ;; (smtpmail-smtp-service . 25)
;;                         ;; (smtpmail-mail-address . "cjshappy@163.com")
;;                         )
;;                       nil)

;;   ;; send function
;;   (setq send-mail-function 'sendmail-send-it
;;         message-send-mail-function 'sendmail-send-it)

;;   ;; send program
;;   (setq sendmail-program (executable-find "msmtp"))

;;   ;; select the right sender email from the context
;;   (setq message-sendmail-envelope-from 'header)

;;   (add-hook 'mu4e-compose-mode-hook 'company-mode)
;;   )

;; --------------------------------
;; Python
;; --------------------------------
(setq +python-ipython-repl-args '("-i" "--simple-prompt" "--no-color-info"))
(setq +python-jupyter-repl-args '("--simple-prompt"))
(setq org-babel-default-header-args:jupyter-python '((:session . "py")
                                                     (:kernel . "python3")))
;; --------------------------------
;; Key map
;; --------------------------------
(map! :ne "M-/" #'comment-or-uncomment-region)

;; (defun mu4e-goodies~break-cjk-word (word)
;;   "Break CJK word into list of bi-grams like: 我爱你 -> 我爱 爱你"
;;   (if (or (<= (length word) 2)
;;           (equal (length word) (string-bytes word))) ; only ascii chars
;;       word
;;     (let ((pos nil)
;;           (char-list nil)
;;           (br-word nil))
;;       (if (setq pos (string-match ":" word))     ; like: "s:abc"
;;           (concat (substring word 0 (+ 1 pos))
;;                   (mu4e-goodies~break-cjk-word (substring word (+ 1 pos))))
;;         (if (memq 'ascii (find-charset-string word)) ; ascii mixed with others like: abc你好
;;             word
;;           (progn
;;             (setq char-list (split-string word "" t))
;;             (while (cdr char-list)
;;               (setq br-word (concat br-word (concat (car char-list) (cadr char-list)) " "))
;;               (setq char-list (cdr char-list)))
;;             br-word))))))

;; (defun mu4e-goodies~break-cjk-query (expr)
;;   "Break CJK strings into bi-grams in query."
;;   (let ((word-list (split-string expr " " t))
;;         (new ""))
;;     (dolist (word word-list new)
;;       (setq new (concat new (mu4e-goodies~break-cjk-word word) " ")))))

;; (setq mu4e-query-rewrite-function 'mu4e-goodies~break-cjk-query)

;; Lsp
(setq lsp-clients-clangd-args '("-j=3"
                                "--background-index"
                                "--clang-tidy"
                                "--completion-style=detailed"
                                "--header-insertion=never"
                                "--header-insertion-decorators=0"))
(after! lsp-clangd (set-lsp-priority! 'clangd 2))

(after! evil (evil-ex-define-cmd "sus" #'suspend-frame))

;; spell
;; @see https://emacs.stackexchange.com/questions/21378/spell-check-with-multiple-dictionaries
(after! ispell
  ;; (setq ispell-program-name "hunspell")
  ;; you could set `ispell-dictionary` instead but `ispell-local-dictionary' has higher priority
  (setq ispell-local-dictionary "en_US")
  (setq ispell-local-dictionary-alist '(("en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "en_US") nil utf-8)))
  ;; new variable `ispell-hunspell-dictionary-alist' is defined in Emacs
  ;; If it's nil, Emacs tries to automatically set up the dictionaries.
  (when (boundp 'ispell-hunspell-dictionary-alist)
    (setq ispell-hunspell-dictionary-alist ispell-local-dictionary-alist)))

;; --------------------------------
;; Citar
;; --------------------------------
(setq citar-bibliography bibtex-completion-bibliography)

;; (unless (server-running-p)
;;   (server-start))

;; @see https://macowners.club/posts/org-capture-from-everywhere-macos/
(require 'noflet)

(defun timu-func-make-capture-frame ()
  "Create a new frame and run `org-capture'."
  (interactive)
  (make-frame '((name . "capture")
                (top . 300)
                (left . 700)
                (width . 80)
                (height . 25)))
  (select-frame-by-name "capture")
  (delete-other-windows)
  (noflet ((switch-to-buffer-other-window (buf) (switch-to-buffer buf)))
    (org-capture)))

(defadvice org-capture-finalize
    (after delete-capture-frame activate)
  "Advise capture-finalize to close the frame."
  (if (equal "capture" (frame-parameter nil 'name))
      (delete-frame)))

(defadvice org-capture-destroy
    (after delete-capture-frame activate)
  "Advise capture-destroy to close the frame."
  (if (equal "capture" (frame-parameter nil 'name))
      (delete-frame)))

(defun timu-func-url-safari-capture-to-org ()
  "Call `org-capture-string' on the current front most Safari window.
Use `org-mac-link-safari-get-frontmost-url' to capture url from Safari.
Triggered by a custom macOS Quick Action with a keyboard shortcut."
  (interactive)
  (org-capture-string (org-mac-link-safari-get-frontmost-url) "u")
  (ignore-errors)
  (org-capture-finalize))

(add-to-list 'org-capture-templates
             '("u" "URL capture from safari" entry
               (file+olp+datetree org-default-notes-file)
               "* %i    :safari:url:\n%U\n\n"))

;;;; capture and/or org-yank from macos clipboard
;; credit: http://www.howardism.org/Technical/Emacs/capturing-content.html
;; credit: https://gitlab.com/howardabrams/spacemacs.d/-/tree/master/layers
(defun timu-func-cmd-with-exit-code (program &rest args)
  "Run PROGRAM with ARGS and return the exit code and output in a list."
  (with-temp-buffer
    (list (apply 'call-process program nil (current-buffer) nil args)
          (buffer-string))))

(defun timu-func-convert-applescript-to-html (contents)
  "Return the Applescript's clipboard CONTENTS in a packed array.
Convert and return this encoding into a UTF-8 string."
  (cl-flet ((hex-pack-bytes (tuple)
                            (string-to-number (apply 'string tuple) 16)))
    (let* ((data (-> contents (substring 10 -2) (string-to-list)))
           (byte-seq (->> data (-partition 2) (mapcar #'hex-pack-bytes))))
      (decode-coding-string
       (mapconcat #'byte-to-string byte-seq "") 'utf-8))))

(defun timu-func-get-mac-clipboard ()
  "Return a list where the first entry is the either :html or :text.
The second is the clipboard contents."
  (cl-destructuring-bind (exit-code contents)
      (timu-func-cmd-with-exit-code
       "/usr/bin/osascript" "-e" "the clipboard as \"HTML\"")
    (if (= 0 exit-code)
        (list :html (timu-func-convert-applescript-to-html contents))
      (list :text (shell-command-to-string
                   "/usr/bin/osascript -e 'the clipboard'")))))

(defun timu-func-org-clipboard ()
  "Return the contents of the clipboard in `org-mode' format."
  (cl-destructuring-bind (type contents) (timu-func-get-mac-clipboard)
    (with-temp-buffer
      (insert contents)
      (if (eq :html type)
          (shell-command-on-region
           (point-min) (point-max)
           (concat (executable-find "pandoc") " -f html -t org --wrap=none") t t)
        (shell-command-on-region
         (point-min) (point-max)
         (concat (executable-find "pandoc") " -f markdown -t org --wrap=none") t t))
      (buffer-substring-no-properties (point-min) (point-max)))))

(defun timu-func-org-yank-clipboard ()
  "Yank the contents of the Mac clipboard in an `org-mode' compatible format."
  (interactive)
  (insert (timu-func-org-clipboard)))

(defun timu-func-safari-capture-to-org ()
  "Call `org-capture-string' on the contents of the Apple clipboard.
Use `org-mac-link-safari-get-frontmost-url' to capture content from Safari.
Triggered by a custom macOS Quick Action with keybinding."
  (interactive)
  (org-capture-string (timu-func-org-clipboard) "s")
  (ignore-errors)
  (insert (org-mac-link-safari-get-frontmost-url))
  (org-capture-finalize))

(add-to-list 'org-capture-templates
             '("s" "macOS Safari clipboard capture" entry
               (file+olp+datetree org-default-notes-file)
               "* %?    :safari:note:\n%U\n\n%i\n"))
