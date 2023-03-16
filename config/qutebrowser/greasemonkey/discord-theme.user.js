// ==UserScript==
// @name Discord Gruvbox theme
// @version 1.0.4
// @description Discord Gruvbox theme
// @author crides
// @license MIT
// @grant GM_addStyle
// @run-at document-loaded
// @include https://discord.com/*
// ==/UserScript==

theme = `
@font-face {
  font-family: "Iosevka Term";
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
  --gruvbox-gray: #928374;
  --gruvbox-fg0: #fbf1c7;
  --gruvbox-fg: #ebdbb2;
  --gruvbox-bg: #282828;
  --gruvbox-bg-h: #1d2021;
  --gruvbox-bg-s: #32302f;
  --font-mono: "Iosevka Term";

  --interactive-normal: var(--gruvbox-fg);
  --text-normal: var(--gruvbox-fg);
  --channels-default: var(--gruvbox-fg);
  --deprecated-panel-background: var(--gruvbox-bg);
  --channeltextarea-background: var(--gruvbox-bg);

  --background-primary: var(--gruvbox-bg-h);
  --background-secondary: var(--gruvbox-bg);
  --background-secondary-alt: var(--gruvbox-bg-s);
  --background-accent: var(--gruvbox-gray);
  --brand-experiment-360: var(--gruvbox-blue);
  --brand-experiment-30a: var(--gruvbox-blue);
  --brand-experiment-200: var(--gruvbox-fg0);
  --control-brand-foreground: var(--gruvbox-blue);
  --text-link: var(--gruvbox-blue);
  --font-code: Iosevka Term;
  --font-primary: Iosevka Term;
  --font-display: var(--font-primary);
  --font-headline: var(--font-primary);
  --header-primary: var(--gruvbox-fg0);
  --header-secondary: var(--gruvbox-fg);
  --text-muted: var(--gruvbox-gray);
  --interactive-active: var(--gruvbox-fg0);
  --status-positive-background: var(--gruvbox-green);
  --status-danger-background: var(--gruvbox-light-red);
  --status-warning-background: var(--gruvbox-light-yellow);
}

img.emoji {
  width: 1.5rem;
  height: 1.5rem;
}

.barButtonBase-2uLO1z {
  color: var(--gruvbox-fg);
}

.form-2fGMdU:before {
  background: none;
}

.theme-dark .children-19S4PO:after {
  background: none;
}

.strikethrough-1n4ekb, #---new-messages-bar {
  color: var(--gruvbox-light-red);
}

.unreadPill-2HyYtt {
  background-color: var(--gruvbox-light-red);
}

.newMessagesBar-265mhP {
  background-color: var(--gruvbox-blue);
  color: var(--gruvbox-fg);
}

.scroller-1Bvpku, .searchHeader-2XoQg7 {
  background-color: var(--gruvbox-bg-h);
}

.focused-3afm-j.colorDefault-2K3EoJ {
  background-color: var(--gruvbox-blue);
}

.focused-3afm-j.colorDanger-2qLCe1 {
  background-color: var(--gruvbox-light-red);
}

.colorDanger-2qLCe1 {
  color: var(--gruvbox-light-red);
}

.colorPremium-p4p7qO {
  color: var(--gruvbox-purple);
}

code {
  font-family: Iosevka Term;
}

.markup-eYLPri code.inline {
  font-family: Iosevka Term;
}

code, .menu-3sdvDG {
  background-color: var(--gruvbox-bg);
}

.theme-dark .scroller-3X7KbA {
    background-color: var(--gruvbox-bg-h);
}

.scroller-kQBbkU {
    background-color: var(--gruvbox-bg-h);
}

/* .content-3YMskv, .peopleList-3c4jOR, .tree-2wKJdG, .chat-3bRxxu, .scroller-1Bvpku, .scrollerBase-289Jih, .content-1o0f9g { */
/*   background-color: var(--gruvbox-bg-h); */
/* } */

/* .container-3w7J-x, .menu-3sdvDG, .wrapper-2aW0bm, .title-3qD0b-, .container-3baos1, .reactionInner-15NvIl { */
/*   background-color: var(--gruvbox-bg); */
/* } */

.name-uJV0GL, .username-1A8OIy, div.view-lines, .mention {
  font-family: Iosevka Term;
  font-weight: 400;
}

.replyBar-1YLQ2F {
  background-color: var(--gruvbox-bg-s);
}

.text-1y-e8- strong {
  font-family: Iosevka Term;
  font-weight: 400;
}

/* CSS below this comment is from highlight.js gruvbox-dark theme.
https://github.com/highlightjs/highlight.js/blob/master/src/styles/gruvbox-dark.css

This CSS makes code blocks within Discord match gruvbox.

hightlight.js is copyright 2006 Ivan Sagalaev and licensed under the BSD 3-clause license,
as specified here: https://github.com/highlightjs/highlight.js/blob/master/LICENSE            */

.theme-dark .hljs-deletion, .theme-dark .hljs-formula, .theme-dark .hljs-keyword, .theme-dark .hljs-link, .theme-dark .hljs-selector-tag {
  color: var(--gruvbox-red);
}

.theme-dark .hljs-builtin-name, .theme-dark .hljs-built_in {
  color: var(--gruvbox-light-purple);
}

.theme-dark .hljs-emphasis, .theme-dark .hljs-name, .theme-dark .hljs-quote, .theme-dark .hljs-strong, .theme-dark .hljs-title, .theme-dark .hljs-variable, .theme-dark .hljs-title.class_, .theme-dark .hljs-title.class_.inherited__, .theme-dark .hljs-title.function_ {
  color: var(--gruvbox-blue);
}

.theme-dark .hljs-attr, .theme-dark .hljs-params, .theme-dark .hljs-template-tag, .theme-dark .hljs-type {
  color: var(--gruvbox-yellow);
}

 .theme-dark .hljs-doctag, .theme-dark .hljs-literal, .theme-dark .hljs-number {
  color: var(--gruvbox-light-purple);
}

.theme-dark .hljs-code, .theme-dark .hljs-meta, .theme-dark .hljs-regexp, .theme-dark .hljs-selector-id, .theme-dark .hljs-template-variable {
  color: var(--gruvbox-orange);
}

.theme-dark .hljs-addition, .theme-dark .hljs-meta-string, .theme-dark .hljs-section, .theme-dark .hljs-selector-attr, .theme-dark .hljs-selector-class, .theme-dark .hljs-string, .theme-dark .hljs-symbol {
  color: var(--gruvbox-green);
}

.theme-dark .hljs-attribute, .theme-dark .hljs-bullet, .theme-dark .hljs-class, .theme-dark .hljs-function, .theme-dark .hljs-function .theme-dark .hljs-keyword, .theme-dark .hljs-meta-keyword, .theme-dark .hljs-selector-pseudo, .theme-dark .hljs-tag {
  color: var(--gruvbox-aqua);
}

.theme-dark .hljs-comment {
  color: var(--gruvbox-gray);
}

.theme-dark .hljs-link_label {
  color: var(--gruvbox-light-purple);
}

.theme-dark .hljs-comment, .theme-dark .hljs-emphasis {
  font-style: italic;
}

.theme-dark .hljs-section, .theme-dark .hljs-strong, .theme-dark .hljs-tag {
  font-weight: bold;
}
`;
GM_addStyle(theme);
