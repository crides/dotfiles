// ==UserScript==
// @name         Display YouTube like ratio
// @version      1.0.0
// @description  Display YouTube like ratio
// @author       crides
// @match        *://*.youtube.com/*
// ==/UserScript==
function convert_number(_s) {
    const s = _s.replaceAll(/,/g, "");
    if (s.includes("K")) {
        return (s.replace(/\s*K/, "") - 0) * 1000;
    }
    if (s.includes("M")) {
        return (s.replace(/\s*M/, "") - 0) * 1000000;
    }
    if (s.includes("B")) {
        return (s.replace(/\s*B/, "") - 0) * 1000000000;
    }
    return s - 0;
}

function update_count() {
    const appended_id = "yt-view-like-ratio-appended";
    const views = convert_number(document.querySelector("#info.ytd-watch-metadata").children[0].textContent.replace(/\s*views.*/, ""));
    const likes = convert_number(document.querySelector("#segmented-like-button span[role=\"text\"]").textContent);
    appended = document.querySelector("#" + appended_id);
    if (appended === null) {
        const like_box = document.querySelector("#segmented-like-button div.cbox");
        appended = document.createElement("span");
        appended.id = appended_id;
        appended.style.paddingLeft = "0.5em";
        like_box.appendChild(appended);
    }
    appended.textContent = "/" + String.fromCharCode(160) + (views / likes).toFixed(2);
}

observed = false;

document.addEventListener('load', () => {
    if (!observed) {
        update_count();
    }
}, true);
