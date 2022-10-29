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

.hljs-deletion, .hljs-formula, .hljs-keyword, .hljs-link, .hljs-selector-tag {
  color: var(--gruvbox-light-red);
}

.hljs-built_in, .hljs-emphasis, .hljs-name, .hljs-quote, .hljs-strong, .hljs-title, .hljs-variable {
  color: var(--gruvbox-light-blue);
}

.hljs-attr, .hljs-params, .hljs-template-tag, .hljs-type {
  color: var(--gruvbox-light-yellow);
}

.hljs-builtin-name, .hljs-doctag, .hljs-literal, .hljs-number {
  color: var(--gruvbox-light-purple);
}

.hljs-code, .hljs-meta, .hljs-regexp, .hljs-selector-id, .hljs-template-variable {
  color: var(--gruvbox-light-orange);
}

.hljs-addition, .hljs-meta-string, .hljs-section, .hljs-selector-attr, .hljs-selector-class, .hljs-string, .hljs-symbol {
  color: var(--gruvbox-light-green);
}

.hljs-attribute, .hljs-bullet, .hljs-class, .hljs-function, .hljs-function .hljs-keyword, .hljs-meta-keyword, .hljs-selector-pseudo, .hljs-tag {
  color: var(--gruvbox-light-aqua);
}

.hljs-comment {
  color: var(--gruvbox-gray);
}

.hljs-link_label, .hljs-literal, .hljs-number {
  color: var(--gruvbox-light-purple);
}

.hljs-comment, .hljs-emphasis {
  font-style: italic;
}

.hljs-section, .hljs-strong, .hljs-tag {
  font-weight: bold;
}
`;
GM_addStyle(theme);
