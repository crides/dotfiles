// ==UserScript==
// @name         Display YouTube like ratio
// @version      1.0.0
// @description  Display YouTube like ratio
// @author       crides
// @match        *://*.youtube.com/*
// ==/UserScript==
function update_count(view_text, like_text) {
    const appended_id = "yt-view-like-ratio-appended";
    const views = view_text.textContent.replace(/ views$/, "").replaceAll(",", "") - 0;
    const likes = like_text.attributes["aria-label"].value.replace(/ likes$/, "").replaceAll(",", "") - 0;
    appended = document.querySelector("#" + appended_id);
    if (appended === null) {
        like_par = like_text.parentNode;
        appended = document.createElement("span");
        appended.id = appended_id;
        appended.style.paddingLeft = "0.5em";
        if (like_par.childElementCount < 3) {
            like_par.appendChild(appended);
        } else {
            like_par.insertBefore(appended, like_par.lastChild);
        }
    }
    appended.textContent = "/" + String.fromCharCode(160) + (views / likes).toFixed(2);
}

observed = false;

document.addEventListener('load', () => {
    if (!observed) {
        const view_text = document.querySelector("ytd-video-view-count-renderer span");
        const like_bar = document.querySelectorAll("yt-formatted-string#text.ytd-toggle-button-renderer");
        if (view_text === null || like_bar.length === 0) {
            return;
        }
        like_bar[like_bar.length - 1].hidden = true;
        const observer = new MutationObserver(list => {
            update_count(view_text, like_bar[like_bar.length - 2]);
        });
        observer.observe(like_bar[like_bar.length - 2], {attributeFilter: ["aria-label"]});
        update_count(view_text, like_bar[like_bar.length - 2]);
        observed = true;
    }
}, true);
