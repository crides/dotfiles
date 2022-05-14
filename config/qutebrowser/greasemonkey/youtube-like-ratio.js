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
    appended.textContent = "/ " + (views / likes).toFixed(2);
}

observed = false;

document.addEventListener('load', () => {
    const view_text = document.querySelector("ytd-video-view-count-renderer span");
    const like_text = document.querySelector("yt-formatted-string#text.ytd-toggle-button-renderer");
    if (view_text === null || like_text === null) {
        return;
    }
    if (!observed) {
        const observer = new MutationObserver(list => {
            update_count(view_text, like_text);
        });
        observer.observe(like_text, {attributeFilter: ["aria-label"]});
        update_count(view_text, like_text);
    }
}, true);
