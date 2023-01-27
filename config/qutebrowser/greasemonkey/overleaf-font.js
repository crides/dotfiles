// ==UserScript==
// @name Overleaf source font
// @version 1.0.0
// @description Overleaf source font
// @author crides
// @license MIT
// @grant GM_addStyle
// @run-at document-loaded
// @include https://www.overleaf.com/*
// ==/UserScript==

theme = `
@font-face {
  font-family: "I0sevka Term";
  font-weight: 300;
  font-style: normal;
}

:root {
    --gruvbox-red:    #cc231d;
    --gruvbox-green:  #98971a;
    --gruvbox-yellow: #d79921;
    --gruvbox-blue:   #458588;
    --gruvbox-purple: #b16285;
    --gruvbox-aqua:   #689d9a;
    --gruvbox-orange: #d65e0e;
    --gruvbox-light-red:    #fb4834;
    --gruvbox-light-green:  #b8bb26;
    --gruvbox-light-yellow: #fabd2f;
    --gruvbox-light-blue:   #83a598;
    --gruvbox-light-purple: #d3869a;
    --gruvbox-light-aqua:   #8ec07c;
    --gruvbox-light-orange: #fe8019;

    --gruvbox-bg0-h: #1d2021;
    --gruvbox-bg0: #282828;
    --gruvbox-bg0-s: #32302f;
    --gruvbox-bg1: #3c3836;
    --gruvbox-bg2: #504945;
    --gruvbox-bg3: #665c54;
    --gruvbox-bg4: #7c6f64;
    --gruvbox-gray: #928374;
    --gruvbox-fg4: #a89984;
    --gruvbox-fg3: #bdae93;
    --gruvbox-fg2: #d5c4a1;
    --gruvbox-fg1: #ebdbb2;
    --gruvbox-fg0-s: #f2e5bc;
    --gruvbox-fg0: #fbf1c7;
    --gruvbox-fg0-h: #f9f5d7;

    --gruvbox-bg: var(--gruvbox-bg0);
    --gruvbox-bg-h: var(--gruvbox-bg0-h);
    --gruvbox-bg-s: var(--gruvbox-bg0-s);
    --gruvbox-fg: var(--gruvbox-fg1);

    --ol-blue: var(--gruvbox-bg0-s);
    --ol-blue-gray-0: var(--gruvbox-fg0);
    --ol-blue-gray-1: var(--gruvbox-fg);
    --ol-blue-gray-2: var(--gruvbox-gray);
    --ol-blue-gray-3: var(--gruvbox-bg2);
    --ol-blue-gray-4: var(--gruvbox-bg-s);
    --ol-blue-gray-5: var(--gruvbox-bg);
    --ol-blue-gray-6: var(--gruvbox-bg-h);
    --input-color: var(--gruvbox-bg2);
    --input-border: var(--gruvbox-fg4);
    --input-border-focus: var(--gruvbox-bg3);
    --btn-default-bg: var(--gruvbox-bg-s);
}

body { color: var(--gruvbox-fg4); }
.toolbar.toolbar-header { background-color: var(--gruvbox-bg-h); }
.toolbar.toolbar-editor, .file-tree .toolbar.toolbar-filetree, .outline-header, .pdf .toolbar.toolbar-pdf {
    background-color: var(--gruvbox-bg);
}
.outline-body, .outline-container, .editor-sidebar, .outline-item-expand-collapse-btn {
    background-color: var(--gruvbox-bg1);
}
.btn-secondary:not(.btn-secondary-info) { background-color: var(--gruvbox-bg1); }
.ui-layout-resizer, .vertical-resizable-resizer {
    background-color: var(--gruvbox-bg);
}

.formatting-btn {
    background-color: var(--gruvbox-bg);
    border-left-color: var(--gruvbox-bg);
    border-right-color: var(--gruvbox-bg);
}

.custom-toggler {
    background-color: var(--gruvbox-bg3);
}
`;

editor_theme = (c) => `
.${c}.cm-editor, .${c}.cm-content { --source-font-family: "I0sevka Term"; }
.${c} .tok-attributeValue {
    color: var(--gruvbox-blue);
}

.${c} .tok-typeName {
    color: var(--gruvbox-green);
}

.${c} .tok-keyword {
    color: var(--gruvbox-aqua);
}

.${c} .tok-comment {
    color: var(--gruvbox-gray);
}

.${c} .tok-literal {
    color: var(--gruvbox-red);
}

.${c} .tok-string {
    color: var(--gruvbox-yellow);
}

.${c} {
    color: var(--gruvbox-fg);
}

.${c} .cm-completionMatchedText {
    color: var(--gruvbox-light-green);
}

.${c} .cm-tooltip.cm-tooltip-autocomplete {
    color: var(--gruvbox-fg3);
}
`;
// let classes = document.getElementsByClassName("ͼ1")[0].classList.filter(cls => cls != "cm-editor");
let classes = _.range(180).map(n => "ͼ" + n.toString(36));
editor_themes = classes.map(editor_theme).join("\n");
GM_addStyle(theme + editor_themes);
