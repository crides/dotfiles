// ==UserScript==
// @name         Auto Skip YouTube Ads
// @version      1.0.0
// @description  Speed up and skip YouTube ads automatically
// @author       jso8910
// @match        *://*.youtube.com/*
// @exclude      *://*.youtube.com/subscribe_embed?*
// ==/UserScript==
document.addEventListener('load', () => {
    try { document.querySelector('.ad-showing video').currentTime = 99999 } catch {}
    try { document.querySelector('.videoAdUiSkipButton,.ytp-ad-skip-button').click() } catch {}
    const text_ad = [...document.querySelectorAll('.ytp-ad-text-overlay')][0];
    if (text_ad) {
        text_ad.hidden = true;
    }
}, true);
